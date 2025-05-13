import 'package:get/get.dart';

class PublishTrajetController extends GetxController {
  final departure = ''.obs;
  final destination = ''.obs;
  final dateTime = Rxn<DateTime>();
  final places = 1.obs;
  final comment = ''.obs;
  final price = '2500'.obs; // ✅ Ajouté

  void publishTrajet() {
    print("🚗 Trajet publié !");
    print("De : ${departure.value}");
    print("À : ${destination.value}");
    print("Quand : ${dateTime.value}");
    print("Places : ${places.value}");
    print("Prix : ${price.value} FCFA"); // ✅ Affiche aussi le prix
    print("Commentaire : ${comment.value}");

    Get.snackbar(
      'Succès',
      'Trajet publié avec succès',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  bool validateForm() {
    if (departure.value.isEmpty ||
        destination.value.isEmpty ||
        dateTime.value == null ||
        places.value <= 0 ||
        price.value.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}
