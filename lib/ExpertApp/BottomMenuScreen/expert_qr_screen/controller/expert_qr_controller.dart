import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/ScreenRoutes/routes.dart';

class ExpertQRScannerController extends GetxController {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final scannedData = ''.obs;




  @override
  Future<void> onInit() async {
    super.onInit();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {

      // Update the scannedData observable with the scanned QR code data
      scannedData.value = scanData.code!;
      Get.toNamed(AppRoutes.paymentScreen);
    });
  }

}
