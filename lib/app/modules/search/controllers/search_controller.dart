import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SearchViewController extends GetxController {
  final TextEditingController currentLocationController = TextEditingController(
    text: "Votre position actuelle",
  );
  final TextEditingController destinationController = TextEditingController();
  final FocusNode destinationFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    forceFocus();
  }

  void forceFocus() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      destinationFocusNode.requestFocus();
    });
  }

  @override
  void onClose() {
    currentLocationController.dispose();
    destinationController.dispose();
    destinationFocusNode.dispose();
    super.onClose();
  }
}
