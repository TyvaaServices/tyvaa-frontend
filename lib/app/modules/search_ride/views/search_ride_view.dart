import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/search_ride_controller.dart';
import '../../../routes/app_pages.dart';

class SearchRideView extends GetView<SearchRideController> {
  const SearchRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isResultsMode = controller.hasSearched.value;

      return Scaffold(
        backgroundColor: AppColors.slate50,
        appBar: isResultsMode ? _buildResultsAppBar(context) : null,
        body: SafeArea(
          child: isResultsMode
              ? _buildResultsList(context)
              : _buildSearchForm(context),
        ),
      );
    });
  }

  AppBar _buildResultsAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: AppColors.slate900),
        onPressed: controller.resetSearch,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${controller.fromController.text} → ${controller.toController.text}",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
          Obx(
            () => Text(
              controller.selectedDate.value != null
                  ? DateFormat(
                      'EEE d MMM',
                      'fr',
                    ).format(controller.selectedDate.value!)
                  : "",
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.slate500,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune_rounded, color: AppColors.slate900),
          onPressed: () => _showFilterSheet(context),
        ),
        SizedBox(width: 8.w),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(color: AppColors.slate200, height: 1.h),
      ),
    );
  }

  // --- MODE A: Search FORM (Full Screen Focus) ---
  Widget _buildSearchForm(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.slate900,
                ),
                onPressed: () => Get.back(),
              ),
              Expanded(
                child: Text(
                  "Rechercher un trajet",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 48.w), // Balance close button
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // Input Container
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.slate900.withValues(alpha: 0.05),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Départ',
                        hint: 'Gare routière, Dakar...',
                        controller: controller.fromController,
                        prefixIcon: Icon(
                          Icons.circle_outlined,
                          size: 18.w,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: 'Arrivée',
                        hint: 'Saint-Louis, Touba...',
                        controller: controller.toController,
                        prefixIcon: Icon(
                          Icons.location_on_rounded,
                          size: 18.w,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Date Selector (Unlocked)
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.pickDate(context),
                              child: _buildSelector(
                                context,
                                Icons.calendar_today_rounded,
                                Obx(
                                  () => Text(
                                    controller.selectedDate.value != null
                                        ? DateFormat('EEE d MMM', 'fr').format(
                                            controller.selectedDate.value!,
                                          )
                                        : "Choisir la date",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn().moveY(begin: 20, end: 0),

                SizedBox(height: 32.h),

                PrimaryButton(
                  text: 'Rechercher',
                  onPressed: controller.search,
                  isLoading: controller.isLoading.value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- MODE B: Results LIST (Cleaned up) ---
  Widget _buildResultsList(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // 1. Results Count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${controller.filteredRides.length} trajets disponibles',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.slate500,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Optional: Date navigator (Previous day / Next day)
            ],
          ),
        ),

        // 2. List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.filteredRides.length,
            itemBuilder: (context, index) {
              final ride = controller.filteredRides[index];
              return RideCard(
                ride: ride,
                onTap: () => Get.toNamed(Routes.RIDE_DETAIL, arguments: ride),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelector(BuildContext context, IconData icon, Widget content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.w, color: AppColors.slate500),
          SizedBox(width: 8.w),
          Expanded(child: content),
        ],
      ),
    );
  }

  // Merged Filter & Sort Sheet
  void _showFilterSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.slate900.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.slate200,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Filtres & Tri",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 24.h),

            // Sort Section
            Text(
              "Trier par",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 12.h),
            Obx(
              () => Wrap(
                spacing: 8.w,
                children: [
                  _buildSortChip(
                    "Prix",
                    'price',
                    controller.sortBy.value == 'price',
                  ),
                  _buildSortChip(
                    "Heure",
                    'time',
                    controller.sortBy.value == 'time',
                  ),
                  _buildSortChip(
                    "Note",
                    'rating',
                    controller.sortBy.value == 'rating',
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            Divider(color: AppColors.slate200),
            SizedBox(height: 24.h),

            // Price Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prix maximum",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.slate800,
                  ),
                ),
                Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "${controller.maxPrice.value?.toStringAsFixed(0) ?? '10 000'} F",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Obx(
              () => SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4.h,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.slate100,
                  thumbColor: AppColors.primary,
                ),
                child: Slider(
                  value: controller.maxPrice.value ?? 10000,
                  min: 1000,
                  max: 10000,
                  divisions: 18,
                  onChanged: (v) => controller.setMaxPrice(v),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Toggle Options
            Container(
              decoration: BoxDecoration(
                color: AppColors.slate50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Obx(
                    () => SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      title: Text(
                        "Conducteurs vérifiés",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      activeTrackColor: AppColors.primary,
                      value: controller.verifiedOnly.value,
                      onChanged: (_) => controller.toggleVerifiedOnly(),
                    ),
                  ),
                  Divider(height: 1, indent: 16.w, endIndent: 16.w),
                  Obx(
                    () => SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      title: Row(
                        children: [
                          Text(
                            "Conductrices uniquement",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.female_rounded,
                            size: 18.w,
                            color: Colors.pinkAccent,
                          ),
                        ],
                      ),
                      activeTrackColor: Colors.pinkAccent,
                      value: controller.sameGenderOnly.value,
                      onChanged: (_) => controller.toggleSameGenderOnly(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
            PrimaryButton(
              text: "Afficher les résultats",
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSortChip(String label, String value, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) controller.setSortBy(value);
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.1),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.slate600,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.slate200,
      ),
    );
  }
}
