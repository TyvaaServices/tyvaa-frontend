import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildSearchSection(context),
            _buildHistoryList(context),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60,
      floating: true,
      snap: true,
      surfaceTintColor: Colors.transparent,
      pinned: false,
      backgroundColor: TColors.background(context),
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historique',
                style: TTypography.displaySmall(
                  context,
                ).copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
              ),
              Row(
                children: [
                  _buildIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () => _showSearchBottomSheet(context),
                    context: context,
                  ),
                  const SizedBox(width: 8),
                  _buildIconButton(
                    icon: Icons.tune_rounded,
                    onPressed: () => _showFilterActionSheet(context),
                    context: context,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.surface(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: TShadows.subtle,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: TColors.textPrimary(context), size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: AnimatedContainer(
          duration: TAnimations.medium,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: TColors.neutral300.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: TShadows.subtle,
          ),
          child: TextField(
            style: TTypography.bodyMedium(context),
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.search_rounded,
                  color: TColors.textSecondary(context),
                  size: 20,
                ),
              ),
              suffixIcon: Container(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.neutral200.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '⌘K',
                    style: TTypography.labelSmall(context).copyWith(
                      color: TColors.textSecondary(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              hintText: 'Rechercher un trajet...',
              hintStyle: TTypography.bodyMedium(
                context,
              ).copyWith(color: TColors.textSecondary(context)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildFilterTab(String text, bool isSelected, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: TAnimations.short,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? TColors.primary : TColors.surface(context),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                isSelected
                    ? TColors.primary
                    : TColors.neutral300.withOpacity(0.4),
            width: 1,
          ),
          boxShadow: isSelected ? TShadows.medium : TShadows.subtle,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              // Handle filter selection with haptic feedback
              HapticFeedback.lightImpact();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                text,
                style: TTypography.labelMedium(context).copyWith(
                  color:
                      isSelected ? Colors.white : TColors.textPrimary(context),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 150 + (index * 50)),
            curve: Curves.easeOutCubic,
            child: _buildHistoryCard(index, context),
          );
        }, childCount: 20),
      ),
    );
  }

  Widget _buildHistoryCard(int index, BuildContext context) {
    final statuses = ['Terminé', 'Annulé', 'Terminé', 'Terminé', 'Annulé'];
    final status = statuses[index % statuses.length];
    final statusColor = status == 'Terminé' ? TColors.success : TColors.error;
    final price = 1500 + (index * 200);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: TColors.surface(context),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: TColors.neutral200.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: TColors.primary.withOpacity(0.02),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Dismissible(
              key: Key('history_$index'),
              direction: DismissDirection.endToStart,
              background: _buildDismissBackground(),
              confirmDismiss: (direction) => _showDeleteConfirmation(context),
              onDismissed: (direction) => _showDeleteSnackbar(context),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  HapticFeedback.lightImpact();
                  Get.toNamed('/trajet-details', arguments: {'id': index});
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildCardHeader(index, status, statusColor, context),
                      const SizedBox(height: 16),
                      _buildRouteInfo(context),
                      const SizedBox(height: 16),
                      _buildCardFooter(price, context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader(
    int index,
    String status,
    Color statusColor,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TColors.neutral200.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: TColors.textSecondary(context),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${15 - (index % 15)} Mai 2025',
                  style: TTypography.labelMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                Text('14:30', style: TTypography.bodySmall(context)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: TTypography.labelSmall(
                  context,
                ).copyWith(color: statusColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: TColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: TColors.primary.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [TColors.primary, TColors.primary.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 12,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationRow('Dakar, Point E', 'Départ', context),
              const SizedBox(height: 28),
              _buildLocationRow('Rufisque, Cité Tacko', 'Arrivée', context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(String location, String type, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TTypography.labelSmall(context).copyWith(
            color: TColors.textSecondary(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          location,
          style: TTypography.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.1),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCardFooter(int price, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: TColors.primary.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: TColors.primary.withOpacity(0.1),
                backgroundImage: const AssetImage(
                  'assets/images/default_profile.png',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amadou D.',
                  style: TTypography.labelMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 12, color: TColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TTypography.bodySmall(
                        context,
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TColors.primary.withOpacity(0.1),
                TColors.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: TColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            '$price FCFA',
            style: TTypography.labelLarge(context).copyWith(
              color: TColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TColors.error.withOpacity(0.8), TColors.error],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Supprimer',
            style: TTypography.labelSmall(
              Get.context!,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _showFilterActionSheet(context);
        },
        backgroundColor: TColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.tune_rounded, color: Colors.white, size: 24),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: TColors.surface(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Supprimer ce trajet?',
              style: TTypography.headingMedium(context),
            ),
            content: Text(
              'Cette action est définitive et ne peut pas être annulée.',
              style: TTypography.bodyMedium(context),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Annuler',
                  style: TTypography.labelLarge(
                    context,
                  ).copyWith(color: TColors.textSecondary(context)),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Supprimer',
                  style: TTypography.labelLarge(
                    context,
                  ).copyWith(color: TColors.error, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );
  }

  void _showDeleteSnackbar(BuildContext context) {
    Get.snackbar(
      'Trajet supprimé',
      'Le trajet a été supprimé de l\'historique',
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: TColors.surface(context),
      colorText: TColors.textPrimary(context),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  decoration: BoxDecoration(
                    color: TColors.textSecondary(context).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Rechercher dans l\'historique...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: TColors.neutral200.withOpacity(0.3),
                    ),
                  ),
                ),
                // Add search results here
              ],
            ),
          ),
    );
  }

  void _showFilterActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: TColors.surface(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: TColors.textSecondary(context).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(
                    'Filtrer par',
                    style: TTypography.headingMedium(context),
                  ),
                  const SizedBox(height: 24),
                  ...[
                        'Tous les trajets',
                        'Cette semaine',
                        'Ce mois',
                        'Trajets terminés',
                        'Trajets annulés',
                        'En tant que passager',
                        'En tant que conducteur',
                      ]
                      .map(
                        (filter) => _buildFilterOption(
                          filter,
                          filter == 'Tous les trajets',
                          context,
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: TTypography.labelLarge(context).copyWith(
                          color: TColors.primary,
                          fontWeight: FontWeight.w600,
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

  Widget _buildFilterOption(
    String text,
    bool isSelected,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? TColors.primary.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isSelected
                        ? TColors.primary.withOpacity(0.2)
                        : Colors.transparent,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TTypography.bodyMedium(context).copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color:
                        isSelected
                            ? TColors.primary
                            : TColors.textPrimary(context),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: TColors.primary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
