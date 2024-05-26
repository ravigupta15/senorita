import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import 'controller/expert_qr_controller.dart';

class ExpertQrCodeScreen extends GetWidget<ExpertQRScannerController> {
  final ExpertQRScannerController qrScannerController =
      Get.put(ExpertQRScannerController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: appBar(context, "QR code", () {
          Get.back();
        }),
        backgroundColor: ColorConstant.white.withOpacity(0.4),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 20,
              top: 75,
              right: 20,
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 66,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.qrViewBack,
                      border: Border.all(color: ColorConstant.qrViewBack),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getText(
                          title: "Scan QR code",
                          size: 17,
                          fontFamily: interSemiBold,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 7),
                      getText(
                          title: "Lorem Ipsum is simply dummy text of the printing ",
                          size: 13,
                          textAlign: TextAlign.center,
                          fontFamily: interMedium,
                          lineHeight: 1.5,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
                SizedBox(height: 31),
                Image.asset(
                  scale: 1,
                  AppImages.imgQrView,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 37),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 17,
                        width: 17,
                        AppImages.imgShareQr,
                        fit: BoxFit.contain,
                      ),
                      Padding(
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
                      Padding(
                        padding: EdgeInsets.only(left: 25,right: 25),
                        child: SizedBox(
                          height: 26,
                          child: VerticalDivider(
                            width: 1,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Image.asset(
                        height: 17,
                        width: 17,
                        AppImages.imgDownloadQr,
                        fit: BoxFit.contain,
                      ),
                      Padding(
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
