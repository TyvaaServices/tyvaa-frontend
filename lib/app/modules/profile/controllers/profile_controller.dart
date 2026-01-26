import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_feedback.dart';
import '../../../../data/entities/user.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  ProfileController(this._userRepository, this._authRepository);

  final user = Rxn<User>();
  final isLoading = false.obs;
  final isEditing = false.obs;
  final isDriverModeActive = true.obs; // Driver mode toggle

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      user.value = await _userRepository.getProfile();
      if (user.value != null) {
        nameController.text = user.value!.fullName;
        emailController.text = user.value!.email ?? '';
        phoneController.text = user.value!.phoneNumber;
      }
    } catch (e) {
      AppFeedback.showError('Erreur', 'Impossible de charger votre profil.');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEdit() => isEditing.toggle();

  Future<void> saveProfile() async {
    if (user.value == null) return;

    isLoading.value = true;
    try {
      final updatedUser = user.value!
        ..fullName = nameController.text
        ..email = emailController.text.isNotEmpty ? emailController.text : null;

      user.value = await _userRepository.updateProfile(updatedUser);
      isEditing.value = false;
      AppFeedback.showSuccess(
        'Mis à jour',
        'Vos informations ont été enregistrées.',
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Impossible de sauvegarder les modifications.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> becomeDriver() async {
    isLoading.value = true;
    try {
      await _userRepository.becomeDriver();
      await loadProfile();
      AppFeedback.showSuccess(
        'Félicitations',
        'Vous êtes maintenant conducteur !',
      );
    } catch (e) {
      AppFeedback.showError(
        'Erreur',
        'Une erreur est survenue lors de l\'activation du mode conducteur.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAllNamed(Routes.AUTH);
  }

  void toggleDriverMode(bool value) {
    isDriverModeActive.value = value;
    // Persist preference or notify backend as needed
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
