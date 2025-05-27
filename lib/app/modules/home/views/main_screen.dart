import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:passenger_tyvaa/app/modules/profile/views/profile_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../themes/tyvaa_theme.dart';
import '../../chatbot/views/chooseChat_view.dart';
import '../controllers/home_controller.dart';
import 'home_view.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Widget> pages = [
        HomeScreen(key: const ValueKey('home')),
        const HistoriqueScreen(key: ValueKey('historique')),
        const ChooseChatbotScreen(key: ValueKey('chat')),
        const ProfileScreen(key: ValueKey('profile')),
      ];

      return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: pages[controller.selectedIndex.value],
        ),
        bottomNavigationBar: StylishBottomBar(
          option: BubbleBarOptions(barStyle: BubbleBarStyle.horizontal),
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          backgroundColor: AppColors.backgroundColor,
          items: [
            BottomBarItem(
              icon: Icon(Icons.home_outlined, color: AppColors.textColor),
              title: Text(
                'Accueil',
                style: TextStyle(color: AppColors.textColor),
              ),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.home, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.history_outlined, color: AppColors.textColor),
              title: Text(
                'Historique',
                style: TextStyle(color: AppColors.textColor),
              ),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.history, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.chat_outlined, color: AppColors.textColor),
              title: Text(
                'Assistant',
                style: TextStyle(color: AppColors.textColor),
              ),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.chat, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.person_outline, color: AppColors.textColor),
              title: Text(
                'Profil',
                style: TextStyle(color: AppColors.textColor),
              ),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      );
    });
  }
}

class HistoriqueScreen extends GetView<HomeController> {
  const HistoriqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar
                SliverAppBar(
                  floating: true,
                  snap: true,
                  elevation: 0,
                  backgroundColor: AppColors.backgroundColor,
                  centerTitle: false,
                  title: Text(
                    'Historique',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        _showFilterBottomSheet(context);
                      },
                    ),
                  ],
                ),

                // Search bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Rechercher dans l\'historique',
                          hintStyle: TextStyle(
                            color: AppColors.secondaryTextColor,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primaryColor,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Recurrent Rides Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trajets récurrents',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Recurrent Rides List
                SliverToBoxAdapter(
                  child: _buildRecurrentRidesList(
                    AppColors.surfaceColor,
                    AppColors.textColor,
                    AppColors.secondaryTextColor,
                    AppColors.primaryColor,
                  ),
                ),

                // One-time Rides Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trajets uniques',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // One-time Rides List
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildRideHistoryItem(
                        AppColors.surfaceColor,
                        AppColors.textColor,
                        AppColors.secondaryTextColor,
                        AppColors.primaryColor,
                        index,
                      );
                    },
                    childCount: 10, // Replace with actual count from your data
                  ),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecurrentRidesList(
    Color surfaceColor,
    Color textColor,
    Color subtitleColor,
    Color primaryColor,
  ) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5, // Replace with actual recurrent rides count
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.repeat, size: 14, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          'Récurrent',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Dakar, Ouest Foire',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          height: 25,
                          width: 1,
                          color: subtitleColor.withOpacity(0.3),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 10,
                            color: AppColors.error,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Rufisque, Cité Tacko',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: subtitleColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Lun, Mer, Ven',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: subtitleColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '08:00',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2 500 FCFA',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                            ),
                            child: Text(
                              'Détails',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRideHistoryItem(
    Color surfaceColor,
    Color textColor,
    Color subtitleColor,
    Color primaryColor,
    int index,
  ) {
    // Alternate status for demo purposes
    final statuses = ['Terminé', 'Annulé', 'Terminé', 'Terminé', 'Annulé'];
    final status = statuses[index % statuses.length];
    final statusColor =
        status == 'Terminé' ? AppColors.success : AppColors.error;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${15 - index} Mai 2025',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.circle, size: 10, color: AppColors.success),
                    Container(
                      height: 25,
                      width: 1,
                      color: subtitleColor.withOpacity(0.3),
                    ),
                    Icon(Icons.location_on, size: 10, color: AppColors.error),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dakar, Point E',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Mbour, Saly Portudal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: subtitleColor.withOpacity(0.2)),
                  ),
                  child: Text(
                    '${1500 + (index * 200)} FCFA',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: primaryColor.withOpacity(0.1),
                      child: Icon(Icons.person, size: 18, color: primaryColor),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Amadou Diallo',
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 18, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filtrer l\'historique',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: AppColors.textColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Type de trajet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        _buildFilterChip(
                          'Tous',
                          true,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Récurrents',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Uniques',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Statut',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        _buildFilterChip(
                          'Tous',
                          true,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Terminés',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Annulés',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Période',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        _buildFilterChip(
                          'Tout',
                          true,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Cette semaine',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Ce mois',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                        _buildFilterChip(
                          'Cette année',
                          false,
                          AppColors.primaryColor,
                          AppColors.surfaceColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Appliquer les filtres',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool isSelected,
    Color primaryColor,
    Color surfaceColor,
  ) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {},
      backgroundColor: surfaceColor,
      selectedColor: primaryColor.withOpacity(0.1),
      checkmarkColor: primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? primaryColor : Colors.grey,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? primaryColor : Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}
