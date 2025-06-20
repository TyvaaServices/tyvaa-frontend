import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentController extends GetxController {
  // Variables observables
  final RxDouble amount = 0.0.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  // Wave Business configuration
  static const String WAVE_MERCHANT_CODE = 'VOTRE_CODE_WAVE'; // À remplacer par votre code

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['amount'] != null) {
      amount.value = Get.arguments['amount'];
    }
  }

  Future<void> initiateWavePayment() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final Uri waveUri = Uri.parse(
        'wave://business-payment?recipient_wave_code=$WAVE_MERCHANT_CODE'
        '&amount=${amount.value.toStringAsFixed(0)}'
        '&currency=XOF'
      );

      if (await canLaunchUrl(waveUri)) {
        await launchUrl(waveUri);
      } else {
        errorMessage.value = 'Impossible de lancer Wave. Veuillez vérifier que l\'application est installée.';
      }
    } catch (e) {
      errorMessage.value = 'Erreur lors du lancement du paiement: ${e.toString()}';
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
