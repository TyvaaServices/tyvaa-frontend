import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/repositories/ride_repository.dart';
import '../../../routes/app_pages.dart';

class ActiveRideController extends GetxController {
  final IRideRepository _rideRepository;

  ActiveRideController(this._rideRepository);

  final ride = Rxn<Ride>();
  final tripStatus = 'pending'.obs; // pending, started, completed
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Ride) {
      ride.value = Get.arguments as Ride;
      tripStatus.value = ride.value?.statut ?? 'pending';
    }
  }

  Future<void> startTrip() async {
    if (ride.value == null) return;
    isLoading.value = true;
    try {
      // Update ride status to 'en_cours'
      await _rideRepository.updateRideStatus(ride.value!.remoteId, 'en_cours');
      tripStatus.value = 'started';
      AppFeedback.showSuccess(
        'C\'est parti!',
        'Bon voyage ! Le trajet a commencé.',
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de démarrer le trajet. Vérifiez votre connexion.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> endTrip() async {
    if (ride.value == null) return;
    isLoading.value = true;
    try {
      await _rideRepository.updateRideStatus(ride.value!.remoteId, 'termine');
      tripStatus.value = 'completed';
      AppFeedback.showSuccess('Terminé', 'Trajet terminé avec succès. Merci !');
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      AppFeedback.showError('Erreur', 'Impossible de terminer le trajet.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelTrip() async {
    if (ride.value == null) return;
    isLoading.value = true;
    try {
      await _rideRepository.updateRideStatus(ride.value!.remoteId, 'annule');
      AppFeedback.showInfo('Annulé', 'Le trajet a été annulé.');
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      AppFeedback.showError('Erreur', 'Impossible d\'annuler le trajet.');
    } finally {
      isLoading.value = false;
    }
  }
}
