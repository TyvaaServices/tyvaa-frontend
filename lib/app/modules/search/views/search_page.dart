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
        isDark ? AppColors.darkBackground : const Color(0xFFF8F9FE);
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    controller.forceFocus();
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              top: false,
              child: Container(
                height: constraints.maxHeight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
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
                          _buildRecentDestinations(
                            isDark,
                            surfaceColor,
                            textColor,
                            primaryColor,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Entrez votre trajet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
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
      key: const Key('search_bar'),
      tag: 'search_bar',
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? const Color(0xFF252543) : Colors.white,
              isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF8F9FE),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black12 : Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLocationField(
                controller: controller.currentLocationController,
                icon: Icons.my_location_rounded,
                iconColor: Colors.blue,
                textColor: textColor,
                isDark: isDark,
                isFirst: true,
                onTap: () {
                  controller
                      .currentLocationController
                      .selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        controller.currentLocationController.text.length,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Divider(
                  height: 1,
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
              ),
              _buildLocationField(
                controller: controller.destinationController,
                icon: Icons.location_on_rounded,
                iconColor: primaryColor,
                textColor: textColor,
                isDark: isDark,
                isFirst: false,
                focusNode: controller.destinationFocusNode,
                hintText: 'Où souhaitez-vous aller ?',
                trailingWidget: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.place_outlined,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required IconData icon,
    required Color iconColor,
    required Color textColor,
    required bool isDark,
    required bool isFirst,
    FocusNode? focusNode,
    String? hintText,
    VoidCallback? onTap,
    Widget? trailingWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Material(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onTap: onTap,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: 16,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ),
            suffixIcon:
                trailingWidget != null
                    ? Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: trailingWidget,
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
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
        Text(
          "Destinations récentes",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildRecentDestinationItem(
          "Centre Commercial Cap 3000",
          "Avenue Eugène Donadeï, Saint-Laurent-du-Var",
          Icons.shopping_bag_outlined,
          textColor,
          isDark,
        ),
        _buildRecentDestinationItem(
          "Aéroport Nice Côte d'Azur",
          "Rue Costes et Bellonte, Nice",
          Icons.flight_outlined,
          textColor,
          isDark,
        ),
        _buildRecentDestinationItem(
          "Gare SNCF de Nice Ville",
          "Avenue Thiers, Nice",
          Icons.train_outlined,
          textColor,
          isDark,
        ),
        _buildRecentDestinationItem(
          "Promenade des Anglais",
          "Nice",
          Icons.beach_access_outlined,
          textColor,
          isDark,
        ),
        _buildRecentDestinationItem(
          "Place Masséna",
          "Centre-ville, Nice",
          Icons.location_city_outlined,
          textColor,
          isDark,
        ),
      ],
    );
  }

  Widget _buildRecentDestinationItem(
    String title,
    String subtitle,
    IconData icon,
    Color textColor,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252543) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          controller.destinationController.text = title;
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? const Color(0xFF1E1E2E)
                          : const Color(0xFFF0F2F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDark ? Colors.white70 : Colors.black54,
                  size: 22,
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
    );
  }
}
