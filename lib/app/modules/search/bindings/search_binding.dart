import 'package:get/get.dart';
import 'package:passenger_tyvaa/app/modules/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchViewController>(
      fenix: true,
      () => SearchViewController(),
    );
  }
}
