import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'connectivity_service.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectivityController>();
    bool previouslyConnected = controller.isConnected.value;

    controller.isConnected.listen((connected) {
      if (!connected && previouslyConnected) {
        Get.snackbar(
          'No Internet',
          'You are offline.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (connected && !previouslyConnected) {
        Get.snackbar(
          'Back Online',
          'Internet connection restored.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
      previouslyConnected = connected;
    });

    return child;
  }
}
