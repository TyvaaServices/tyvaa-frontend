import 'package:flutter/material.dart';
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
          child: SafeArea(
            top: false,
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
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Historique',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: TColors.textPrimary(context),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: TColors.textPrimary(context),
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: Icon(
                              Icons.filter_list_rounded,
                              color: TColors.textPrimary(context),
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
                          color: TColors.textSecondary(context),
                          size: 20,
                        ),
                        hintText: 'Rechercher un trajet...',
                        hintStyle: TextStyle(
                          color: TColors.textSecondary(context),
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
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: 20,
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
        backgroundColor: TColors.primary,
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
                      ? TColors.primary
                      : TColors.textSecondary(Get.context!),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            width: text.length * 5.0,
            color: isSelected ? TColors.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(
        right: TSpacing.sm,
        top: TSpacing.sm,
        bottom: TSpacing.sm,
      ),
      child: FilterChip(
        label: Text(label, style: TTypography.bodyMedium(Get.context!)),
        selected: isSelected,
        onSelected: (_) {},
        backgroundColor: TColors.surface(Get.context!),
        selectedColor: TColors.primary.withOpacity(0.15),
        checkmarkColor: TColors.primary,
        labelStyle: TextStyle(
          color:
              isSelected ? TColors.primary : TColors.textPrimary(Get.context!),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: TRadius.chipRadius,
          side: BorderSide(
            color: isSelected ? TColors.primary : TColors.neutral300,
            width: 1,
          ),
        ),
        elevation: isSelected ? 1 : 0,
        padding: const EdgeInsets.symmetric(
          horizontal: TSpacing.md,
          vertical: 0,
        ),
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
                    ? (Theme.of(Get.context!).brightness == Brightness.dark
                        ? TColors.darkBackground
                        : TColors.surface(Get.context!))
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(TRadius.sm),
          ),
          child: Text(
            text,
            style: TextStyle(
              color:
                  isSelected
                      ? TColors.primary
                      : TColors.textSecondary(Get.context!),
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(int index) {
    final context = Get.context!;
    final statuses = ['Terminé', 'Annulé', 'Terminé', 'Terminé', 'Annulé'];
    final status = statuses[index % statuses.length];
    final statusColor = status == 'Terminé' ? TColors.success : TColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: TColors.surface(context),
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
            color: TColors.error,
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
                          style: TextStyle(color: TColors.error),
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
              backgroundColor: TColors.surface(context),
              colorText: TColors.textPrimary(context),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: TColors.textSecondary(context),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${15 - (index % 15)} Mai 2025',
                            style: TextStyle(
                              color: TColors.textSecondary(context),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: TColors.primary.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: TColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 30,
                            color: TColors.primary.withOpacity(0.3),
                          ),
                          Icon(
                            Icons.location_on,
                            color: TColors.primary,
                            size: 16,
                          ),
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
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: TColors.textPrimary(context),
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
                                color: TColors.textPrimary(context),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: TColors.primary.withOpacity(0.1),
                            backgroundImage: AssetImage(
                              'assets/images/default_profile.png',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Amadou D.',
                            style: TextStyle(
                              fontSize: 14,
                              color: TColors.textPrimary(context),
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
                          color: TColors.primary,
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
              color: TColors.surface(context),
              borderRadius: BorderRadius.vertical(
                top: TRadius.modalRadius.topRight,
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
                      color: TColors.textSecondary(context).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(TSpacing.xs),
                    ),
                    alignment: Alignment.center,
                  ),
                  Text(
                    'Filtrer par',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: TColors.textPrimary(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildActionSheetButton('Tous les trajets', true, context),
                  _buildActionSheetButton('Cette semaine', false, context),
                  _buildActionSheetButton('Ce mois', false, context),
                  _buildActionSheetButton('Trajets terminés', false, context),
                  _buildActionSheetButton('Trajets annulés', false, context),
                  _buildActionSheetButton(
                    'En tant que passager',
                    false,
                    context,
                  ),
                  _buildActionSheetButton(
                    'En tant que conducteur',
                    false,
                    context,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: TColors.primary,
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

  Widget _buildActionSheetButton(
    String text,
    bool isSelected,
    BuildContext context,
  ) {
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
              color: TColors.textPrimary(context),
              fontWeight: FontWeight.normal,
            ),
          ),
          if (isSelected) Icon(Icons.check, color: TColors.primary),
        ],
      ),
    );
  }
}
