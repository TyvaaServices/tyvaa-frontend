import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/tyvaa_theme.dart';

class SearchTrajetScreen extends StatefulWidget {
  @override
  _SearchTrajetScreenState createState() => _SearchTrajetScreenState();
}

class _SearchTrajetScreenState extends State<SearchTrajetScreen>
    with SingleTickerProviderStateMixin {
  final List<String> allRegions = [
    'Dakar',
    'Saint-Louis',
    'Thiès',
    'Kaolack',
    'Ziguinchor',
    'Tambacounda',
    'Louga',
    'Fatick',
    'Kolda',
    'Matam',
    'Kaffrine',
    'Sédhiou',
    'Kédougou',
    'Diourbel',
  ];

  List<String> filteredRegions = [];
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<IconData> regionIcons = [
    Icons.location_city,
    Icons.landscape,
    Icons.beach_access,
    Icons.agriculture,
    Icons.waves,
    Icons.forest,
    Icons.map,
    Icons.terrain,
    Icons.grass,
    Icons.water,
    Icons.grain,
    Icons.nature_people,
    Icons.house,
  ];

  @override
  void initState() {
    super.initState();
    filteredRegions = allRegions;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterRegions(String query) {
    setState(() {
      filteredRegions =
          allRegions
              .where(
                (region) => region.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final Color backgroundColor =
        isDarkMode ? AppColors.darkBackground : Color(0xFFF9FAFC);
    final Color cardColor = isDarkMode ? AppColors.cardDark : Colors.white;
    final Color textColor =
        isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final Color primaryColor =
        isDarkMode ? AppColors.primaryDark : AppColors.primary;
    final Color accentColor = AppColors.accent;

    final bool isSearching = _searchController.text.isNotEmpty;
    final List<String> displayRegions =
        isSearching ? filteredRegions : filteredRegions.take(5).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.arrow_back, color: primaryColor),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Rechercher',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : primaryColor,
                      ),
                    ),
                    Text(
                      'Trouvez votre destination',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            isDarkMode
                                ? Colors.white70
                                : primaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (!isSearching)
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 8.0,
                bottom: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Régions populaires',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    // '${allRegions.length} régions',
                    '5 regions',
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child:
                displayRegions.isEmpty
                    ? _buildEmptyState(textColor)
                    : _buildResults(
                      displayRegions,
                      cardColor,
                      textColor,
                      primaryColor,
                      accentColor,
                    ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: _buildSearchBar(cardColor, textColor, primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(Color cardColor, Color textColor, Color primaryColor) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _filterRegions,
          style: TextStyle(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Où allez-vous?',
            hintStyle: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: primaryColor,
              size: 24,
            ),
            suffixIcon:
                _searchController.text.isNotEmpty
                    ? IconButton(
                      icon: Icon(Icons.clear, color: primaryColor),
                      onPressed: () {
                        _searchController.clear();
                        _filterRegions('');
                      },
                    )
                    : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color textColor) {
    return FadeTransition(
      opacity: _animation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 60,
              color: textColor.withOpacity(0.3),
            ),
            SizedBox(height: 16),
            Text(
              'Aucune région trouvée',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Essayez avec un autre terme de recherche',
              style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(
    List<String> regions,
    Color cardColor,
    Color textColor,
    Color primaryColor,
    Color accentColor,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24),
      itemCount: regions.length,
      itemBuilder: (context, index) {
        final regionIcon =
            regionIcons[allRegions.indexOf(regions[index]) %
                regionIcons.length];

        return FadeTransition(
          opacity: _animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, 0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  0.4 + (index / regions.length) * 0.6,
                  1.0,
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Get.toNamed('/search-results', arguments: regions[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            regionIcon,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                regions[index],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Sénégal',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: accentColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
