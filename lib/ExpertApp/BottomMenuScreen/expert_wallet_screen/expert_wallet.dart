import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'dart:math' as math;

import 'controller/expert_wallet_controller.dart';

class ExpertWalletScreen extends GetWidget<ExpertWalletController> {
  const ExpertWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(
          AppRoutes.dashboardScreen,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 30,
        title: getText(
            title: "Wallet",
            size: 17,
            fontFamily: interSemiBold,
            letterSpacing: 0.7,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w400),
        centerTitle: true,
      ),
        backgroundColor: ColorConstant.checkBox.withOpacity(0.1),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
            } else if (scrollNotification is ScrollEndNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 40) {
                controller.allWalletListApiPaginationApiFunction();
              }
            }
            return true;
          },
          child:  Column(
        children: [
          availablePointUi(),

          ///Recent Transaction text
          const Padding(
            padding: EdgeInsets.only(right: 15,left: 20,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "Recent redeem point",
                    size: 15,
                    fontFamily: interMedium,
                    color: ColorConstant.blackColorLight,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0,left: 0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: ColorConstant.walletBorder,
            ),
          ),
          SizedBox(height: 12,),

          walletTransactionListUi(context),

          controller.isLoadMoreRunning.value == true
        ? const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Center(child: CircularProgressIndicator()))
              : Container(),
          controller.hasNextPage.value == false
              ? const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(child: Text("no data")))
              : Container(),

        ],
        ),
        ),

      ),
    );
  }
  /// Section AvailablePoint
  Widget availablePointUi() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstant.walletBorder,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        height: 85,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Center(
                          child: getText(
                              title: "Total available Point",
                              size: 17,
                              fontFamily: interMedium,
                              color: ColorConstant.offerTextBlack,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                            () => Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: getText(
                              title:controller.totalPoints.value,
                              size: 15,
                              fontFamily: interMedium,
                              letterSpacing: 0.8,
                              color: ColorConstant.redeemTextDark,
                              fontWeight: FontWeight.w500),
                            ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.toNamed(AppRoutes.qrCodeScreen);
                      },
                      child: Image.asset(
                        width: 30,
                        height: 30,
                        AppImages.walletIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget walletTransactionListUi(BuildContext context) {
    return  Expanded(
      child: Obx(()=>
          Padding(
            padding: const EdgeInsets.only(left: 08,right: 15),
            child: ListView.builder(
              //physics: const ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.allWalletList.length,
                itemBuilder: (BuildContext context, int index) {
                  var model = controller.allWalletList[index];
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                      },
                      child: walletTransaction(context,model));
                }),
          ),
      ),
    );
  }

  walletTransaction(BuildContext context,model) {
    final String timestamp = model.created_at;
    // Parse the timestamp string into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);
    // Format the DateTime object with the desired format
    String createdAt = DateFormat('MMMM dd, yyyy HH:mm:ss').format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 6),
      child: GestureDetector(
        onTap: () {
        },
        child: SizedBox(
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(bottom: 15),
                    child: Image.asset(
                      width: 20,
                      height: 20,
                      AppImages.transaction,),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: "Redeem to "+ model.txn_id.toString(),
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.blackColorDark,
                            fontWeight: FontWeight.w500),

                        SizedBox(height: 5,),

                        getText(
                            title: createdAt.toString(),
                            size: 11,
                            fontFamily: interLight,
                            color: ColorConstant.blackLight,
                            fontWeight: FontWeight.w600),

                      ],
                    ),
                  ),

                  Spacer(),
                  getText(
                      title: "₹ "+model.points,
                      size: 14,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ],),

              /* Padding(
                padding: const EdgeInsets.only(left: 29),
                child: getText(
                    title: createdAt.toString(),
                    size: 11,
                    fontFamily: interLight,
                    color: ColorConstant.blackLight,
                    fontWeight: FontWeight.w600),
              ),*/
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-15,
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
