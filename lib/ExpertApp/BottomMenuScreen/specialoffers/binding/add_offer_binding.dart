import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/offers/controller/add_offer_controller.dart';

class AddOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddOfferController());
  }
}
