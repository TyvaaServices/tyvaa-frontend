import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/booking.dart';
import '../../../../data/repositories/booking_repository.dart';

class BookingRequestsController extends GetxController {
  final IBookingRepository _bookingRepository;

  BookingRequestsController(this._bookingRepository);

  final bookings = <Booking>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPendingBookings();
  }

  Future<void> loadPendingBookings() async {
    isLoading.value = true;
    try {
      // In a real app, this would fetch bookings for the driver's rides
      // For now, we filter pending bookings
      final allBookings = await _bookingRepository.getMyBookings();
      bookings.value = allBookings
          .where((b) => b.statut == 'en_attente')
          .toList();
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de charger les demandes. Vérifiez votre connexion.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptBooking(String remoteId) async {
    isLoading.value = true;
    try {
      await _bookingRepository.updateBookingStatus(remoteId, 'confirmee');
      await loadPendingBookings();
      AppFeedback.showSuccess(
        'Confirmée',
        'Réservation acceptée avec succès !',
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de confirmer la réservation.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rejectBooking(String remoteId) async {
    isLoading.value = true;
    try {
      await _bookingRepository.updateBookingStatus(remoteId, 'refusee');
      await loadPendingBookings();
      AppFeedback.showInfo('Refusée', 'La réservation a été refusée.');
    } catch (e) {
      AppFeedback.showError('Erreur', 'Impossible de refuser la réservation.');
    } finally {
      isLoading.value = false;
    }
  }
}
