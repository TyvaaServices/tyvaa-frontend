import 'package:get/get.dart';

class PublishTrajetController extends GetxController {
  final departure = ''.obs;
  final destination = ''.obs;
  final dateTime = Rxn<DateTime>();
  final places = 1.obs;
  final comment = ''.obs;

  void publishTrajet() {
    print("🚗 Trajet publié !");
    print("De : ${departure.value}");
    print("À : ${destination.value}");
    print("Quand : ${dateTime.value}");
    print("Places : ${places.value}");
    print("Commentaire : ${comment.value}");

    Get.snackbar(
      'Succès',
      'Trajet publié avec succès',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
