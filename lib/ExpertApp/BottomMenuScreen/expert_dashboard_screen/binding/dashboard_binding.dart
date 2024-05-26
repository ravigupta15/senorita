import 'package:get/get.dart';
import '../controller/dashboard_controller.dart';

class ExpertDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertDashboardController());
    Get.put(ExpertDashboardController());
  }
}
