import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  final userName = 'Cheikh Tidiane'.obs;
  final phoneNumber = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final isEditingName = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final storage = const FlutterSecureStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    nameController.text = userName.value;
    phoneNumber.value = (await storage.read(key: 'phone_number'))!;
  }

  void pickImage() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.photos.request();
    } else if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      return;
    }

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImage.value = File(image.path);
      }
    } else {
      Get.snackbar('Permission refusée', 'Autorisez l\'accès aux photos');
    }
  }

  void saveChanges() {
    Get.snackbar(
      'Profil mis à jour',
      'Vos informations ont été enregistrées avec succès',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.all(16),
      borderRadius: 16,
      duration: Duration(seconds: 2),
    );
  }

  //A TESTER AVEC LE BACKEND
  void logout() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    await storage.deleteAll();
    await Future.delayed(2.seconds);
    Get.offAllNamed('/login');
  }
}
