import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends GetWidget<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
            appBar: appBar(context, "Notification", () {
              Get.back();
            }),
            backgroundColor: ColorConstant.white.withOpacity(0.4),
            body: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 0,bottom: 55),
                scrollDirection: Axis.vertical,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: walletTransaction(context, index));
                }),
            ));
  }

  walletTransaction(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 18, top: 0, bottom: 6),
      child: GestureDetector(
        onTap: () {

        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


            /*  Container(
                width: MediaQuery.of(context).size.width - 15,
                color: ColorConstant.dividerColor,
                height: 1,
              ),*/
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      height: 40,
                      width: 40,
                      AppImages.userIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          getText(
                              title: "Irrelevant",
                              size: 15,
                              fontFamily: interMedium,
                              color: ColorConstant.blackColor,
                              fontWeight: FontWeight.w600),

                        ],
                      ),
                      SizedBox(height: 3,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: const getText(
                            title:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",
                            size: 14,
                            fontFamily: interRegular,
                            textOverflow: TextOverflow.ellipsis,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                ],
              ),
                SizedBox(height: 10,),
                Container(
                width: MediaQuery.of(context).size.width - 15,
                color: ColorConstant.dividerColor,
                height: 1,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
