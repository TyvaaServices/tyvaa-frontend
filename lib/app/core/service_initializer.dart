import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:passenger_tyvaa/app/api/api_client.dart';
import 'package:passenger_tyvaa/app/services/connectivity_service.dart';
import 'package:passenger_tyvaa/app/services/notification_service.dart';
import 'package:passenger_tyvaa/app/services/synchronization_service.dart';
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
    await Hive.openBox<User>('users');

    Get.put(ConnectivityController(), permanent: true);
    Get.put(ApiClient(), permanent: true);
    await Get.putAsync(() => SynchronizationService().init());
    await Get.putAsync(() => NotificationService().init());
  }
}
