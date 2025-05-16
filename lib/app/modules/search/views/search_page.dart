import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/domain/entities/location_info.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Origin field with TypeAhead
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
                        child: RawAutocomplete<Map<String, dynamic>>(
                          focusNode: controller.currentLocationFocusNode,
                          textEditingController:
                              controller.currentLocationController,
                          optionsBuilder: (
                            TextEditingValue textEditingValue,
                          ) async {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<
                                Map<String, dynamic>
                              >.empty();
                            }
                            return await searchLocations(
                              textEditingValue.text,
                              lat: controller.currentLat.value,
                              lon: controller.currentLon.value,
                              countryCode: controller.countryCode.value,
                            );
                          },
                          optionsViewBuilder: (
                            BuildContext context,
                            AutocompleteOnSelected<Map<String, dynamic>>
                            onSelected,
                            Iterable<Map<String, dynamic>> options,
                          ) {
                            return _buildOptionsView(
                              context,
                              onSelected,
                              options,
                              textColor,
                              isDark,
                            );
                          },
                          fieldViewBuilder: (
                            BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted,
                          ) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
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
                            );
                          },
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

                IntrinsicHeight(
                  child:
                  RawAutocomplete<Map<String, dynamic>>(
                    key: Key('destination_field'),
                    focusNode: controller.destinationFocusNode,
                    textEditingController: controller.destinationController,
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Map<String, dynamic>>.empty();
                      }
                      return await searchLocations(
                        textEditingValue.text,
                        lat: controller.currentLat.value,
                        lon: controller.currentLon.value,
                        countryCode: controller.countryCode.value,
                      );
                    },
                    optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<Map<String, dynamic>> onSelected,
                        Iterable<Map<String, dynamic>> options,
                        ) {
                      return Material(
                        elevation: 8,
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: options.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: isDark ? Colors.white10 : Colors.grey.shade200,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final option = options.elementAt(index);
                              return InkWell(
                                onTap: () {
                                  onSelected(option);
                                  var location = LocationInfo.fromJson(option);
                                  controller.destinationController.text = location.displayName;
                                  controller.checkTripLength(
                                    location.lat,
                                    location.lon,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.8,
                                            child: AutoSizeText(
                                              option['display_name']?.split(',').first ?? 'Unknown',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: Get.width * 0.8,
                                            child: AutoSizeText(
                                              option['display_name'] ?? '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: textColor.withOpacity(0.6),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted,
                        ) {
                      return Row(
                        children: [
                          _buildLocationIcon(
                            color: primaryColor,
                            icon: Icons.place_rounded,
                            isDark: isDark,
                          ),
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
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
                        ],
                      );
                    },
                  ),

// Clear/Map Button - Uncommented
//                   Obx(
//                         () => controller.showClearButton.value
//                         ? GestureDetector(
//                       onTap: () {
//                         HapticFeedback.lightImpact();
//                         controller.clearDestination();
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         margin: const EdgeInsets.only(right: 10),
//                         decoration: BoxDecoration(
//                           color: isDark ? Colors.white12 : Colors.black.withOpacity(0.05),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.close_rounded,
//                           color: textColor.withOpacity(0.5),
//                           size: 18,
//                         ),
//                       ),
//                     )
//                         : GestureDetector(
//                       onTap: () {
//                         HapticFeedback.mediumImpact();
//                         // Open map selection
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         margin: const EdgeInsets.only(right: 10),
//                         decoration: BoxDecoration(
//                           color: primaryColor.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.map_rounded,
//                           color: primaryColor,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsView(
    BuildContext context,
    AutocompleteOnSelected<Map<String, dynamic>> onSelected,
    Iterable<Map<String, dynamic>> options,
    Color textColor,
    bool isDark,
  ) {
    return Material(
      elevation: 4.0,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> option = options.elementAt(index);
          return InkWell(
            onTap: () {
              onSelected(option);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    color: textColor.withOpacity(0.6),
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option['display_name']?.split(',').first ??
                            'Unknown location',
                        style: TextStyle(color: textColor, fontSize: 16),
                      ),
                      Text(
                        option['display_name'] ?? '',
                        style: TextStyle(
                          color: textColor.withOpacity(0.6),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
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
                  }),
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
        }),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: Get.width * 0.6,
                        child: AutoSizeText(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: textColor.withOpacity(0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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

final Map<String, List<Map<String, dynamic>>> _searchCache = {};

Future<List<Map<String, dynamic>>> searchLocations(
  String query, {
  double? lat,
  double? lon,
  String? countryCode,
}) async {
  const String apiKey = 'pk.fe687b0ad84ae94af226f986ac078a5e';
  final cacheKey = '$query|${lat ?? ''}|${lon ?? ''}|${countryCode ?? ''}';

  // ✅ Return cached results if available
  if (_searchCache.containsKey(cacheKey)) {
    return _searchCache[cacheKey]!;
  }

  final url = Uri.parse(
    'https://api.locationiq.com/v1/autocomplete'
    '?q=$query'
    '&key=$apiKey'
    '&format=json'
    '${countryCode != null ? '&countrycodes=$countryCode' : ''}'
    '&limit=5',
  );
  var logger = Logger();
  logger.d('Fetching location data for query: $query');
  logger.d('URL: $url');
  logger.d('Cache key: $apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    final result =
        data
            .map<Map<String, dynamic>>((e) => e as Map<String, dynamic>)
            .toList();

    // ✅ Store in cache
    _searchCache[cacheKey] = result;

    return result;
  } else if (response.statusCode == 429) {
    throw Exception('Rate limit exceeded (429)');
  } else if (response.statusCode == 403 || response.statusCode == 401) {
    throw Exception('Unauthorized or invalid API key');
  } else if (response.statusCode == 404) {
    throw Exception('Location not found (404)');
  } else {
    throw Exception('LocationIQ error: ${response.statusCode}');
  }
}
