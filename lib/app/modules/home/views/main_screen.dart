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
              title: Text('Accueil', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.home, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.history_outlined, color: AppColors.textColor),
              title: Text('Historique', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.history, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.chat_outlined, color: AppColors.textColor),
              title: Text('Assistant', style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.primaryColor,
              selectedColor: Colors.white,
              selectedIcon: Icon(Icons.chat, color: Colors.white),
            ),
            BottomBarItem(
              icon: Icon(Icons.person_outline, color: AppColors.textColor),
              title: Text('Profil', style: TextStyle(color: Colors.white)),
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
        child: Column(
          children: [
            // Clean, minimal header design
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Simple header with title and actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Clean title
                      Text(
                        'Historique',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),

                      // Simple action buttons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: AppColors.textColor,
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: Icon(
                              Icons.filter_list_rounded,
                              color: AppColors.textColor,
                            ),
                            onPressed: () => _showFilterActionSheet(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Clean search bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.secondaryTextColor,
                          size: 20,
                        ),
                        hintText: 'Rechercher un trajet...',
                        hintStyle: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Simple filter tabs
            Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                children: [
                  _buildFilterTab('Tous', true),
                  _buildFilterTab('Cette semaine', false),
                  _buildFilterTab('Ce mois', false),
                ],
              ),
            ),

            // Replaced the ugly black divider with a subtle spacer
            const SizedBox(height: 4),

            // History list with existing iOS-style cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: 20, // Replace with actual count
                itemBuilder: (context, index) {
                  return _buildHistoryCard(index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterActionSheet(context),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTab(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color:
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.secondaryTextColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            width: text.length * 5.0,
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {},
        backgroundColor: AppColors.surfaceColor,
        selectedColor: AppColors.primaryColor.withOpacity(0.15),
        checkmarkColor: AppColors.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primaryColor : AppColors.textColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
            width: 1,
          ),
        ),
        elevation: isSelected ? 1 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      ),
    );
  }

  Widget _buildSegmentButton(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? (AppColors.isDark ? Colors.black : Colors.white)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            text,
            style: TextStyle(
              color:
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.secondaryTextColor,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(int index) {
    // Alternate status for demo purposes
    final statuses = ['Terminé', 'Annulé', 'Terminé', 'Terminé', 'Annulé'];
    final status = statuses[index % statuses.length];
    final statusColor =
        status == 'Terminé' ? AppColors.success : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: Key('history_$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: AppColors.error,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete, color: Colors.white),
                const SizedBox(height: 4),
                Text(
                  'Supprimer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: Get.context!,
              builder:
                  (context) => AlertDialog(
                    title: Text('Supprimer ce trajet?'),
                    content: Text('Cette action est définitive.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          'Supprimer',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
            );
          },
          onDismissed: (direction) {
            Get.snackbar(
              'Trajet supprimé',
              'Le trajet a été supprimé de l\'historique',
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.all(16),
              borderRadius: 10,
              backgroundColor: AppColors.surfaceColor,
              colorText: AppColors.textColor,
              duration: const Duration(seconds: 2),
            );
          },
          child: InkWell(
            onTap:
                () => Get.toNamed('/trajet-details', arguments: {'id': index}),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header with date and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: AppColors.secondaryTextColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${15 - (index % 15)} Mai 2025',
                            style: TextStyle(
                              color: AppColors.secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Trip details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route visualization
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 30,
                            color: AppColors.primaryColor.withOpacity(0.3),
                          ),
                          Icon(
                            Icons.location_on,
                            color: AppColors.primaryColor,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),

                      // Origin and destination
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dakar, Point E',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Rufisque, Cité Tacko',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Footer with price and details button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primaryColor.withOpacity(
                              0.1,
                            ),
                            backgroundImage: AssetImage(
                              'assets/images/default_profile.png',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Amadou D.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${1500 + (index * 200)} FCFA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryTextColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Filtrer par',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  _buildActionSheetButton('Tous les trajets', true),
                  _buildActionSheetButton('Cette semaine', false),
                  _buildActionSheetButton('Ce mois', false),
                  _buildActionSheetButton('Trajets terminés', false),
                  _buildActionSheetButton('Trajets annulés', false),
                  _buildActionSheetButton('En tant que passager', false),
                  _buildActionSheetButton('En tant que conducteur', false),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildActionSheetButton(String text, bool isSelected) {
    return TextButton(
      onPressed: () => Navigator.of(Get.context!).pop(),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          if (isSelected) Icon(Icons.check, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
