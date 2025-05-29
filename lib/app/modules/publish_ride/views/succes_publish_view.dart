import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/home/views/main_screen.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class RidePublishedSuccessScreen extends StatefulWidget {
  const RidePublishedSuccessScreen({Key? key}) : super(key: key);

  @override
  State<RidePublishedSuccessScreen> createState() =>
      _RidePublishedSuccessScreenState();
}

class _RidePublishedSuccessScreenState extends State<RidePublishedSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for the success icon
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Slide animation for content
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Pulse animation for the success icon
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animations
    _scaleController.forward();
    _slideController.forward();

    // Start pulse animation with delay and repeat
    Future.delayed(const Duration(milliseconds: 800), () {
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSpacing.xl),
          child: Column(
            children: [
              // Success Animation Area
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Success Icon with Pulse
                      AnimatedBuilder(
                        animation: Listenable.merge([
                          _scaleAnimation,
                          _pulseAnimation,
                        ]),
                        builder: (context, child) {
                          return Transform.scale(
                            scale:
                                _scaleAnimation.value * _pulseAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    TColors.success,
                                    TColors.success.withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: TColors.success.withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: TSpacing.xl),

                      // Success message with slide animation
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Trajet Publié !',
                                style: TTypography.headingLarge(
                                  context,
                                ).copyWith(
                                  color: TColors.success,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: TSpacing.md),

                              Text(
                                'Votre trajet est maintenant visible par tous les passagers de votre zone',
                                style: TTypography.bodyLarge(context).copyWith(
                                  color: TColors.textSecondary(context),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Information Cards
              Expanded(
                flex: 2,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        // What happens next card
                        Container(
                          padding: const EdgeInsets.all(TSpacing.lg),
                          decoration: BoxDecoration(
                            color: TColors.surface(context),
                            borderRadius: TRadius.cardRadius,
                            border: Border.all(
                              color: TColors.primary.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: TShadows.subtle,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(TSpacing.sm),
                                decoration: BoxDecoration(
                                  color: TColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notifications_active_outlined,
                                  color: TColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: TSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Notifications activées',
                                      style: TTypography.headingSmall(context),
                                    ),
                                    const SizedBox(height: TSpacing.xs),
                                    Text(
                                      'Vous recevrez une notification dès qu\'un passager s\'intéresse à votre trajet',
                                      style: TTypography.bodySmall(
                                        context,
                                      ).copyWith(
                                        color: TColors.textSecondary(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: TSpacing.lg),

                        // Stats card
                        Container(
                          padding: const EdgeInsets.all(TSpacing.lg),
                          decoration: BoxDecoration(
                            color: TColors.surface(context),
                            borderRadius: TRadius.cardRadius,
                            border: Border.all(
                              color: TColors.accent.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: TShadows.subtle,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(TSpacing.sm),
                                decoration: BoxDecoration(
                                  color: TColors.accent.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.trending_up_rounded,
                                  color: TColors.accent,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: TSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visibilité maximale',
                                      style: TTypography.headingSmall(context),
                                    ),
                                    const SizedBox(height: TSpacing.xs),
                                    Text(
                                      'Votre trajet apparaît en priorité dans les recherches correspondantes',
                                      style: TTypography.bodySmall(
                                        context,
                                      ).copyWith(
                                        color: TColors.textSecondary(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Action Buttons
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Primary action - View my rides
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.offAll(HistoriqueScreen());
                          },
                          icon: const Icon(Icons.list_alt_rounded),
                          label: const Text('Voir mes trajets'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: TRadius.buttonRadius,
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),

                      const SizedBox(height: TSpacing.md),

                      // Secondary action - Back to home
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Get.offAllNamed(
                              '/main',
                            ); // Adjust route name as needed
                          },
                          icon: const Icon(Icons.home_rounded),
                          label: const Text('Retour à l\'accueil'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: TColors.primary,
                            side: BorderSide(color: TColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: TRadius.buttonRadius,
                            ),
                          ),
                        ),
                      ),
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
}
