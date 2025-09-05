import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';

import '../../../api/api_client.dart';
import '../../../models/dexchange_models.dart';
import '../../../repositories/user_repository.dart';

class PaymentController extends GetxController {
  final logger = Logger();
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isPollingPayment = false.obs;

  // DEXCHANGE specific observables
  final Rx<DexchangeCountry> selectedCountry = DexchangeCountry.senegal.obs;
  final Rx<DexchangePaymentMethod?> selectedPaymentMethod =
      Rx<DexchangePaymentMethod?>(null);
  final RxList<DexchangePaymentMethodInfo> availablePaymentMethods =
      <DexchangePaymentMethodInfo>[].obs;
  final Rx<DexchangePaymentInstructions?> paymentInstructions =
      Rx<DexchangePaymentInstructions?>(null);

  Map<String, dynamic>? bookingData;
  final UserRepository _userRepository = UserRepository();
  final ApiClient _apiClient = Get.find<ApiClient>();
  Booking? booking;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      // Extract booking data from arguments
      if (Get.arguments is Booking) {
        booking = Get.arguments as Booking;
        amount.value = _calculateTotalPrice(booking);
      } else if (Get.arguments is Map<String, dynamic>) {
        final args = Get.arguments as Map<String, dynamic>;

        // Handle amount
        if (args.containsKey('amount')) {
          amount.value = (args['amount'] as num?)?.toDouble() ?? 0.0;
        }
        if (args.containsKey('price')) {
          amount.value = (args['price'] as num?)?.toDouble() ?? 0.0;
        }

        // Handle booking data (check both 'booking' and 'bookingData' keys)
        if (args.containsKey('booking')) {
          booking = args['booking'] as Booking?;
        } else if (args.containsKey('bookingData')) {
          final bookingDataMap = args['bookingData'] as Map<String, dynamic>?;
          if (bookingDataMap != null) {
            try {
              booking = Booking.fromJson(bookingDataMap);
            } catch (e) {
              print('Error creating booking from bookingData: $e');
              // Store raw booking data if Booking.fromJson fails
              bookingData = bookingDataMap;
            }
          }
        }

        // If we have booking but no explicit amount, calculate from booking
        if (booking != null && amount.value == 0.0) {
          amount.value = _calculateTotalPrice(booking);
        }
      }

      // Log for debugging
      print('PaymentController initialized with amount: ${amount.value}');
      print(
        'PaymentController booking: ${booking != null ? 'present' : 'null'}',
      );
      print(
        'PaymentController bookingData: ${bookingData != null ? 'present' : 'null'}',
      );
    }

    // Load available payment methods on initialization
    loadAvailablePaymentMethods();
  }

  /// Calculate total price based on booking data
  double _calculateTotalPrice(Booking? booking) {
    if (booking == null) return 0.0;

    final seatsBooked = booking.seatsBooked ?? 1;
    final pricePerSeat = booking.rideInstance?.ride?.price ?? 0;

    return (seatsBooked * pricePerSeat).toDouble();
  }

  void clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }

  /// Load available payment methods for selected country from your backend
  Future<void> loadAvailablePaymentMethods() async {
    try {
      isLoading.value = true;
      clearMessages();

      logger.d(
        'DEXCHANGE: Loading payment methods for country: ${selectedCountry.value.name.toUpperCase()}',
      );

      // Call your existing API to get payment methods
      // This should call your backend endpoint: GET /api/v1/payments/methods/{country}
      final response = await _apiClient.dio.get(
        '/payments/methods/${selectedCountry.value.name.toUpperCase()}',
      );

      logger.d('DEXCHANGE: Payment methods API response: ${response.data}');

      if (response.statusCode == 200) {
        // Handle different possible response structures
        List<dynamic> methods = [];

        if (response.data is Map<String, dynamic>) {
          // If response has success field
          if (response.data['success'] == true) {
            methods = response.data['data'] ?? response.data['methods'] ?? [];
          } else {
            // If no success field, try to get methods directly
            methods =
                response.data['data'] ??
                response.data['methods'] ??
                response.data ??
                [];
          }
        } else if (response.data is List) {
          // If response is directly a list
          methods = response.data;
        }

        logger.d('DEXCHANGE: Parsed methods: $methods');

        if (methods.isNotEmpty) {
          availablePaymentMethods.value =
              methods
                  .map(
                    (m) => DexchangePaymentMethodInfo.fromJson(
                      m as Map<String, dynamic>,
                    ),
                  )
                  .toList();

          logger.d(
            'DEXCHANGE: Loaded ${availablePaymentMethods.length} payment methods',
          );

          // Auto-select first available method if none selected
          if (availablePaymentMethods.isNotEmpty &&
              selectedPaymentMethod.value == null) {
            final firstMethod = availablePaymentMethods.first;
            selectedPaymentMethod.value = getPaymentMethodFromOperator(
              firstMethod.operator,
            );
            logger.d(
              'DEXCHANGE: Auto-selected payment method: ${selectedPaymentMethod.value}',
            );
          }
        } else {
          logger.w('DEXCHANGE: No payment methods found in response');
          errorMessage.value =
              'Aucune méthode de paiement disponible pour ce pays';
        }
      } else {
        logger.e('DEXCHANGE: API returned status ${response.statusCode}');
        errorMessage.value =
            'Erreur lors du chargement des méthodes de paiement (${response.statusCode})';
      }
    } catch (e) {
      logger.e('DEXCHANGE: Error loading payment methods: $e');
      errorMessage.value =
          'Erreur lors du chargement des méthodes de paiement: ${e.toString()}';

      // If API fails, provide fallback payment methods for testing
      _loadFallbackPaymentMethods();
    } finally {
      isLoading.value = false;
    }
  }

  /// Load fallback payment methods if API fails (for development/testing)
  void _loadFallbackPaymentMethods() {
    logger.d('DEXCHANGE: Loading fallback payment methods');

    final fallbackMethods = [
      DexchangePaymentMethodInfo(
        code: 'OM_${selectedCountry.value.name.toUpperCase()}_CASHOUT',
        operator: 'orange',
        displayName: 'Orange Money',
        country: selectedCountry.value.name.toUpperCase(),
      ),
      DexchangePaymentMethodInfo(
        code: 'WAVE_${selectedCountry.value.name.toUpperCase()}_CASHOUT',
        operator: 'wave',
        displayName: 'Wave',
        country: selectedCountry.value.name.toUpperCase(),
      ),
    ];

    // Only add methods that are available in the selected country
    if (selectedCountry.value == DexchangeCountry.senegal) {
      fallbackMethods.addAll([
        DexchangePaymentMethodInfo(
          code: 'FREE_SN_CASHOUT',
          operator: 'free',
          displayName: 'Free Money',
          country: 'SN',
        ),
        DexchangePaymentMethodInfo(
          code: 'WIZALL_SN_CASHOUT',
          operator: 'wizall',
          displayName: 'Wizall Money',
          country: 'SN',
        ),
      ]);
    }

    if (selectedCountry.value == DexchangeCountry.ivoryCoast ||
        selectedCountry.value == DexchangeCountry.cameroon) {
      fallbackMethods.add(
        DexchangePaymentMethodInfo(
          code: 'MTN_${selectedCountry.value.name.toUpperCase()}_CASHOUT',
          operator: 'mtn',
          displayName: 'MTN Money',
          country: selectedCountry.value.name.toUpperCase(),
        ),
      );
    }

    if (selectedCountry.value == DexchangeCountry.mali ||
        selectedCountry.value == DexchangeCountry.ivoryCoast) {
      fallbackMethods.add(
        DexchangePaymentMethodInfo(
          code: 'MOOV_${selectedCountry.value.name.toUpperCase()}_CASHOUT',
          operator: 'moov',
          displayName: 'Moov Money',
          country: selectedCountry.value.name.toUpperCase(),
        ),
      );
    }

    availablePaymentMethods.value = fallbackMethods;

    // Auto-select first method
    if (fallbackMethods.isNotEmpty && selectedPaymentMethod.value == null) {
      selectedPaymentMethod.value = getPaymentMethodFromOperator(
        fallbackMethods.first.operator,
      );
    }

    logger.d(
      'DEXCHANGE: Loaded ${fallbackMethods.length} fallback payment methods',
    );
  }

  /// Set selected country and reload payment methods
  Future<void> setCountry(DexchangeCountry country) async {
    if (selectedCountry.value != country) {
      selectedCountry.value = country;
      selectedPaymentMethod.value = null;
      await loadAvailablePaymentMethods();
    }
  }

  /// Set selected payment method
  void setPaymentMethod(DexchangePaymentMethod method) {
    selectedPaymentMethod.value = method;
    clearMessages();
  }

  /// DEXCHANGE: Replace CinetPay booking and payment flow
  Future<void> handleBookAndPay(Booking bookingRequestData) async {
    try {
      isLoading.value = true;
      clearMessages();

      final currentUser = _userRepository.getCurrentUser();
      if (currentUser == null || currentUser.id == null) {
        errorMessage.value =
            'Utilisateur non connecté. Veuillez vous reconnecter.';
        isLoading.value = false;
        return;
      }

      if (bookingRequestData.rideInstanceId == null) {
        errorMessage.value = 'ID de trajet manquant. Veuillez réessayer.';
        isLoading.value = false;
        return;
      }

      if (selectedPaymentMethod.value == null) {
        errorMessage.value = 'Veuillez sélectionner une méthode de paiement.';
        isLoading.value = false;
        return;
      }

      // DEXCHANGE: Enhanced booking payload with payment method and country
      final bookingPayload = {
        'rideInstanceId': bookingRequestData.rideInstanceId,
        'seatsBooked': bookingRequestData.seatsBooked ?? 1,
        'userId': currentUser.id,
        'status': 'pending',
        // DEXCHANGE payment info
        'paymentMethod': selectedPaymentMethod.value!.name,
        'country': selectedCountry.value.name.toUpperCase(),
      };

      logger.d(
        'DEXCHANGE: Sending booking request with payload: $bookingPayload',
      );

      // Send booking request - your backend should now handle DEXCHANGE integration
      var bookingResult = await _userRepository.bookRideWithPayload(
        bookingPayload,
      );

      if (bookingResult == null) {
        errorMessage.value =
            'Erreur lors de la réservation. Veuillez réessayer.';
        isLoading.value = false;
        return;
      }

      booking = bookingResult;
      final transactionId = booking!.payment?.transactionId;

      if (transactionId == null) {
        errorMessage.value = 'Erreur lors de la génération de la transaction.';
        isLoading.value = false;
        return;
      }

      // Check if payment is already completed (mock/test environment)
      if (booking!.payment?.status == 'completed') {
        logger.d(
          'DEXCHANGE: Payment already completed, showing success message',
        );
        successMessage.value =
            'Paiement réussi! Votre réservation est confirmée.';

        // Navigate back or show success state
        await Future.delayed(const Duration(seconds: 2));
        Get.back(); // Go back to previous screen
        return;
      }

      // DEXCHANGE: Get payment instructions from your backend (only for pending payments)
      await _getPaymentInstructions(transactionId);

      if (paymentInstructions.value != null) {
        // Show DEXCHANGE payment instructions dialog
        await _showDexchangePaymentInstructions();

        // Start polling payment status
        _startPaymentStatusPolling(transactionId);
      } else {
        errorMessage.value =
            'Erreur lors de la récupération des instructions de paiement.';
      }
    } catch (e) {
      errorMessage.value =
          'Erreur lors du processus de paiement: ${e.toString()}';
      logger.e('DEXCHANGE Payment process error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get payment instructions from your backend
  Future<void> _getPaymentInstructions(String transactionId) async {
    try {
      // Your backend should return DEXCHANGE payment instructions
      final response = await _apiClient.dio.get(
        '/payments/instructions/$transactionId',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        paymentInstructions.value = DexchangePaymentInstructions.fromJson(
          response.data['data']['instructions'],
        );
      }
    } catch (e) {
      logger.e('Error getting payment instructions: $e');
    }
  }

  /// Show DEXCHANGE payment instructions dialog
  Future<void> _showDexchangePaymentInstructions() async {
    if (paymentInstructions.value == null) return;

    await Get.dialog(
      AlertDialog(
        title: const Text('Instructions de paiement'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(paymentInstructions.value!.message),
              const SizedBox(height: 16),
              Text('Montant: ${paymentInstructions.value!.amount} FCFA'),
              Text('Téléphone: ${paymentInstructions.value!.phoneNumber}'),
              Text('Méthode: ${paymentInstructions.value!.paymentMethod}'),
              Text('Transaction: ${paymentInstructions.value!.transactionId}'),
              const SizedBox(height: 16),
              const Text('Étapes à suivre:'),
              ...paymentInstructions.value!.nextSteps.map(
                (step) => Text('• $step'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('J\'ai compris'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// Start polling payment status every 10 seconds
  void _startPaymentStatusPolling(String transactionId) {
    isPollingPayment.value = true;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 10));

      if (!isPollingPayment.value) return false;

      try {
        final response = await _apiClient.dio.get(
          '/payments/status/$transactionId',
        );

        if (response.statusCode == 200 && response.data['success'] == true) {
          final paymentStatus = response.data['data']['payment']['status'];

          if (paymentStatus == 'completed') {
            isPollingPayment.value = false;
            successMessage.value =
                'Paiement réussi! Votre réservation est confirmée.';
            Get.back(); // Close any open dialogs
            return false;
          } else if (paymentStatus == 'failed' ||
              paymentStatus == 'cancelled') {
            isPollingPayment.value = false;
            errorMessage.value = 'Le paiement a échoué. Veuillez réessayer.';
            Get.back(); // Close any open dialogs
            return false;
          }
        }
      } catch (e) {
        logger.w('Error polling payment status: $e');
      }

      return true; // Continue polling
    });
  }

  /// Stop payment status polling
  void stopPaymentPolling() {
    isPollingPayment.value = false;
  }

  /// Helper method to convert operator string to DexchangePaymentMethod
  DexchangePaymentMethod getPaymentMethodFromOperator(String operator) {
    switch (operator.toLowerCase()) {
      case 'orange':
        return DexchangePaymentMethod.orange;
      case 'wave':
        return DexchangePaymentMethod.wave;
      case 'mtn':
        return DexchangePaymentMethod.mtn;
      case 'moov':
        return DexchangePaymentMethod.moov;
      case 'free':
        return DexchangePaymentMethod.free;
      case 'wizall':
        return DexchangePaymentMethod.wizall;
      default:
        return DexchangePaymentMethod.orange;
    }
  }

  @override
  void onClose() {
    stopPaymentPolling();
    super.onClose();
  }
}
