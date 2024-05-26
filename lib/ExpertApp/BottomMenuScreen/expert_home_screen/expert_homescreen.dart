import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import 'dart:math' as math;

import '../../../utils/color_constant.dart';
import '../../../utils/stringConstants.dart';
import 'package:intl/intl.dart';
import '../expert_dashboard_screen/controller/dashboard_controller.dart';

class ExpertHomeScreen extends GetView<ExpertDashboardController> {
  const ExpertHomeScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      // drawer: drawer(context, controller),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
          } else if (scrollNotification is ScrollUpdateNotification) {
          } else if (scrollNotification is ScrollEndNotification) {
            if (scrollNotification.metrics.pixels >=
                scrollNotification.metrics.maxScrollExtent - 40) {
              controller.allTransactionPaginationApiFunction();
              // controller.selectedTabBar.value ==0?
              // productPaginApiFunction():servicePaginApiFunction();
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarUi(context),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 0,
                  color: ColorConstant.dividerColor,
                  height: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: new EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                controller.expertName.value.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,

                                  fontFamily: interSemiBold,
                                  color: ColorConstant.blackColorDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            controller.location.value.toString() != ""
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 15, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Image.asset(
                                                width: 20,
                                                height: 20,
                                                AppImages.location,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              padding: new EdgeInsets.only(
                                                  right: 13.0),
                                              child: Text(
                                                softWrap: true,
                                                controller.location.value.toString(),
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: interMedium,
                                                  color: ColorConstant.greyColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            controller.kodagoCard.value.toString() != ""
                                ? Obx(
                                    () => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoutes.helpSupportScreen,
                                                arguments: [
                                                  'detail',
                                                  controller
                                                      .kodagoCard.value
                                                ]);
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                getText(
                                                    title: "- Kodago Card",
                                                    size: 14,
                                                    fontFamily: interSemiBold,
                                                    color: ColorConstant
                                                        .blackColorDark,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                getText(
                                                    title:  "   "+controller
                                                        .kodagoCard.value,
                                                    size: 13,
                                                    fontFamily: interRegular,
                                                    color: ColorConstant
                                                        .kodagoCardUi,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            controller.categoryString.value.toString() != ""
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      getText(
                                          title: "- Category",
                                          size: 13,
                                          fontFamily: interSemiBold,
                                          color: ColorConstant.blackColorDark,
                                          fontWeight: FontWeight.w600),
                                      getText(
                                          lineHeight: 1.6,
                                          title:
                                              "   "+controller.categoryString.value,
                                          size: 12,
                                          textOverflow: TextOverflow.visible,
                                          fontFamily: interMedium,
                                          color: ColorConstant.greyColor,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  )
                                : SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            controller.subCategoryNameList.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          getText(
                                              title: "- SubCategory",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color:
                                                  ColorConstant.blackColorDark,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .subCategoryNameList.length,
                                            itemBuilder: (context, index) {
                                              return getText(
                                                  title: " * "+controller
                                                          .subCategoryNameList[
                                                      index],
                                                  size: 12,
                                                  textOverflow:
                                                      TextOverflow.visible,
                                                  lineHeight: 1.7,
                                                  fontFamily: interMedium,
                                                  color: ColorConstant
                                                      .greyColor,
                                                  fontWeight: FontWeight.w500);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 15,
                            ),
                            controller.bio.value.toString() != ""
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      getText(
                                          title: "- About Us",
                                          size: 13,
                                          fontFamily: interSemiBold,
                                          color: ColorConstant.blackColorDark,
                                          fontWeight: FontWeight.w600),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5),
                                        child: getText(
                                            lineHeight: 1.6,
                                            textAlign: TextAlign.left,
                                            title: controller.bio.value,
                                            size: 12,
                                            textOverflow: TextOverflow.visible,
                                            fontFamily: interMedium,
                                            color: ColorConstant.greyColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// AppBarUi Widget
  Widget appBarUi(BuildContext context) {
    print(controller.status.value);
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 12, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => CachedNetworkImage(
                imageUrl: controller.expertProfileImage.value.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorConstant.c3Color),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 43.0,
                  height: 43.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorConstant.c3Color),
                  ),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(
                        softWrap: true,
                        controller.expertName.value,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: interMedium,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: Obx(
                      () => Row(
                        children: [
                          Obx(() => Transform.scale(
                                scale: 0.9,
                                child: Switch(
                                  value: controller.isSwitched.value,
                                  activeColor: ColorConstant.onBoardingBack,
                                  onChanged: (value) {
                                    controller.expertUpdateApiFunction(context);
                                  },
                                ),
                              )),
                          const SizedBox(
                            width: 0,
                          ),
                          controller.isSwitched.value == false
                              ? getText(
                                  title: "Not Available",
                                  size: 12,
                                  fontFamily: interRegular,
                                  color: ColorConstant.greyColor,
                                  fontWeight: FontWeight.w400)
                              : getText(
                                  title: "Available",
                                  size: 12,
                                  fontFamily: interRegular,
                                  color: ColorConstant.greyColor,
                                  fontWeight: FontWeight.w400),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            /*Center(
              child: GestureDetector(
                onTap: ()
                {
                  Get.toNamed(AppRoutes.expertQrScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    height: 45,
                    width: 45,
                    AppImages.qrExpert,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  /// availablePointUi Widget
  Widget availablePointUi() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 10, right: 10, top: 25),
      child: Column(
        children: [
          SizedBox(
            height: 111,
            width: 384,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 110,
                        width: 384,
                        decoration: BoxDecoration(
                            color: ColorConstant.pointBg,
                            borderRadius: BorderRadius.circular(15)))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    height: 75,
                    width: 384,
                    AppImages.imgExpertPoint,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 11, top: 15),
                      child: getText(
                          title: "Total point",
                          size: 18,
                          fontFamily: interMedium,
                          color: ColorConstant.white,
                          fontWeight: FontWeight.w600),
                    )),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(left: 11, top: 5),
                        child: Row(
                          children: [
                            Image.asset(
                              height: 22,
                              width: 8,
                              AppImages.imgRsPoint,
                              fit: BoxFit.contain,
                            ),
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 15, left: 5),
                                child: getText(
                                    title:
                                        controller.totalPoints.value.toString(),
                                    size: 22,
                                    fontFamily: interMedium,
                                    color: ColorConstant.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// transactionListUi Widget
  Widget transactionListUi(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
            //physics: const ScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.allTransactionList.length,
            itemBuilder: (BuildContext context, int index) {
              var model = controller.allTransactionList[index];
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: transactionUi(context, model));
            }),
      ),
    );
  }

  transactionUi(BuildContext context, model) {
    final String timestamp = model.created_at;
    // Parse the timestamp string into a DateTime object
    DateTime dateTime = DateTime.parse(timestamp);
    // Format the DateTime object with the desired format
    String createdAt = DateFormat('MMMM dd, yyyy HH:mm:ss').format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0, bottom: 6),
      child: GestureDetector(
        onTap: () {},
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
                    padding: EdgeInsets.only(bottom: 9),
                    child: Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: Image.asset(
                        width: 20,
                        height: 20,
                        AppImages.transaction,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: "Recived from " + model.payer_name,
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.blackColorDark,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          height: 5,
                        ),
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
                      title: "₹ " + model.points,
                      size: 14,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ],
              ),

              /* Padding(
                padding: const EdgeInsets.only(left: 29),
                child: getText(
                    title: createdAt.toString(),
                    size: 11,
                    fontFamily: interLight,
                    color: ColorConstant.blackLight,
                    fontWeight: FontWeight.w600),
              ),*/
              SizedBox(
                height: 10,
              ),
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
