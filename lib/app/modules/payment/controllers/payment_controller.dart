import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';
import 'package:passenger_tyvaa/domain/entities/payment_response.dart';

import '../../../config/cinetpay_config.dart';
import '../../../repositories/user_repository.dart';

class PaymentController extends GetxController {
  final logger = Logger();
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  final RxBool isLoading = false.obs;

  Map<String, dynamic>? bookingData;

  final UserRepository _userRepository = UserRepository();

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

  Future<void> handleBookAndPay(Booking bookingRequestData) async {
    try {
      isLoading.value = true;
      clearMessages();

      // Create proper booking request data
      final currentUser = _userRepository.getCurrentUser();
      if (currentUser == null || currentUser.id == null) {
        errorMessage.value =
            'Utilisateur non connecté. Veuillez vous reconnecter.';
        isLoading.value = false;
        return;
      }

      // Validate required booking data
      if (bookingRequestData.rideInstanceId == null) {
        errorMessage.value = 'ID de trajet manquant. Veuillez réessayer.';
        isLoading.value = false;
        return;
      }

      // Prepare booking data in the format expected by the API
      // Based on the Booking entity structure, use camelCase format
      final bookingPayload = {
        'rideInstanceId': bookingRequestData.rideInstanceId,
        'seatsBooked': bookingRequestData.seatsBooked ?? 1,
        'userId': currentUser.id,
        'status': 'pending',
      };

      logger.d('Sending booking request with payload: $bookingPayload');
      logger.d('RideInstanceId: ${bookingRequestData.rideInstanceId}');
      logger.d('SeatsBooked: ${bookingRequestData.seatsBooked ?? 1}');
      logger.d('UserId: ${currentUser.id}');

      // Send the booking request
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

      // 2. Initiate payment with CinetPay using transactionId
      await Get.to(
        () => CinetPayCheckout(
          title: 'Paiement de votre trajet',
          titleStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleBackgroundColor: const Color(0xFF6A0DAD),
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
              final typedResponse = Map<String, dynamic>.from(response);
              if (booking != null) {
                _handlePaymentResponse(
                  typedResponse,
                  booking!.payment?.transactionId,
                  booking!,
                );
              } else {
                errorMessage.value =
                    'Réservation introuvable pour le paiement.';
              }
            } catch (e) {
              errorMessage.value =
                  'Erreur de format de réponse: ${e.toString()}';
              isLoading.value = false;
            }
          },
          onError: (error) {
            try {
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
          'Erreur lors du processus de paiement: ${e.toString()}';
      logger.e('Payment process error: $e');
      isLoading.value = false;
    }
  }

  Future<void> _handlePaymentResponse(
    Map<String, dynamic>? response,
    String? transactionId,
    Booking booking,
  ) async {
    if (response == null || transactionId == null) {
      errorMessage.value = 'Erreur lors du paiement ou de la réservation.';
      return;
    }
    final paymentResponse = PaymentResponse.fromJson(response);
    if (paymentResponse.status == 'ACCEPTED') {
      successMessage.value = 'Paiement effectué avec succès!';
      // TODO: Implement notifyPayment in UserRepository if needed
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
      errorMessage.value = 'Paiement échoué ou annulé.';
      // Optionally notify backend of failure
    }
  }

  void _handlePaymentError(Map<String, dynamic> error) {
    errorMessage.value =
        error['description'] ?? 'Une erreur est survenue lors du paiement';
  }
}
