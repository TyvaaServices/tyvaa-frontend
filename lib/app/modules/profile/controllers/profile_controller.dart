import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../domain/entities/user.dart';
import '../../../services/synchronization_service.dart';

class ProfileController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  final userName = 'Cheikh Tidiane'.obs;
  final phoneNumber = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final isEditingName = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final storage = const FlutterSecureStorage();

  @override
  Future<void> onInit() async {
    var logger = Logger();

    var box = Hive.box<User>('users');

    if (box.containsKey('currentUser')) {
      user.value = box.get('currentUser')!;
      nameController.text = user.value!.nomComplet ?? '';
      logger.d(user.value);
    } else {
      logger.d('No user found in Hive');
    }

    super.onInit();
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

  void saveChanges() async {
    if (user.value != null) {
      user.value!.nomComplet = nameController.text.trim();

      var box = Hive.box<User>('users');
      await box.put('currentUser', user.value!);
      final synchronize = Get.find<SynchronizationService>();
      synchronize.markUserChanged();
      if (isEditingName.value) {
        isEditingName.value = false;
      }
    }

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
