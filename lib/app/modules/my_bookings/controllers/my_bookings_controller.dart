import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/booking.dart';
import '../../../../data/repositories/booking_repository.dart';

class MyBookingsController extends GetxController {
  final IBookingRepository _bookingRepository;

  MyBookingsController(this._bookingRepository);

  final bookings = <Booking>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  Future<void> loadBookings() async {
    isLoading.value = true;
    try {
      bookings.value = await _bookingRepository.getMyBookings();
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de charger les réservations. Vérifiez votre connexion.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelBooking(String remoteId) async {
    isLoading.value = true;
    try {
      await _bookingRepository.cancelBooking(
        remoteId,
        'Annulée par l\'utilisateur',
      );
      await loadBookings();
      AppFeedback.showSuccess(
        'Annulée',
        'Votre réservation a bien été annulée.',
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible d\'annuler la réservation. Veuillez réessayer.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
