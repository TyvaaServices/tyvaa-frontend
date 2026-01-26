import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/entities/booking.dart';
import '../../../../data/repositories/booking_repository.dart';
import '../../../routes/app_pages.dart';

class RideDetailController extends GetxController {
  final IBookingRepository _bookingRepository;

  RideDetailController(this._bookingRepository);

  final ride = Rxn<Ride>();
  final isLoading = false.obs;
  final seatsToBook = 1.obs;

  @override
  void onInit() {
    super.onInit();
    // Ride passed via arguments
    if (Get.arguments != null && Get.arguments is Ride) {
      ride.value = Get.arguments as Ride;
    }
  }

  void incrementSeats() {
    if (seatsToBook.value < (ride.value?.nombrePlaces ?? 1)) {
      seatsToBook.value++;
    }
  }

  void decrementSeats() {
    if (seatsToBook.value > 1) {
      seatsToBook.value--;
    }
  }

  Future<void> bookRide() async {
    if (ride.value == null) return;

    isLoading.value = true;
    try {
      final booking = Booking()
        ..remoteId =
            '' // Will be set by backend
        ..trajetId = ride.value!.remoteId
        ..passagerId =
            'current_user_id' // Should get from AuthRepository
        ..nombrePlacesReservees = seatsToBook.value
        ..statut = 'en_attente'
        ..prixParPassager =
            (ride.value!.prixTotal ?? 0) /
            (ride.value!.nombrePlaces > 0 ? ride.value!.nombrePlaces : 1)
        ..montantTotal =
            ((ride.value!.prixTotal ?? 0) /
                (ride.value!.nombrePlaces > 0 ? ride.value!.nombrePlaces : 1)) *
            seatsToBook.value;

      await _bookingRepository.createBooking(booking);
      AppFeedback.showSuccess(
        'Réservé',
        'Votre demande de réservation a été envoyée.',
      );
      Get.offNamed(Routes.MY_BOOKINGS);
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de réserver ce trajet. Veuillez réessayer.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
