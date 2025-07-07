import 'package:cinetpay/cinetpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';
import 'package:passenger_tyvaa/domain/entities/payment_response.dart';

import '../../../config/cinetpay_config.dart';
import '../../../repositories/user_repository.dart';

class PaymentController extends GetxController {
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
    }
  }

  void clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }


  Future<void> handleBookAndPay(Booking bookingRequestData) async {
    try {
      final bookingResult = await _userRepository.bookRide(bookingRequestData);
      if (bookingResult == null) {
        errorMessage.value =
            'Erreur lors de la réservation. Veuillez réessayer.';
        return;
      }
      booking = bookingResult;
      final transactionId = booking!.payment?.transactionId;
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
          // Using your primary color
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
              'Erreur de format de réponse: \\${e.toString()}';
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
      // Payment response will be handled in waitResponse/onError callbacks
    } catch (e) {
      errorMessage.value =
          'Erreur lors du processus de paiement: \\${e.toString()}';
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
