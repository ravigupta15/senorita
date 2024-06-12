import 'package:get/get.dart';
import 'package:senorita/CommonScreens/notification/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
    // TODO: implement dependencies
  }

}