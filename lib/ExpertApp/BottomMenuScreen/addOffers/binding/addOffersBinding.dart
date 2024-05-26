import 'package:get/get.dart';

import '../controller/addOffersController.dart';

class AddOfferBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AddOfferController());
    // TODO: implement dependencies
  }

}