import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import '../controllers/quick_ride_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:passenger_tyvaa/app/themes/tyvaa_theme.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class QuickRideView extends GetView<QuickRideController> {
  const QuickRideView({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect if we're in dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.darkBackground : AppColors.background;
    final textColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final cardColor = isDarkMode ? AppColors.cardDark : AppColors.card;
    final shadowColor = isDarkMode ? Colors.black54 : Colors.black12;

    // Define height for our compact design
    final bottomSheetHeight = Get.height*0.35;

    return Scaffold(
      body: Obx(() => Stack(
        children: [
          // Map View
          _buildMapView(isDarkMode),

          // Back Button with improved design
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                elevation: 8,
                shadowColor: shadowColor,
                borderRadius: BorderRadius.circular(12),
                color: cardColor,
                child: InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primary, size: 20),
                  ),
                ),
              ),
            ),
          ),

          // Loading Indicator with improved design
          if (controller.isLoading.value)
            Center(
              child: Container(
                width: 180,
                height: 120,
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF1E1E28) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.08),
                      blurRadius: 30,
                      spreadRadius: 0,
                      offset: Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.08)
                        : Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        strokeWidth: 3,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Finding your ride...",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom Sheet with compact design
          _buildCompactBottomSheet(context, isDarkMode, backgroundColor, textColor, textSecondaryColor, cardColor, shadowColor, bottomSheetHeight),
        ],
      )),
    );
  }

  Widget _buildMapView(bool isDarkMode) {
    if (controller.currentLocation.value == null) {
      return Container(
        color: isDarkMode ? AppColors.darkBackground : AppColors.background,
      );
    }

    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.currentLocation.value!,
        initialZoom: controller.zoom.value,
        maxZoom: 18.0,
        minZoom: 3.0,
        keepAlive: true,
      ),
      children: [
        TileLayer(
          urlTemplate: isDarkMode
              ? 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}.png'
              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.tyvaa.passenger',
        ),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always,
          alignDirectionOnUpdate: AlignOnUpdate.never,
          style: LocationMarkerStyle(
            markerSize: const Size(15, 15),
            markerDirection: MarkerDirection.heading,
            marker: DefaultLocationMarker(
              color: AppColors.primary,
              child: Icon(
                Icons.navigation,
                color: Colors.white,
                size: 10,
              ),
            ),
            accuracyCircleColor: AppColors.primary.withOpacity(0.1),
          ),
        ),
        PolylineLayer(
          polylines: controller.polylines,
        ),
        MarkerLayer(
          markers: controller.markers,
        ),
      ],
    );
  }

  Widget _buildCompactBottomSheet(BuildContext context, bool isDarkMode, Color backgroundColor,
      Color textColor, Color textSecondaryColor, Color cardColor, Color shadowColor, double bottomSheetHeight) {
    // Use GetX responsive values for proper scaling
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = Get.textScaleFactor;

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: controller.bottomSheetVisible.value ? bottomSheetHeight : 0,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Color(0xFF151520).withOpacity(0.95)
                    : Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 25,
                    offset: Offset(0, -5),
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Tyvaa Standard and price in same row
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tyvaa Standard with car icon
                        Row(
                          children: [
                            // Car icon with premium design
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.local_taxi_rounded,
                                color: Colors.white,
                                size: 22
                              ),
                            ),
                            SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tyvaa Standard',
                                  style: TextStyle(
                                    fontSize: 18 * textScaleFactor,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Estimated time 3 min',
                                    style: TextStyle(
                                      fontSize: 14 * textScaleFactor,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Price display
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.8),
                                isDarkMode ? AppColors.primary : AppColors.primary.withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.25),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          child: Text(
                            controller.estimatedPrice.value,
                            style: TextStyle(
                              fontSize: 18 * textScaleFactor,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pickup and destination with increased text size
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF1E1E2C) : Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.black.withOpacity(0.3)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Creative route visualization
                        Container(
                          width: 24,
                          child: Column(
                            children: [
                              // Origin dot
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode ? Color(0xFF1E1E2C) : Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.success.withOpacity(0.4),
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                              ),
                              // Dashed line
                              Container(
                                height: 40,
                                width: 2,
                                margin: EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.success, AppColors.error],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Flex(
                                      direction: Axis.vertical,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        5,
                                        (index) => Container(
                                          width: 2,
                                          height: 3,
                                          color: isDarkMode ? Color(0xFF1E1E2C) : Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Destination dot
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode ? Color(0xFF1E1E2C) : Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.error.withOpacity(0.4),
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        // Address details with larger text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.startLocation.value,
                                style: TextStyle(
                                  fontSize: 16 * textScaleFactor,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 32),
                              Text(
                                controller.endLocation.value,
                                style: TextStyle(
                                  fontSize: 16 * textScaleFactor,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Beautiful action button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(16, 20, 16, 16),
                    height: 54,
                    child: ElevatedButton(
                      onPressed: controller.requestRide,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color:
                          AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 54),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'REQUEST RIDE',
                                style: TextStyle(
                                  fontSize: 17 * textScaleFactor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
