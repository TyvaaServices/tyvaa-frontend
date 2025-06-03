import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/controllers/driver_verification_controller.dart';
import 'package:passenger_tyvaa/app/modules/driver_verification/views/steps/steps.dart';
import 'package:passenger_tyvaa/app/themes/design_system.dart';

class DriverVerificationView extends GetView<DriverVerificationController> {
  const DriverVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(child: Obx(() => _buildCurrentStep(context))),
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (controller.currentStep.value) {
      case 0:
        return WelcomeStep(controller: controller);
      case 1:
        return DriverLicenseStep(controller: controller);
      case 2:
        return CarteGriseStep(controller: controller);
      case 3:
        return IdentityStep(controller: controller);
      case 4:
        return ReviewStep(controller: controller);
      case 5:
        return SuccessStep(controller: controller);
      default:
        return WelcomeStep(controller: controller);
    }
  }
}
