import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/routes/app_pages.dart';

import '../../../themes/design_system.dart';

class PublierTrajetOnboarding extends StatefulWidget {
  final VoidCallback? onComplete;

  const PublierTrajetOnboarding({super.key, this.onComplete});

  @override
  State<PublierTrajetOnboarding> createState() =>
      _PublierTrajetOnboardingState();
}

class _PublierTrajetOnboardingState extends State<PublierTrajetOnboarding>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();

    _pageController.addListener(() {
      // Update animation when page changes
      if (_pageController.page!.round() != _currentPage.value) {
        _currentPage.value = _pageController.page!.round();
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = TColors.background(context);
    final cardColor = TColors.surface(context);
    final textColor = TColors.textPrimary(context);
    final subtitleColor = TColors.textSecondary(context);
    final accentColor = TColors.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned.fill(
              child: CustomPaint(
                painter: BackgroundPainter(
                  isDarkMode: isDarkMode,
                  accentColor: accentColor,
                ),
              ),
            ),

            // App bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button with custom design
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? TColors.surface(context)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color:
                              isDarkMode
                                  ? Colors.white
                                  : TColors.textPrimary(context),
                          size: 18,
                        ),
                      ),
                    ),

                    // Skip button
                    Obx(
                      () =>
                          _currentPage.value < _onboardingData.length - 1
                              ? GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    _onboardingData.length - 1,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isDarkMode
                                            ? TColors.surface(context)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Passer',
                                    style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),

            // Main content
            Column(
              children: [
                const SizedBox(height: 70), // Space for the app bar
                // Page view
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onboardingData.length,
                    onPageChanged: (index) {
                      _currentPage.value = index;
                      _animationController.reset();
                      _animationController.forward();
                    },
                    itemBuilder: (context, index) {
                      final item = _onboardingData[index];
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildOnboardingPage(
                            context,
                            item,
                            cardColor,
                            textColor,
                            subtitleColor,
                            accentColor,
                            isDarkMode,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom navigation
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 32,
                  ),
                  child: Column(
                    children: [
                      // Custom page indicator
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 4,
                              width: _currentPage.value == index ? 24 : 8,
                              decoration: BoxDecoration(
                                color:
                                    _currentPage.value == index
                                        ? accentColor
                                        : (isDarkMode
                                            ? Colors.white30
                                            : Colors.black12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Next/Complete button
                      Obx(
                        () => _buildPrimaryButton(
                          _currentPage.value == _onboardingData.length - 1
                              ? 'Commencer'
                              : 'Suivant',
                          () {
                            if (_currentPage.value <
                                _onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              if (widget.onComplete != null) {
                                widget.onComplete!();
                              } else {
                                Get.toNamed(Routes.PUBLISH_TRAJET);
                              }
                            }
                          },
                          isDarkMode,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
    BuildContext context,
    OnboardingItem item,
    Color cardColor,
    Color textColor,
    Color subtitleColor,
    Color accentColor,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Image/Illustration area
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background glow
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          accentColor.withOpacity(0.2),
                          accentColor.withOpacity(0.0),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),

                  // Main image
                  Hero(
                    tag: item.image,
                    child: Image.asset(
                      item.image,
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Decorative elements based on index
                  ..._buildDecorativeElements(
                    accentColor,
                    isDarkMode,
                    _currentPage.value,
                  ),
                ],
              ),
            ),
          ),

          // Content card
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    item.badge,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  item.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                Text(
                  item.description,
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 12),

                // Feature list
                ...item.features.map(
                  (feature) => _buildFeatureItem(
                    feature,
                    accentColor,
                    textColor,
                    isDarkMode,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDecorativeElements(
    Color accentColor,
    bool isDarkMode,
    int pageIndex,
  ) {
    // Different decorative elements for each page
    switch (pageIndex) {
      case 0:
        return [
          Positioned(
            top: 50,
            right: 30,
            child: _buildDecorativeShape(accentColor, isDarkMode, 0),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: _buildDecorativeShape(accentColor, isDarkMode, 1),
          ),
        ];
      case 1:
        return [
          Positioned(
            top: 60,
            left: 30,
            child: _buildDecorativeShape(accentColor, isDarkMode, 2),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            child: _buildDecorativeShape(accentColor, isDarkMode, 3),
          ),
        ];
      case 2:
        return [
          Positioned(
            top: 40,
            left: 60,
            child: _buildDecorativeShape(accentColor, isDarkMode, 4),
          ),
          Positioned(
            bottom: 80,
            right: 30,
            child: _buildDecorativeShape(accentColor, isDarkMode, 5),
          ),
        ];
      default:
        return [
          Positioned(
            top: 60,
            right: 40,
            child: _buildDecorativeShape(accentColor, isDarkMode, 6),
          ),
          Positioned(
            bottom: 60,
            left: 50,
            child: _buildDecorativeShape(accentColor, isDarkMode, 7),
          ),
        ];
    }
  }

  Widget _buildDecorativeShape(
    Color accentColor,
    bool isDarkMode,
    int variant,
  ) {
    final shapes = [
      // Different decorative shapes
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor.withOpacity(0.15),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
        ),
      ),
      Icon(Icons.star_rounded, size: 20, color: accentColor.withOpacity(0.3)),
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      Icon(Icons.favorite, size: 16, color: accentColor.withOpacity(0.3)),
      Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor.withOpacity(0.15),
        ),
      ),
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
        ),
      ),
    ];

    return shapes[variant % shapes.length];
  }

  Widget _buildFeatureItem(
    String feature,
    Color accentColor,
    Color textColor,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(Icons.check, size: 12, color: accentColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    VoidCallback onPressed,
    bool isDarkMode,
  ) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TColors.primary, TColors.primary.withBlue(220)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Onboarding data
  final List<OnboardingItem> _onboardingData = [
    OnboardingItem(
      image: 'assets/images/publier_trajet_1.png',
      badge: 'NOUVEAU',
      title: 'Publiez votre trajet en toute simplicité',
      description:
          'Créez et partagez facilement vos déplacements avec la communauté Tyvaa.',
      features: [
        'Définissez vos points de départ et d\'arrivée',
        'Choisissez date et heure de départ',
        'Indiquez le nombre de places disponibles',
      ],
    ),
    OnboardingItem(
      image: 'assets/images/publier_trajet_2.png',
      badge: 'ÉCONOMISEZ',
      title: 'Réduisez vos frais de déplacement',
      description:
          'Partagez les coûts de transport avec d\'autres voyageurs sur votre itinéraire.',
      features: [
        'Définissez votre tarif par passager',
        'Recevez les paiements via l\'application',
        'Économisez sur vos frais de carburant',
      ],
    ),
    OnboardingItem(
      image: 'assets/images/publier_trajet_3.png',
      badge: 'CONTRÔLE',
      title: 'Gérez vos trajets comme vous le souhaitez',
      description:
          'Vous gardez le contrôle total sur vos déplacements partagés.',
      features: [
        'Acceptez ou refusez les demandes',
        'Modifiez ou annulez vos trajets',
        'Consultez les profils des passagers',
      ],
    ),
    OnboardingItem(
      image: 'assets/images/publier_trajet_4.png',
      badge: 'COMMUNAUTÉ',
      title: 'Rejoignez une communauté de confiance',
      description:
          'Créez des liens et développez votre réseau tout en voyageant.',
      features: [
        'Système de notation conducteur/passager',
        'Avis et commentaires vérifiés',
        'Construisez votre réputation sur Tyvaa',
      ],
    ),
  ];
}

class OnboardingItem {
  final String image;
  final String badge;
  final String title;
  final String description;
  final List<String> features;

  OnboardingItem({
    required this.image,
    required this.badge,
    required this.title,
    required this.description,
    required this.features,
  });
}

class BackgroundPainter extends CustomPainter {
  final bool isDarkMode;
  final Color accentColor;

  BackgroundPainter({required this.isDarkMode, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDarkMode ? Color(0xFF222226) : Colors.white,
              isDarkMode ? TColors.darkBackground : TColors.neutral100,
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw accent decorations
    final decorPaint =
        Paint()
          ..color = accentColor.withOpacity(isDarkMode ? 0.03 : 0.05)
          ..style = PaintingStyle.fill;

    // Top right decoration
    final path1 =
        Path()
          ..moveTo(size.width * 0.7, 0)
          ..quadraticBezierTo(
            size.width * 0.85,
            size.height * 0.15,
            size.width,
            size.height * 0.1,
          )
          ..lineTo(size.width, 0)
          ..close();

    // Bottom left decoration
    final path2 =
        Path()
          ..moveTo(0, size.height * 0.85)
          ..quadraticBezierTo(
            size.width * 0.15,
            size.height * 0.95,
            size.width * 0.2,
            size.height,
          )
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path1, decorPaint);
    canvas.drawPath(path2, decorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
