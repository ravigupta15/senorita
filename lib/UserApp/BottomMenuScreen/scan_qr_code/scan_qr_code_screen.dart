import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../utils/color_constant.dart';
import 'controller/scan_qr_code_controller.dart';

class ScanQrCodeScreen extends GetWidget<ScanQrCodeController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
      body: Column(
          children: [
            Expanded(
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.green,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
            // Obx(() => Text(
            //   'Scanned Data: ${controller.scannedData.value}',
            //   style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // )),
          ],
      ),

    );
  }
}


