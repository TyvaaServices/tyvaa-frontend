import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/profile/views/profile_view.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../themes/design_system.dart';
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
        bottomNavigationBar: Material(
          elevation: 8,
          color: TColors.background(context),
          child: SizedBox(
            height: Get.height * 0.09,
            child: StylishBottomBar(
              option: BubbleBarOptions(
                barStyle: BubbleBarStyle.horizontal,
                bubbleFillStyle: BubbleFillStyle.fill,
                opacity: 1,
              ),
              items: [
                BottomBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: TColors.textPrimary(context),
                  ),
                  title: Text(
                    'Accueil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                  backgroundColor: TColors.primary,
                  selectedColor: Colors.white,
                  selectedIcon: Icon(Icons.home, color: Colors.white),
                ),
                BottomBarItem(
                  icon: Icon(
                    Icons.history_outlined,
                    color: TColors.textPrimary(context),
                  ),
                  title: Text(
                    'Historique',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                  backgroundColor: TColors.primary,
                  selectedColor: Colors.white,
                  selectedIcon: Icon(Icons.history, color: Colors.white),
                ),
                BottomBarItem(
                  icon: Icon(
                    Icons.chat_outlined,
                    color: TColors.textPrimary(context),
                  ),
                  title: Text(
                    'Assistant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                  backgroundColor: TColors.primary,
                  selectedColor: Colors.white,
                  selectedIcon: Icon(Icons.chat, color: Colors.white),
                ),
                BottomBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    color: TColors.textPrimary(context),
                  ),
                  title: Text(
                    'Profil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.width * 0.03,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                  backgroundColor: TColors.primary,
                  selectedColor: Colors.white,
                  selectedIcon: Icon(Icons.person, color: Colors.white),
                ),
              ],
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeTab,
              backgroundColor: TColors.background(context),
            ),
          ),
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
      backgroundColor: TColors.background(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildCleanHeader(context),
            Expanded(
              child: _buildCleanHistoryList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCleanHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        border: Border(
          bottom: BorderSide(
            color: TColors.neutral300.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          // Simple header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Historique',
                  style: TTypography.headingLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // Simple filter button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: TColors.neutral200.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: TColors.textPrimary(context),
                    size: 18,
                  ),
                  onPressed: () => _showSimpleFilterSheet(context),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Clean filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'Tous', true),
                const SizedBox(width: 12),
                _buildFilterChip(context, 'Terminés', false),
                const SizedBox(width: 12),
                _buildFilterChip(context, 'Cette semaine', false),
                const SizedBox(width: 12),
                _buildFilterChip(context, 'Passager', false),
                const SizedBox(width: 12),
                _buildFilterChip(context, 'Conducteur', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? TColors.primary
            : TColors.neutral200.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? null
            : Border.all(
                color: TColors.neutral300.withOpacity(0.5),
                width: 0.5,
              ),
      ),
      child: Text(
        label,
        style: TTypography.labelMedium(context).copyWith(
          color: isSelected
              ? Colors.white
              : TColors.textSecondary(context),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCleanHistoryList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
      itemCount: 15,
      itemBuilder: (context, index) {
        return _buildCleanHistoryCard(context, index);
      },
    );
  }

  Widget _buildCleanHistoryCard(BuildContext context, int index) {
    final statuses = ['Terminé', 'Annulé', 'Terminé', 'Terminé', 'Annulé'];
    final status = statuses[index % statuses.length];
    final isCompleted = status == 'Terminé';
    final price = 1500 + (index * 200);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TColors.neutral300.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          // Header: Date and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${15 - (index % 15)} Mai 2025',
                    style: TTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '14:30',
                    style: TTypography.bodySmall(context).copyWith(
                      color: TColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? TColors.success.withOpacity(0.1)
                      : TColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TTypography.labelSmall(context).copyWith(
                    color: isCompleted ? TColors.success : TColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Route
          Row(
            children: [
              // Route indicator
              Column(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 24,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: TColors.neutral400.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: TColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Route details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dakar, Point E',
                      style: TTypography.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rufisque, Cité Tacko',
                      style: TTypography.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Footer: Driver and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: TColors.primary.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/default_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amadou D.',
                        style: TTypography.bodySmall(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '4.8',
                            style: TTypography.labelSmall(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '$price FCFA',
                style: TTypography.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: TColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSimpleFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                decoration: BoxDecoration(
                  color: TColors.neutral400.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Fixed header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Filtrer par',
                  style: TTypography.headingMedium(context).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      ...[
                        'Tous les trajets',
                        'Trajets terminés',
                        'Trajets annulés',
                        'Cette semaine',
                        'Ce mois',
                        'En tant que passager',
                        'En tant que conducteur',
                      ].map((filter) => _buildSimpleFilterOption(context, filter)),

                      const SizedBox(height: 20),

                      // Fixed close button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            backgroundColor: TColors.primary.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Fermer',
                            style: TTypography.bodyMedium(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: TColors.primary,
                            ),
                          ),
                        ),
                      ),

                      // Bottom padding for safe area
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleFilterOption(BuildContext context, String text) {
    final isSelected = text == 'Tous les trajets';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? TColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TTypography.bodyMedium(context).copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? TColors.primary
                      : TColors.textPrimary(context),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  color: TColors.primary,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
