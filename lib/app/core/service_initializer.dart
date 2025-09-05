import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/app/services/permission_service.dart';
import 'package:passenger_tyvaa/app/services/synchronization_service.dart';
import 'package:passenger_tyvaa/domain/entities/booking.dart';
import 'package:passenger_tyvaa/domain/entities/driver_profile.dart';
import 'package:passenger_tyvaa/domain/entities/message.dart';
import 'package:passenger_tyvaa/domain/entities/passenger_profile.dart';
import 'package:passenger_tyvaa/domain/entities/payment.dart';
import 'package:passenger_tyvaa/domain/entities/ride_instance.dart';
import 'package:passenger_tyvaa/domain/entities/ride_model.dart';
import 'package:passenger_tyvaa/domain/entities/user.dart';
import 'package:passenger_tyvaa/firebase_options.dart';

class ServiceInitializer {
  final Logger logger = Logger();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PassengerProfileAdapter());
    Hive.registerAdapter(DriverProfileAdapter());
    Hive.registerAdapter(RideModelAdapter());
    Hive.registerAdapter(RideinstanceAdapter());
    Hive.registerAdapter(BookingAdapter());
    Hive.registerAdapter(PaymentAdapter());
    Hive.registerAdapter(MessageAdapter());
    await Hive.openBox<User>('users');
    await Hive.openBox<PassengerProfile>('passenger_profiles');
    await Hive.openBox<DriverProfile>('driver_profiles');
    await Hive.openBox<RideModel>('ride_models');
    await Hive.openBox<Rideinstance>('ride_instances');
    await Hive.openBox<Booking>('bookings');
    await Hive.openBox<Payment>('payments');
    await Hive.openBox<Message>('messages');

    Get.put(ConnectivityController(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    await Get.putAsync(() => PermissionService().init());
    await Get.putAsync(() => SynchronizationService().init());
    // await Get.putAsync(()  => LocalNotificationService.initialize());
  }
}
