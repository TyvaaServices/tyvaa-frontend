import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/repositories/ride_repository.dart';
import '../../../routes/app_pages.dart';

class RideController extends GetxController {
  final IRideRepository _rideRepository;

  RideController(this._rideRepository);

  // Form Controllers
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final priceController = TextEditingController(
    text: '1500',
  ); // Default recommendation

  // Observables
  final isLoading = false.obs;
  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  final seatCount = 1.obs;
  final focusedDay = DateTime.now().obs;

  // Options
  final instantBooking = false.obs;
  final ladiesOnly = false.obs;
  final maxTwoBack = false.obs;
  final selectedVehicle = "Toyota Corolla (DK-234-AA)".obs; // Mock default

  @override
  void onInit() {
    super.onInit();
    // Pre-fill date with today
    selectedDate.value = DateTime.now();
    selectedTime.value = const TimeOfDay(hour: 8, minute: 0);
  }

  void pickDate(BuildContext context) async {
    await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 24.h),
              decoration: BoxDecoration(
                color: AppColors.slate200,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Obx(
              () => TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 60)),
                focusedDay: focusedDay.value,
                selectedDayPredicate: (day) =>
                    isSameDay(selectedDate.value, day),
                onDaySelected: (selected, focused) {
                  selectedDate.value = selected;
                  focusedDay.value = focused;
                  Get.back();
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  weekendTextStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.error,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void pickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.slate900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
          ),
          child: child!,
        );
      },
    );
    if (time != null) {
      selectedTime.value = time;
    }
  }

  void incrementSeats() {
    if (seatCount.value < 7) seatCount.value++;
  }

  void decrementSeats() {
    if (seatCount.value > 1) seatCount.value--;
  }

  Future<void> publishRide() async {
    if (fromController.text.isEmpty ||
        toController.text.isEmpty ||
        selectedDate.value == null ||
        selectedTime.value == null) {
      AppFeedback.showError(
        'Oups !',
        'Veuillez remplir toutes les informations (Départ, Arrivée, Date et Heure).',
      );
      return;
    }

    isLoading.value = true;
    try {
      // Merge Date + Time
      final d = selectedDate.value!;
      final t = selectedTime.value!;
      final fullDate = DateTime(d.year, d.month, d.day, t.hour, t.minute);

      final ride = Ride()
        ..remoteId = const Uuid().v4()
        ..villeDepart = fromController.text
        ..villeArrivee = toController.text
        ..dateDepart = fullDate
        ..prixTotal = double.tryParse(priceController.text) ?? 1500
        ..nombrePlaces = seatCount.value
        ..statut = 'ouvert'
        ..conducteurId = 'current_user_id'
        // Add custom fields handling if entity supports it, or put in notes
        ..driverName = "Moi (Conducteur)";

      await _rideRepository.publishRide(ride);

      Get.snackbar(
        "Succès",
        "Votre trajet a été publié avec succès !",
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green[800],
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
      );

      Get.offAllNamed(Routes.HOME); // Go back to dashboard
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de publier le trajet. Veuillez réessayer.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fromController.dispose();
    toController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
