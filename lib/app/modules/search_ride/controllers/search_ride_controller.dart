import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/repositories/ride_repository.dart';

class SearchRideController extends GetxController {
  final IRideRepository _rideRepository;

  SearchRideController(this._rideRepository);

  final fromController = TextEditingController();
  final toController = TextEditingController();

  final rides = <Ride>[].obs;
  final filteredRides = <Ride>[].obs;
  final isLoading = false.obs;
  final hasSearched = false.obs;

  final Rxn<DateTime> selectedDate = Rxn<DateTime>(DateTime.now());
  final focusedDay = DateTime.now().obs;

  // Filter State (Case Study: Price Limit, Same Gender, Verified)
  final maxPrice = RxnDouble();
  final sameGenderOnly = false.obs;
  final verifiedOnly = false.obs;
  final sortBy = 'price'.obs; // 'price', 'time', 'rating'

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> pickDate(BuildContext context) async {
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

  Future<void> search() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));

      final results = await _rideRepository.searchRides(
        fromController.text,
        toController.text,
        selectedDate.value ?? DateTime.now(),
      );
      rides.value = results;
      applyFilters();
      hasSearched.value = true;
    } catch (e) {
      // Error handling
    } finally {
      isLoading.value = false;
    }
  }

  // Apply filters to search results
  void applyFilters() {
    var result = rides.toList();

    // Price filter
    if (maxPrice.value != null) {
      result = result
          .where((r) => (r.prixTotal ?? 0) <= maxPrice.value!)
          .toList();
    }

    // Verified only filter
    if (verifiedOnly.value) {
      result = result.where((r) => r.isVerified == true).toList();
    }

    // Sort
    switch (sortBy.value) {
      case 'price':
        result.sort((a, b) => (a.prixTotal ?? 0).compareTo(b.prixTotal ?? 0));
        break;
      case 'time':
        result.sort(
          (a, b) => (a.dateDepart ?? DateTime.now()).compareTo(
            b.dateDepart ?? DateTime.now(),
          ),
        );
        break;
      case 'rating':
        result.sort((a, b) => b.driverRating.compareTo(a.driverRating));
        break;
    }

    filteredRides.value = result;
  }

  void setMaxPrice(double? price) {
    maxPrice.value = price;
    applyFilters();
  }

  void toggleVerifiedOnly() {
    verifiedOnly.toggle();
    applyFilters();
  }

  void toggleSameGenderOnly() {
    sameGenderOnly.toggle();
    applyFilters();
  }

  void setSortBy(String sort) {
    sortBy.value = sort;
    applyFilters();
  }

  void resetSearch() {
    hasSearched.value = false;
    rides.clear();
    filteredRides.clear();
    maxPrice.value = null;
    verifiedOnly.value = false;
    sameGenderOnly.value = false;
  }

  @override
  void onClose() {
    fromController.dispose();
    toController.dispose();
    super.onClose();
  }
}
