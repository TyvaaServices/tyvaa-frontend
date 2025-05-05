import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/tyvaa_theme.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    // Define dynamic colors based on the theme (light or dark)
    Color backgroundColor = brightness == Brightness.dark ? AppColors.darkBackground : AppColors.background;
    Color appBarColor = brightness == Brightness.dark ? AppColors.darkBackground : AppColors.background;
    Color textColor = brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    Color cardColor = brightness == Brightness.dark ? AppColors.cardDark : AppColors.card;
    Color buttonTextColor = brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    Color buttonColor = brightness == Brightness.dark ? AppColors.primaryDark : AppColors.primary;
    Color promoTitleColor = brightness == Brightness.dark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    Color promoCardOverlayColor = brightness == Brightness.dark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.3);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(appBarColor, textColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 34),
            _buildWelcomeCard(cardColor),
            SizedBox(height: 24),
            _buildQuickActions(),
            SizedBox(height: 24),
            _buildSearchButton(buttonColor, buttonTextColor),
            SizedBox(height: 24),
            _buildPromoSection(promoTitleColor, promoCardOverlayColor),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Color appBarColor, Color textColor) {
    return AppBar(
      backgroundColor: appBarColor,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.white)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bonjour 👋🏾', style: TextStyle(fontSize: 14, color: textColor)),
              Text('Cheikh Tidiane', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
            ],
          )
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
      ],
    );
  }

  Widget _buildWelcomeCard(Color cardColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Bienvenue sur Tyvaa 👋', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Prêt à voyager avec la communauté ?', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(Color buttonColor, Color buttonTextColor) {
    return PrimaryButton(
      text: "Rechercher un trajet",
      isWide: false,
      onPressed: () {},
      color: buttonColor,
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAction(Icons.book_online, 'Réservations', AppColors.primary, () {}),
          _buildAction(Icons.history, 'Historique', AppColors.info, () {}),
          _buildAction(Icons.support_agent, 'Aide', AppColors.accent, () {}),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(radius: 28, backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Updated promo section with Obx and dynamic colors
  Widget _buildPromoSection(Color promoTitleColor, Color promoCardOverlayColor) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Promotions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: promoTitleColor)),
              Obx(() => Row(
                children: List.generate(controller.banners.length, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentBanner.value == index
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.2),
                    ),
                  );
                }),
              )),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller.bannerController,
            onPageChanged: (index) => controller.currentBanner.value = index,
            itemCount: controller.banners.length,
            itemBuilder: (context, index) {
              final banner = controller.banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage(banner['image']!), fit: BoxFit.cover),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: promoCardOverlayColor,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(banner['title']!,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(banner['subtitle']!, style: const TextStyle(fontSize: 14, color: Colors.white)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
