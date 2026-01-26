import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  final IAuthRepository _authRepository;

  SettingsController(this._authRepository);

  final appVersion = '1.0.0'.obs;

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAllNamed(Routes.AUTH);
  }
}
