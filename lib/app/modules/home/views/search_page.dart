// search_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/controllers/search_controller.dart';
class SearchView extends GetView<SearchViewController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor   = isDark ? Color(0xFF121212) : Color(0xFFF8F9FD);
    final cardColor = isDark ? Color(0xFF1E1E1E) : Colors.white;
    final primary   = Color(0xFF5E6FE4);
    final accent    = Color(0xFFFF6B6B);
    final txt       = isDark ? Colors.white : Color(0xFF303030);
    final txtSec    = isDark ? Colors.white70 : Color(0xFF757575);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(txt, primary),
            _buildTabs(bgColor, cardColor, primary, txt),
            _buildSearchBar(cardColor, txt, primary),
            Expanded(
              child: Obx(() {
                // Watch both selectedTab and showRecent
                final tabIndex = controller.selectedTab.value;
                final isRecent = controller.showRecent.value;
                return isRecent
                    ? _buildRecentSearches(cardColor, txt, txtSec, primary, accent)
                    : _buildSearchResults(cardColor, txt, txtSec, primary, accent);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color txt, Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: Get.back,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: primary, size: 22),
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Où allez-vous?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: txt)),
              Text('Trouvez votre destination', style: TextStyle(fontSize: 14, color: txt.withOpacity(0.6))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(Color bgColor, Color cardColor, Color primary, Color txt) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      height: 56,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 2))],
      ),
      child:  TabBar(
        controller: controller.tabController,
        indicator: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(28)),
        labelColor: Colors.white,
        unselectedLabelColor: txt.withOpacity(0.7),
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        tabs: [
          Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.directions_bus_rounded, size: 18), SizedBox(width: 6), Text('Long trajet')])),
          Tab(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.directions_car_rounded, size: 18), SizedBox(width: 6), Text('En ville')])),
        ],
      )
    );
  }

  Widget _buildSearchBar(Color cardColor, Color txt, Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: Offset(0, 5))],
        ),
        child: Obx(() {
          final isLong = controller.selectedTab.value == 0;
          final hasText = controller.searchController.text.isNotEmpty;
          return TextField(
            controller: controller.searchController,
            onChanged: controller.filterLocations,
            style: TextStyle(color: txt, fontSize: 16),
            decoration: InputDecoration(
              hintText: isLong ? 'Rechercher une région...' : 'Rechercher un quartier...',
              hintStyle: TextStyle(color: txt.withOpacity(0.5), fontSize: 15),
              prefixIcon: Icon(Icons.search_rounded, color: primary, size: 22),
              suffixIcon: hasText
                  ? IconButton(
                icon: Icon(Icons.clear, color: primary, size: 20),
                onPressed: () {
                  controller.searchController.clear();
                  controller.filterLocations('');
                },
              )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
          );
        }),
      ),
    );
  }
  Widget _buildRecentSearches(Color cardColor, Color txt, Color txtSecondary,
      Color primary, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recherches récentes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: txt,
                ),
              ),
              TextButton(
                onPressed: () => controller.clearRecentSearches(),
                child: Text(
                  'Effacer',
                  style: TextStyle(
                    fontSize: 14,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() =>
          controller.recentSearches.isEmpty
              ? _buildEmptyRecents(txt, primary)
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: controller.recentSearches.length,
            itemBuilder: (_, i) =>
                _buildRecentItem(
                  controller.recentSearches[i],
                  cardColor,
                  txt,
                  txtSecondary,
                  primary,
                ),
          ),
          ),
        ),
        SizedBox(height: 16),
        _buildPopularSection(cardColor, txt, primary, accent),
      ],
    );
  }

  Widget _buildEmptyRecents(Color txt, Color primary) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 56,
            color: primary.withOpacity(0.2),
          ),
          SizedBox(height: 16),
          Text(
            'Aucune recherche récente',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: txt.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Vos recherches apparaîtront ici',
            style: TextStyle(
              fontSize: 14,
              color: txt.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItem(String label, Color cardColor, Color txt,
      Color txtSecondary, Color primary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => controller.selectRecentSearch(label),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.history_rounded,
                      color: primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: txt,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: txtSecondary.withOpacity(0.5),
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularSection(Color cardColor, Color txt, Color primary,
      Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() =>
                  Text(
                    controller.selectedTab.value == 0
                        ? 'Destinations populaires'
                        : 'Quartiers populaires',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: txt,
                    ),
                  )),
              Text(
                '5 éléments',
                style: TextStyle(
                  fontSize: 14,
                  color: txt.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: Obx(() {
            final popularItems = controller.selectedTab.value == 0
                ? controller.popularRegions
                : controller.popularDistricts;

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: popularItems.length > 5 ? 5 : popularItems.length,
              itemBuilder: (context, index) {
                final colors = [
                  primary,
                  accent,
                  Colors.green,
                  Colors.amber,
                  Colors.teal
                ];
                final icons = controller.selectedTab.value == 0
                    ? [
                  Icons.location_city,
                  Icons.landscape,
                  Icons.beach_access,
                  Icons.waves,
                  Icons.agriculture
                ]
                    : [
                  Icons.home,
                  Icons.business,
                  Icons.beach_access,
                  Icons.restaurant,
                  Icons.local_mall
                ];

                return Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Material(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    elevation: 1,
                    shadowColor: Colors.black.withOpacity(0.05),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () =>
                          controller.selectPopularItem(popularItems[index]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colors[index % colors.length]
                                    .withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icons[index % icons.length],
                                color: colors[index % colors.length],
                                size: 20,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              popularItems[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: txt,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSearchResults(Color cardColor, Color txt, Color txtSecondary,
      Color primary, Color accent) {
    return Obx(() {
      final list = controller.selectedTab.value == 0
          ? controller.filteredLong
          : controller.filteredLocal;

      if (list.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 60,
                color: txt.withOpacity(0.3),
              ),
              SizedBox(height: 16),
              Text(
                'Aucun résultat trouvé',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: txt.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Essayez avec un autre terme de recherche',
                style: TextStyle(
                  fontSize: 14,
                  color: txt.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
        itemCount: list.length,
        itemBuilder: (_, i) {
          final iconData = (controller.selectedTab.value == 0
              ? [
            Icons.location_city,
            Icons.landscape,
            Icons.beach_access,
            Icons.agriculture,
            Icons.waves
          ]
              : [
            Icons.home,
            Icons.apartment,
            Icons.business,
            Icons.store,
            Icons.restaurant
          ])[i % 5];
          final iconColor = [
            primary,
            accent,
            Colors.green,
            Colors.amber,
            Colors.teal
          ][i % 5];

          return AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: controller.animationController,
                    curve: Interval(
                      0.1 * (i / list.length),
                      0.6 + 0.4 * (i / list.length),
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(begin: Offset(0, 0.2),
                      end: Offset.zero).animate(
                    CurvedAnimation(
                      parent: controller.animationController,
                      curve: Interval(
                        0.1 * (i / list.length),
                        0.6 + 0.4 * (i / list.length),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: _buildResultItem(
                list[i],
                iconData,
                iconColor,
                cardColor,
                txt,
                txtSecondary,
                accent),
          );
        },
      );
    });
  }

  Widget _buildResultItem(String label, IconData iconData, Color iconColor,
      Color cardColor, Color txt, Color txtSecondary, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.03),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.toNamed('/search-results', arguments: label),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(iconData, color: iconColor, size: 20),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: txt,
                        ),
                      ),
                      SizedBox(height: 2),
                      Obx(() =>
                          Text(
                            controller.selectedTab.value == 0
                                ? 'Sénégal'
                                : 'Dakar',
                            style: TextStyle(
                              fontSize: 13,
                              color: txtSecondary,
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: accent,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}