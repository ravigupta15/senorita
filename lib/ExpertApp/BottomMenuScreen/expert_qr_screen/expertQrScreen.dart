import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import 'controller/expert_qr_controller.dart';

class ExpertQrCodeScreen extends GetWidget<ExpertQRScannerController> {
  final ExpertQRScannerController qrScannerController =
  Get.put(ExpertQRScannerController());
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "QR code", () {
        Get.back();
      }),
      backgroundColor: ColorConstant.white.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 20,
            top: 75,
            right: 20,
          ),
          child: Obx(() =>
              Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(right: 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 66,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                        color: ColorConstant.qrViewBack,
                        border: Border.all(color: ColorConstant.qrViewBack),
                        borderRadius:const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getText(
                            title: "Scan QR code",
                            size: 17,
                            fontFamily: interSemiBold,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w600),
                        const SizedBox(height: 7),
                        const getText(
                            title: "Lorem Ipsum is simply dummy text of the printing ",
                            size: 13,
                            textAlign: TextAlign.center,
                            fontFamily: interMedium,
                            lineHeight: 1.5,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w600),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 31),
                  RepaintBoundary(
                    key: globalKey,
                    child: QrImageView(
                      data: controller.expertQrCode.value,
                      version: QrVersions.auto,
                      gapless: false,
                      size: 200,
                      embeddedImage: const AssetImage(AppImages.splashCenter),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size(60, 60),
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   scale: 1,
                  //   AppImages.imgQrView,
                  //   fit: BoxFit.contain,
                  // ),
                  const SizedBox(height: 37),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            capturePng(context,'share');
                          },
                          child: Container(
                            color: Colors.white,
                           child: Row(
                             children: [Image.asset(
                               height: 17,
                               width: 17,
                               AppImages.imgShareQr,
                               fit: BoxFit.contain,
                             ),
                               const Padding(
                                   padding: EdgeInsets.only(
                                     left: 7,
                                     top: 3,
                                     bottom: 3,
                                   ),
                                   child: getText(
                                       title: "Share QR",
                                       size: 15,
                                       fontFamily: interMedium,
                                       color: ColorConstant.onBoardingBack,
                                       fontWeight: FontWeight.w600)
                               ),
                             ],
                           ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                            height: 26,
                            child: VerticalDivider(
                              width: 1,
                              thickness: 1,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: (){
                          capturePng(context, 'download');
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Image.asset(
                                height: 17,
                                width: 17,
                                AppImages.imgDownloadQr,
                                fit: BoxFit.contain,
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(
                                    left: 9,
                                    top: 3,
                                    bottom: 3,
                                  ),
                                  child: getText(
                                      title: "Download QR",
                                      size: 15,
                                      fontFamily: interMedium,
                                      color: ColorConstant.onBoardingBack,
                                      fontWeight: FontWeight.w600)
                              )
                            ],
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
          ),
        ),
      ),
    );
  }
  Future<void> capturePng(BuildContext context, String route) async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get the directory to save the image
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      File imgFile = File('$path/qr_code.png');
      final box = context.findRenderObject() as RenderBox?;
      imgFile.writeAsBytes(pngBytes);
     if(route=='share'){
       Share.shareFiles([imgFile.path],
           sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
           text: 'Check out this QR code!',subject: 'Qr Code');
     }
     else{
       controller.convertImageToUrlApiFunction(imgFile);
     }
      print('QR Code saved to $path');
    } catch (e) {
      print(e);
    }
  }

}
