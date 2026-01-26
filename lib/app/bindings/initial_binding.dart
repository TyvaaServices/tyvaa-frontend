import 'package:get/get.dart';
import '../../data/providers/api_provider.dart';
import '../../data/providers/isar_provider.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/ride_repository.dart';
import '../../data/repositories/booking_repository.dart';
import '../../data/repositories/user_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiProvider());
    Get.put(IsarProvider());

    Get.put<IAuthRepository>(AuthRepository(Get.find(), Get.find()));

    Get.put<IRideRepository>(RideRepository(Get.find()));

    Get.put<IBookingRepository>(BookingRepository(Get.find()));

    Get.put<IUserRepository>(UserRepository(Get.find(), Get.find()));
  }
}
