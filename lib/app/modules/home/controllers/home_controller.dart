import 'package:get/get.dart';
import '../../../../data/entities/ride.dart';
import '../../../../data/entities/user.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/ride_repository.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final IRideRepository _rideRepository;
  final IAuthRepository _authRepository;

  HomeController(this._rideRepository, this._authRepository);

  final rides = <Ride>[].obs;
  final currentUser = Rxn<User>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    try {
      await Future.wait([_fetchUser(), fetchRides()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchUser() async {
    currentUser.value = await _authRepository.getCurrentUser();
  }

  Future<void> fetchRides() async {
    try {
      // rides.value = await _rideRepository.searchRides('', '', DateTime.now());
      // Mock for now if repo fails or empty
      rides.value = await _rideRepository.searchRides('', '', DateTime.now());
    } catch (e) {
      // Use silent log or a subtle info message if it's not critical
      // AppFeedback.showInfo('Info', 'Impossible de charger les trajets récents');
    }
  }

  void goToPublish() {
    Get.toNamed(Routes.RIDE);
  }
}
