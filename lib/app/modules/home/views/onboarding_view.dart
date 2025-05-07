import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../themes/tyvaa_theme.dart';
import '../../../widgets/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  final _controller = PageController();
  final RxInt _currentPage = 0.obs;

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    TextStyle titleStyle =
        brightness == Brightness.dark ? AppTextStyles.h2Dark : AppTextStyles.h2;
    TextStyle subtitleStyle =
        brightness == Brightness.dark
            ? AppTextStyles.bodySecondaryDark
            : AppTextStyles.bodySecondary;
    Color backgroundColor =
        brightness == Brightness.dark
            ? AppColors.darkBackground
            : AppColors.background;
    Color buttonTextColor =
        brightness == Brightness.dark ? Colors.white : AppColors.textOnPrimary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: 3,
            onPageChanged: (index) => _currentPage.value = index,
            itemBuilder:
                (_, index) => _buildPage(index, titleStyle, subtitleStyle),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.primary.withOpacity(0.4),
                    ),
                    onDotClicked:
                        (i) => _controller.animateToPage(
                          i,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                  ),
                  SizedBox(height: 24),
                  PrimaryButton(
                    text: _currentPage.value == 2 ? 'Commencer' : 'Suivant',
                    onPressed: () {
                      if (_currentPage.value < 2) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Get.offAllNamed('/login');
                      }
                    }, // Adjust button text color
                  ),
                ],
              ),
            ),
          ),
        ],
      ).paddingOnly(bottom: Get.height * 0.01),
    );
  }

  Widget _buildPage(int index, TextStyle titleStyle, TextStyle subtitleStyle) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final page = (_controller.hasClients ? _controller.page : 0) ?? 0;
        final delta = (page - index).clamp(-1.0, 1.0);
        final opacity = 1 - delta.abs().toDouble();
        final offsetX = delta * 40.toDouble();

        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(offsetX, 0), child: child),
        );
      },
      child: _OnboardingPage(
        image: 'assets/onboarding_${index + 1}.png',
        title: _titles[index],
        subtitle: _subtitles[index],
        titleStyle: titleStyle,
        subtitleStyle: subtitleStyle,
      ),
    );
  }

  final List<String> _titles = [
    'Bienvenue sur Tyvaa',
    'Chauffeurs vérifiés',
    'Support Interactive',
  ];

  final List<String> _subtitles = [
    'Découvrez une nouvelle façon de vous déplacer au Sénégal, avec sécurité et confort.',
    'Tous nos chauffeurs sont soigneusement sélectionnés et certifiés pour votre sécurité.',
    'Votre assistante virtuelle est là pour vous aider 24/7 pour toute question sur l\'application.',
  ];
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    required this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 400),
          SizedBox(height: 32),
          Text(title, style: titleStyle),
          SizedBox(height: 16),
          Text(subtitle, textAlign: TextAlign.center, style: subtitleStyle),
        ],
      ),
    );
  }
}
