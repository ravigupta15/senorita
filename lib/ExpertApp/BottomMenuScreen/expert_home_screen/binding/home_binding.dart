import 'package:get/get.dart';

import '../../expert_dashboard_screen/controller/dashboard_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpertDashboardController());
  }
}
