import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../repositories/user_repository.dart';
import '../../../config/cinetpay_config.dart';

class PaymentController extends GetxController {
  // Variables observables
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  final RxBool isLoading = false.obs;

  // Booking data passed from previous screen
  Map<String, dynamic>? bookingData;

  // Repository
  final UserRepository _userRepository = UserRepository();

  // Wave Business configuration (keeping for backwards compatibility)
  static const String WAVE_MERCHANT_CODE =
      'VOTRE_CODE_WAVE'; // À remplacer par votre code

  @override
  void onInit() {
    super.onInit();
    // Get arguments from previous screen with proper type casting
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args != null) {
        if (args['amount'] != null) {
          // Handle both int and double amounts
          final amountValue = args['amount'];
          if (amountValue is int) {
            amount.value = amountValue.toDouble();
          } else if (amountValue is double) {
            amount.value = amountValue;
          } else if (amountValue is String) {
            amount.value = double.tryParse(amountValue) ?? 0.0;
          }
        }
        if (args['bookingData'] != null) {
          // Safely cast booking data
          final bookingDataRaw = args['bookingData'];
          if (bookingDataRaw is Map<String, dynamic>) {
            bookingData = bookingDataRaw;
          } else if (bookingDataRaw is Map) {
            // Convert Map<dynamic, dynamic> to Map<String, dynamic>
            bookingData = Map<String, dynamic>.from(bookingDataRaw);
          }
        }
      }
    }
  }

  void clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }

  Future<void> initiateCinetPayPayment() async {
    try {
      isLoading.value = true;
      clearMessages();

      // Validate amount using configuration
      if (!CinetPayConfig.isValidAmount(amount.value)) {
        errorMessage.value = CinetPayConfig.getAmountErrorMessage(amount.value);
        return;
      }

      // Generate unique transaction ID
      final String transactionId = CinetPayConfig.generateTransactionId();

      // Validate configuration before proceeding
      if (!CinetPayConfig.isConfigured) {
        final errors = CinetPayConfig.validateConfiguration();
        errorMessage.value =
            'Configuration CinetPay manquante:\n${errors.join('\n')}';
        return;
      }

      // Navigate to CinetPay checkout
      await Get.to(
        () => CinetPayCheckout(
          title: 'Paiement de votre trajet',
          titleStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleBackgroundColor: const Color(
            0xFF6A0DAD,
          ), // Using your primary color
          configData: CinetPayConfig.configData,
          paymentData: <String, dynamic>{
            'transaction_id': transactionId,
            'amount': amount.value,
            'currency': CinetPayConfig.CURRENCY_XOF,
            'channels': CinetPayConfig.CHANNELS_ALL,
            'description': 'Paiement de trajet Tyvaa',
          },
          waitResponse: (response) {
            try {
              // Cast response to proper type
              final typedResponse = Map<String, dynamic>.from(response);
              _handlePaymentResponse(typedResponse, transactionId);
            } catch (e) {
              errorMessage.value =
                  'Erreur de format de réponse: ${e.toString()}';
              isLoading.value = false;
            }
          },
          onError: (error) {
            try {
              // Cast error to proper type
              final typedError = Map<String, dynamic>.from(error);
              _handlePaymentError(typedError);
            } catch (e) {
              errorMessage.value = 'Erreur lors du paiement: ${e.toString()}';
              isLoading.value = false;
            }
          },
        ),
      );
    } catch (e) {
      errorMessage.value =
          'Erreur lors du lancement du paiement: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handlePaymentResponse(
    Map<String, dynamic> response,
    String transactionId,
  ) async {
    if (response['status'] == 'ACCEPTED') {
      successMessage.value = 'Paiement effectué avec succès!';

      // Now book the ride if booking data is available
      if (bookingData != null) {
        // Add payment information to booking data
        bookingData!['paymentStatus'] = 'completed';
        bookingData!['transactionId'] = transactionId;
        bookingData!['paymentMethod'] = 'cinetpay';
        bookingData!['amount'] = amount.value;

        // Call the booking API
        final bookingSuccess = await _userRepository.bookRide(bookingData!);

        if (bookingSuccess) {
          // Navigate to success screen or booking confirmation
          Future.delayed(const Duration(seconds: 2), () {
            Get.back(
              result: {
                'success': true,
                'transaction_id': transactionId,
                'booking_confirmed': true,
              },
            );
          });
        } else {
          errorMessage.value =
              'Paiement réussi mais erreur lors de la réservation. Contactez le support.';
        }
      } else {
        // Just payment, no booking
        Future.delayed(const Duration(seconds: 2), () {
          Get.back(result: {'success': true, 'transaction_id': transactionId});
        });
      }
    } else {
      errorMessage.value = 'Paiement échoué. Veuillez réessayer.';
    }
  }

  void _handlePaymentError(Map<String, dynamic> error) {
    errorMessage.value =
        error['description'] ?? 'Une erreur est survenue lors du paiement';
  }

  Future<void> initiateWavePayment() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final Uri waveUri = Uri.parse(
        'wave://business-payment?recipient_wave_code=$WAVE_MERCHANT_CODE'
        '&amount=${amount.value.toStringAsFixed(0)}'
        '&currency=XOF',
      );

      if (await canLaunchUrl(waveUri)) {
        await launchUrl(waveUri);
      } else {
        errorMessage.value =
            'Impossible de lancer Wave. Veuillez vérifier que l\'application est installée.';
      }
    } catch (e) {
      errorMessage.value =
          'Erreur lors du lancement du paiement: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initiateOrangeMoneyPayment() async {
    // À implémenter selon les spécifications d'Orange Money
    errorMessage.value = 'Paiement Orange Money bientôt disponible';
  }

  Future<void> initiateFreeMoneyPayment() async {
    // À implémenter selon les spécifications de Free Money
    errorMessage.value = 'Paiement Free Money bientôt disponible';
  }
}
