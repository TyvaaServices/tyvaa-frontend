import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/trajet/controllers/publish_trajet_controller.dart';

class PublishTrajetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublishTrajetController>(() => PublishTrajetController());
  }
}
