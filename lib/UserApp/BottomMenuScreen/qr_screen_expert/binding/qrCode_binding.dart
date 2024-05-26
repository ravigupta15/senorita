import 'package:get/get.dart';

import '../controller/qr_controller.dart';

class QrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QRScannerController());
  }
}
