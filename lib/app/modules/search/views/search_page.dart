import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/search/controllers/search_controller.dart';

// Using GetX is commented out as requested - can be implemented later
// import 'package:get/get.dart';

// Using Google Maps is commented out as requested - can be implemented later
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchView extends GetView<SearchViewController> {
  SearchView({Key? key}) : super(key: key);
  // Controllers

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF7F8FC);
    final textColor = isDark ? Colors.white : Colors.black87;
    final surfaceColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final primaryColor = const Color(0xFF6C63FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller.destinationController,
          builder: (context, textValue, _) {
            final hasText = textValue.text.isNotEmpty;
            final isSearching = true; // Always show search UI initially
            final filteredLocations = controller.getFilteredLocations(
              textValue.text,
            );

            return Stack(
              children: [
                // This is where the map would go later
                // Currently commented out as requested

                // Search container
                Column(
                  children: [
                    // Search header
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: 8.0,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: textColor),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Rechercher un trajet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Search bar with auto focus
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: surfaceColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: textColor.withOpacity(0.6),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: controller.destinationController,
                                autofocus: true, // Auto focus when page opens
                                decoration: InputDecoration(
                                  hintText: 'Où souhaitez-vous aller à Dakar?',
                                  hintStyle: TextStyle(
                                    color: textColor.withOpacity(0.6),
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (hasText)
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: textColor.withOpacity(0.6),
                                ),
                                onPressed: () {
                                  controller.destinationController.clear();
                                },
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Expanded content
                    Expanded(
                      child:
                          hasText
                              ? _buildSearchResults(
                                filteredLocations,
                                surfaceColor,
                                textColor,
                                primaryColor,
                                context,
                              )
                              : _buildInitialContent(
                                surfaceColor,
                                textColor,
                                primaryColor,
                                context,
                              ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    List<String> locations,
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
    BuildContext context,
  ) {
    if (locations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: textColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              'Aucun résultat trouvé',
              style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.7)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        final isLongDistance = controller.isLongDistance(location);

        return _buildLocationItem(
          location,
          isLongDistance ? 'Trajet long' : 'Trajet court',
          isLongDistance ? Icons.directions_car : Icons.directions_walk,
          isLongDistance ? primaryColor : Colors.green,
          surfaceColor,
          textColor,
          context,
        );
      },
    );
  }

  Widget _buildLocationItem(
    String location,
    String description,
    IconData icon,
    Color iconColor,
    Color surfaceColor,
    Color textColor,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        // Show a snackbar with the selected location info
        // In a real app, this would navigate to the booking screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sélectionné: $location ($description)'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent(
    Color surfaceColor,
    Color textColor,
    Color primaryColor,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Recherches récentes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          _buildRecentSearch(
            'Plateau, Dakar',
            surfaceColor,
            textColor,
            context,
          ),
          _buildRecentSearch(
            'Almadies, Dakar',
            surfaceColor,
            textColor,
            context,
          ),
          _buildRecentSearch(
            'Saint-Louis, Sénégal',
            surfaceColor,
            textColor,
            context,
          ),

          const SizedBox(height: 24),

          // Popular destinations
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Destinations populaires',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          _buildPopularDestination(
            'Dakar → Saint-Louis',
            '192 km • Trajet long',
            const Color(0xFF4ECDC4),
            surfaceColor,
            textColor,
            context,
          ),
          _buildPopularDestination(
            'Dakar → Mbour',
            '80 km • Trajet long',
            const Color(0xFF6C63FF),
            surfaceColor,
            textColor,
            context,
          ),
          _buildPopularDestination(
            'Plateau → Almadies',
            '13 km • Trajet court',
            const Color(0xFFFF6B6B),
            surfaceColor,
            textColor,
            context,
          ),

          const SizedBox(height: 24),

          // Dakar districts section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Quartiers de Dakar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                controller.dakarDistricts.take(8).map((district) {
                  return GestureDetector(
                    onTap: () {
                      controller.destinationController.text = district;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        district,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearch(
    String place,
    Color surfaceColor,
    Color textColor,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        controller.destinationController.text = place;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.history, color: textColor.withOpacity(0.5), size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                place,
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDestination(
    String route,
    String details,
    Color accentColor,
    Color surfaceColor,
    Color textColor,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        final destination = route.split('→')[1].trim();
        controller.destinationController.text = destination;
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.location_on_outlined, color: accentColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
