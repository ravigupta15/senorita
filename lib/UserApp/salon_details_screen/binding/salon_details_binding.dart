import 'package:get/get.dart';

import '../controller/category_details_controller.dart';


class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailController());
    // Get.lazyPut(CategoryDetailController());
  }
}
