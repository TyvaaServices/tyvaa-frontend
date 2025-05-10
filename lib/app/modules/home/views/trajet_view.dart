import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverTrajetScreen extends GetView<DriverTrajetController> {
  const DriverTrajetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class DriverTrajetController extends GetxController {
  final RxBool isOnline = false.obs;
  void toggleOnlineStatus() => isOnline.value = !isOnline.value;
}
