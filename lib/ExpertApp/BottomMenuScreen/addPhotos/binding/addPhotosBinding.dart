import 'package:get/get.dart';

import '../controller/addPhotosController.dart';

class AddPhotosBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddPhotosController());
    // TODO: implement dependencies
  }

}