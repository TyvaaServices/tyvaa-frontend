import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/controllers/publish_ride_controller.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/steps/arrival_step.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/steps/date_step.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/steps/departure_step.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/steps/summary_step.dart';
import 'package:passenger_tyvaa/app/modules/publish_ride/views/steps/time_step.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class PublishRideScreen extends StatefulWidget {
  const PublishRideScreen({Key? key}) : super(key: key);

  @override
  State<PublishRideScreen> createState() => _PublishRideScreenState();
}

class _PublishRideScreenState extends State<PublishRideScreen>
    with TickerProviderStateMixin {
  // Get the controller
  final PublishRideController controller = Get.put(PublishRideController());

  // Animation controllers
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );

    // Register the animation controller with the GetX controller
    controller.setAnimationController(_fadeController);

    // Start animation for the initial page
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = TColors.background(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.getStepTitle(),
            style: TTypography.headingSmall(context),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
          onPressed: controller.previousStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Obx(
                () => LinearProgressIndicator(
                  value:
                      (PublishStepType.values.indexOf(
                            controller.currentStep.value,
                          ) +
                          1) /
                      PublishStepType.values.length,
                  backgroundColor:
                      isDarkMode ? TColors.neutral700 : TColors.neutral200,
                  valueColor: AlwaysStoppedAnimation<Color>(TColors.primary),
                  borderRadius: BorderRadius.circular(TRadius.pill),
                  minHeight: 6,
                ),
              ),
            ),

            const SizedBox(height: TSpacing.md),

            // Main content area with steps
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swiping
                children: [
                  // Step 1: Departure point
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: DepartureStep(controller: controller),
                    ),
                  ),

                  // Step 2: Arrival point
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ArrivalStep(controller: controller),
                    ),
                  ),

                  // Step 3: Time selection
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TimeStep(controller: controller),
                    ),
                  ),

                  // Step 4: Date selection (specific or recurring)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: DateStep(controller: controller),
                    ),
                  ),

                  // Step 5: Summary
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SummaryStep(controller: controller),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.all(TSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.currentStep.value == PublishStepType.summary
                            ? controller.publishRide
                            : controller.nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: TRadius.buttonRadius,
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      controller.getButtonText(),
                      style: TTextStyles.buttonStatic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
