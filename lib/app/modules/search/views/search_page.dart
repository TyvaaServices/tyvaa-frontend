import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../themes/tyvaa_theme.dart';
import '../controllers/search_controller.dart';

class LocationSearchModal extends GetView<SearchViewController> {
  const LocationSearchModal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final primaryColor = Get.theme.primaryColor;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final backgroundColor =
        isDark ? AppColors.darkBackground : const Color(0xFFF8F9FB);
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;

    controller.forceFocus();

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildDragHandle(isDark),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Obx(
                            () => ListView(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                _buildHeader(textColor),
                                _buildSearchFields(
                                  isDark,
                                  surfaceColor,
                                  textColor,
                                  primaryColor,
                                ),
                                const SizedBox(height: 24),

                                controller.isSearching.value
                                    ? _buildSearchResults(
                                      isDark,
                                      surfaceColor,
                                      textColor,
                                    )
                                    : _buildRecentDestinations(
                                      isDark,
                                      surfaceColor,
                                      textColor,
                                      primaryColor,
                                    ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDragHandle(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[700] : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(
            "Planifiez votre trajet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: textColor.withOpacity(0.8),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFields(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return Hero(
      tag: 'search_bar',
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Origin field
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLocationIcon(
                        color: Colors.blue,
                        icon: Icons.my_location_rounded,
                        isDark: isDark,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.currentLocationController,
                          focusNode: controller.currentLocationFocusNode,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Votre position actuelle',
                            hintStyle: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                      // Swap button
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          controller.swapLocations();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.swap_vert_rounded,
                            color: primaryColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Divider(
                    height: 1,
                    color:
                        isDark
                            ? Colors.white12
                            : Colors.black.withOpacity(0.08),
                  ),
                ),

                // Destination field
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLocationIcon(
                        color: primaryColor,
                        icon: Icons.place_rounded,
                        isDark: isDark,
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.destinationController,
                          focusNode: controller.destinationFocusNode,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Où souhaitez-vous aller ?',
                            hintStyle: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                      // Clear or Map button
                      Obx(
                        () =>
                            controller.showClearButton.value
                                ? GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    controller.clearDestination();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color:
                                          isDark
                                              ? Colors.white12
                                              : Colors.black.withOpacity(0.05),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: textColor.withOpacity(0.5),
                                      size: 18,
                                    ),
                                  ),
                                )
                                : GestureDetector(
                                  onTap: () {
                                    HapticFeedback.mediumImpact();
                                    // Open map selection
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.map_rounded,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationIcon({
    required Color color,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }

  Widget _buildSearchResults(bool isDark, Color surfaceColor, Color textColor) {
    return Obx(
      () =>
          controller.searchResults.isEmpty
              ? _buildNoResultsFound(textColor)
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 16,
                          color: textColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Résultats de recherche",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...controller.searchResults.map((result) {
                    final location = controller.recentLocations.firstWhere(
                      (loc) => loc.title == result,
                      orElse:
                          () => RecentLocation(
                            result,
                            "Adresse non disponible",
                            Icons.place_outlined,
                          ),
                    );

                    return _buildDestinationItem(
                      location.title,
                      location.subtitle,
                      location.icon,
                      textColor,
                      isDark,
                    );
                  }).toList(),
                ],
              ),
    );
  }

  Widget _buildNoResultsFound(Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 60,
            color: textColor.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            "Aucun résultat trouvé",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Essayez de modifier votre recherche ou utilisez la carte",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDestinations(
    bool isDark,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: 16,
                color: textColor.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                "Destinations récentes",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor.withOpacity(0.6),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Clear history action
                  HapticFeedback.lightImpact();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Effacer",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...controller.recentLocations.map((location) {
          return _buildDestinationItem(
            location.title,
            location.subtitle,
            location.icon,
            textColor,
            isDark,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDestinationItem(
    String title,
    String subtitle,
    IconData icon,
    Color textColor,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            controller.selectDestination(title);
          },
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            decoration: BoxDecoration(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.02),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: isDark ? Colors.white70 : Colors.black54,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withOpacity(0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: textColor.withOpacity(0.3),
                    size: 14,
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
