import 'dart:ffi';
import 'dart:math';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:readmore/readmore.dart';
import 'package:senorita/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ScreenRoutes/routes.dart';

import '../../api_config/Api_Url.dart';
import '../../helper/appimage.dart';
import '../../helper/custombtn.dart';
import '../../helper/custombtn_new.dart';
import '../../helper/getText.dart';
import '../../utils/color_constant.dart';
import '../../utils/screensize.dart';
import '../../utils/size_config.dart';
import '../../utils/stringConstants.dart';
import '../../utils/toast.dart';
import 'ImgView.dart';
import 'controller/category_details_controller.dart';
import 'model/reviewModel.dart';

class CategoryDetailScreen extends GetView<CategoryDetailController> {
  const CategoryDetailScreen({key});

  @override
  Widget build(BuildContext context) {
    Color randomColor() =>
        Color((Random().nextDouble() * 0xff0060A4).toInt() << 0)
            .withOpacity(1.0);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => GestureDetector(
                      onTap: () {
                        Get.to(ImgView(controller.photosList),
                            transition: Transition.cupertino);
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        imageUrl: controller.image.value.toString(),
                        errorWidget: (context, url, error) => Image.network(
                          "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                          fit: BoxFit.cover,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    )),
                /*Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Positioned(
                            child: Obx(() => GestureDetector(
                                  onTap: () {
                                    Get.to(ImgView(controller.photosList),
                                        transition: Transition.cupertino);
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    imageUrl:
                                        controller.image.value.toString(),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                      "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ))),

                        */ /* */ /* */ /*Image.network(
                                  controller.image.value.toString(),
                                ))*/ /* */ /*),*/ /*
                        Positioned(
                          top: 192,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 3,
                              shadowColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                //set border radius more than 50% of height and width to make circle
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 0),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: new EdgeInsets.only(
                                                  right: 13.0),
                                              child: Text(
                                                controller.name.value
                                                    .toString(),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 19.0,
                                                  letterSpacing: 0.6,
                                                  fontFamily: interSemiBold,
                                                  color: ColorConstant
                                                      .blackColorDark,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            Obx(
                                                () =>
                                                    controller.subCategory
                                                                .length !=
                                                            0
                                                        ? Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: ListView
                                                                    .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemCount: controller
                                                                      .subCategory
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    var model =
                                                                        controller.subCategory[index];
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal: 1,
                                                                        ),
                                                                        child: getText(
                                                                            title: "* " + model.subCategoryName.toString(),
                                                                            size: 12,
                                                                            fontFamily: interMedium,
                                                                            lineHeight: 1.8,
                                                                            color: ColorConstant.greyColor,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : SizedBox()),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    controller.status
                                                                .value ==
                                                            "1"
                                                        ? Text(
                                                            "Open Now",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  interMedium,
                                                              color: ColorConstant
                                                                  .greenColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )
                                                        : Text(
                                                            "Close Now",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  interMedium,
                                                              letterSpacing:
                                                                  0.6,
                                                              color: ColorConstant
                                                                  .greenColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                    Text(
                                                      "",
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: new TextStyle(
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.6,
                                                        fontFamily:
                                                            interMedium,
                                                        color: ColorConstant
                                                            .blackLight,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      controller.location.value != "" &&
                                              controller.location.value !=
                                                  ""
                                          */ /* controller.location.value
                                                  .toString() !=
                                              "null"*/ /*
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6, right: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3),
                                                        child: Image.asset(
                                                          width: 20,
                                                          height: 20,
                                                          AppImages
                                                              .location,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            50,
                                                        padding:
                                                            new EdgeInsets
                                                                .only(
                                                                right:
                                                                    13.0),
                                                        child: Text(
                                                          softWrap: true,
                                                          controller
                                                              .location
                                                              .value
                                                              .toString(),
                                                          // overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                interMedium,
                                                            color: ColorConstant
                                                                .greyColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      controller.distance.value
                                                  .toString() !=
                                              ""
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 10, top: 2),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        width: 15,
                                                        color: ColorConstant
                                                            .greyColor,
                                                        height: 15,
                                                        AppImages.distance,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.2,
                                                        padding:
                                                            new EdgeInsets
                                                                .only(
                                                                right:
                                                                    13.0),
                                                        child: new Text(
                                                          " " +
                                                              controller
                                                                  .distance
                                                                  .toString() +
                                                              " km",
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          style:
                                                              new TextStyle(
                                                            fontSize: 13.0,
                                                            fontFamily:
                                                                interMedium,
                                                            color: ColorConstant
                                                                .greyColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 1),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    AppRoutes
                                                        .helpSupportScreen,
                                                    arguments: [
                                                      'detail',
                                                      controller
                                                          .expertise.value
                                                    ]);
                                              },
                                              child: SizedBox(
                                                width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    getText(
                                                        title:
                                                            "Kodago Card",
                                                        size: 14,
                                                        fontFamily:
                                                            interSemiBold,
                                                        color: ColorConstant
                                                            .blackColorDark,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    getText(
                                                        title: controller
                                                            .kodagoCard
                                                            .value,
                                                        size: 12,
                                                        fontFamily:
                                                            interRegular,
                                                        color: ColorConstant
                                                            .kodagoCardUi,
                                                        fontWeight:
                                                            FontWeight
                                                                .w400),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            controller.spacialOffer
                                                        .length !=
                                                    0
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const getText(
                                                          title:
                                                              "Special offers",
                                                          size: 15,
                                                          fontFamily:
                                                              interSemiBold,
                                                          color: ColorConstant
                                                              .blackColorDark,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      specialOffers(context)
                                                    ],
                                                  )
                                                : SizedBox(),
                                            const SizedBox(
                                              height: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(
                                                      top: 2, bottom: 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Obx(
                                                      () => GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedTabValue
                                                              .value = 0;
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: getText(
                                                              title:
                                                                  "About Us",
                                                              size: 13,
                                                              fontFamily:
                                                                  interMedium,
                                                              color: controller
                                                                          .selectedTabValue
                                                                          .value ==
                                                                      0
                                                                  ? ColorConstant
                                                                      .onBoardingBack
                                                                  : ColorConstant
                                                                      .qrViewText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Obx(
                                                      () => GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedTabValue
                                                              .value = 1;
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                              child: getText(
                                                                  title:
                                                                      "Menu",
                                                                  size: 13,
                                                                  fontFamily:
                                                                      interMedium,
                                                                  color: controller.selectedTabValue.value == 1
                                                                      ? ColorConstant
                                                                          .onBoardingBack
                                                                      : ColorConstant
                                                                          .qrViewText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Obx(
                                                      () => GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedTabValue
                                                              .value = 2;
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                              child: getText(
                                                                  title:
                                                                      "Review",
                                                                  size: 13,
                                                                  fontFamily:
                                                                      interMedium,
                                                                  color: controller.selectedTabValue.value == 2
                                                                      ? ColorConstant
                                                                          .onBoardingBack
                                                                      : ColorConstant
                                                                          .qrViewText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Obx(
                                                      () => GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .selectedTabValue
                                                              .value = 3;
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                              child: getText(
                                                                  title:
                                                                      "Photos",
                                                                  size: 13,
                                                                  fontFamily:
                                                                      interMedium,
                                                                  color: controller.selectedTabValue.value == 3
                                                                      ? ColorConstant
                                                                          .onBoardingBack
                                                                      : ColorConstant
                                                                          .qrViewText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.black12),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 4),
                                          child: tabViewData(context)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),*/
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 0),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: new EdgeInsets.only(right: 13.0),
                                  child: Text(
                                    controller.name.value.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 19.0,
                                      letterSpacing: 0.6,
                                      fontFamily: interSemiBold,
                                      color: ColorConstant.blackColorDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),*/
                                Container(
                                  width: MediaQuery.of(context).size.width/1,
                                  padding: new EdgeInsets.only(
                                      right: 12.0),
                                  child: Text(
                                    softWrap: true,
                                    controller.name.value.toString(),
                                    style: new TextStyle(
                                      fontSize: 19.0,
                                      letterSpacing: 0.6,
                                      fontFamily: interSemiBold,
                                      color: ColorConstant.blackColorDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                                Obx(() => controller.subCategory.length != 0
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  controller.subCategory.length,
                                              itemBuilder: (context, index) {
                                                var model = controller
                                                    .subCategory[index];
                                                return GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 1,
                                                    ),
                                                    child: getText(
                                                        title: "* " +
                                                            model
                                                                .subCategoryName
                                                                .toString(),
                                                        size: 12,
                                                        fontFamily: interMedium,
                                                        lineHeight: 1.8,
                                                        color: ColorConstant
                                                            .greyColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()),
                                const SizedBox(
                                  height: 10,
                                ),
                                controller.status.value != "" ?
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        controller.status.value == "1"
                                            ? Text(
                                                "Open Now",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: interMedium,
                                                  color:
                                                      ColorConstant.greenColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : Text(
                                                "Close Now",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: interMedium,
                                                  letterSpacing: 0.6,
                                                  color:
                                                      ColorConstant.greenColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                        Text(
                                          "",
                                          overflow: TextOverflow.ellipsis,
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            letterSpacing: 0.6,
                                            fontFamily: interMedium,
                                            color: ColorConstant.blackLight,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ):SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          controller.location.value != "" && controller.location.value != ""
                              ? Padding(
                                  padding: EdgeInsets.only(left: 6, right: 10),
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
                                                    .width -
                                                50,
                                            padding: new EdgeInsets.only(
                                                right: 13.0),
                                            child: Text(
                                              softWrap: true,
                                              controller.location.value
                                                  .toString(),
                                              // overflow: TextOverflow.ellipsis,
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
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          controller.distance.value.toString() != ""
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 2),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            width: 15,
                                            color: ColorConstant.greyColor,
                                            height: 15,
                                            AppImages.distance,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            padding: new EdgeInsets.only(
                                                right: 13.0),
                                            child: new Text(
                                              " " +
                                                  controller.distance
                                                      .toString() +
                                                  " km",
                                              overflow: TextOverflow.ellipsis,
                                              style: new TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: interMedium,
                                                color: ColorConstant.greyColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          controller.kodagoCard.value != "" ?Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.helpSupportScreen,
                                        arguments: [
                                          'detail',
                                          controller.kodagoCard.value
                                        ]);
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getText(
                                            title: "Kodago Card",
                                            size: 14,
                                            fontFamily: interSemiBold,
                                            color: ColorConstant.blackColorDark,
                                            fontWeight: FontWeight.w600),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        getText(
                                            title: controller.kodagoCard.value,
                                            size: 12,
                                            fontFamily: interRegular,
                                            color: ColorConstant.kodagoCardUi,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                controller.spacialOffer.length != 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const getText(
                                              title: "Special offers",
                                              size: 15,
                                              fontFamily: interSemiBold,
                                              color:
                                                  ColorConstant.blackColorDark,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          specialOffers(context)
                                        ],
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ):SizedBox(),
                          SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedTabValue.value = 0;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: getText(
                                                    title: "About Us",
                                                    size: 14,
                                                    fontFamily: interMedium,
                                                    color: controller
                                                                .selectedTabValue
                                                                .value ==
                                                            0
                                                        ? ColorConstant
                                                            .onBoardingBack
                                                        : ColorConstant
                                                            .qrViewText,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedTabValue.value = 1;
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: getText(
                                                        title: "Menu",
                                                        size: 14,
                                                        fontFamily: interMedium,
                                                        color: controller
                                                                    .selectedTabValue
                                                                    .value ==
                                                                1
                                                            ? ColorConstant
                                                                .onBoardingBack
                                                            : ColorConstant
                                                                .qrViewText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedTabValue.value = 2;
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: getText(
                                                        title: "Review",
                                                        size: 14,
                                                        fontFamily: interMedium,
                                                        color: controller
                                                                    .selectedTabValue
                                                                    .value ==
                                                                2
                                                            ? ColorConstant
                                                                .onBoardingBack
                                                            : ColorConstant
                                                                .qrViewText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedTabValue.value = 3;
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: getText(
                                                        title: "Photos",
                                                        size: 14,
                                                        fontFamily: interMedium,
                                                        color: controller
                                                                    .selectedTabValue
                                                                    .value ==
                                                                3
                                                            ? ColorConstant
                                                                .onBoardingBack
                                                            : ColorConstant
                                                                .qrViewText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.black12),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 15),
                                child: tabViewData(context),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /*  Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: ColorConstant.onBoardingBack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                            onPressed: () {
                              var phoneNumber =
                                  controller.mobile.value.toString();
                              controller.status == 1.toString()
                                  ? _makePhoneCall(phoneNumber)
                                  : showToast("Expert is not Available");
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    width: 15,
                                    height: 15,
                                    AppImages.callDetails,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  getText(
                                      title: "Call Now",
                                      size: 13,
                                      fontFamily: interSemiBold,
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 35,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: ColorConstant.onBoardingBack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                )),
                            onPressed: () {
                              showToast("Coming Soon");
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    width: 15,
                                    height: 15,
                                    AppImages.messageDetails,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  getText(
                                      title: "Chat",
                                      size: 13,
                                      fontFamily: interSemiBold,
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              )*/
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 55,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 8, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: ColorConstant.onBoardingBack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {
                          var phoneNumber = controller.mobile.value.toString();
                          controller.status == 1.toString()
                              ? _makePhoneCall(phoneNumber)
                              : showToast("Expert is not Available");
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                width: 15,
                                height: 15,
                                AppImages.callDetails,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              getText(
                                  title: "Call Now",
                                  size: 13,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.white,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 35,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: ColorConstant.onBoardingBack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {
                          showToast("Coming Soon");
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                width: 15,
                                height: 15,
                                AppImages.messageDetails,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              getText(
                                  title: "Chat",
                                  size: 13,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.white,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget tabViewData(BuildContext context) {
    print(controller.getPriceList.length);
    return Obx(() => controller.selectedTabValue == 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getText(
                  lineHeight: 1.6,
                  title: controller.bio.value,
                  size: 12,
                  textAlign: TextAlign.left,
                  textOverflow: TextOverflow.visible,
                  fontFamily: interMedium,
                  color: ColorConstant.greyColor,
                  fontWeight: FontWeight.w500),
            ],
          )
        : controller.selectedTabValue == 1
            ? Obx(
                () => controller.getPriceList.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 0, right: 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // padding: EdgeInsets.zero,
                        itemCount: controller.getPriceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var priceListModel = controller.getPriceList[index];

                          // showToast(controller.getPriceList.toString());
                          //var model = controller.allWalletList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 0.0, bottom: 10),
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  // Get.toNamed(AppRoutes.addPriceList);
                                },
                                child: menuUi(context, index)),
                          );
                        })
                    : Center(
                      child: Column(
                        children: [
                          Image.asset(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              AppImages.noDataFound,
                            ),
                          getText(
                              lineHeight: 1.6,
                              title: "No Data Found",
                              size: 14,
                              fontFamily: interSemiBold,
                              color: ColorConstant.blackColor,
                              fontWeight: FontWeight.w600),
                        ],
                      ),
                    ),
              )
            : controller.selectedTabValue == 2
                ? Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getText(
                                  lineHeight: 1.6,
                                  title: "You Rated",
                                  size: 14,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 3,
                              ),
                              Obx(
                                () => GestureDetector(
                                    onTap: () {
                                      /*controller.myRating.value!="null"?showToast("Review Already Submited"):
                                    ratingUi(context);*/
                                      controller.myRating.value.isEmpty?
                                      ratingUi(context):null;
                                    },
                                    child: RatingBar.builder(
                                      initialRating: controller.myRating.value != ""
                                          ? double.parse(controller
                                              .myRating.value
                                              .toString())
                                          : 0.0,
                                      minRating: 0,
                                      ignoreGestures: true,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding: EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: ColorConstant.fitterLine),
                        controller.averageRating.value!=""?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(
                                      lineHeight: 1.6,
                                      title: "Reviews & Ratings",
                                      size: 14,
                                      fontFamily: interMedium,
                                      color: ColorConstant.offerTextBlack,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                        () => Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: ColorConstant.greenReview,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 12,
                                                bottom: 12),
                                            child: getText(
                                                title: controller.avg_rating.value
                                                    .toString(),
                                                size: 15,
                                                fontFamily: interMedium,
                                                color: ColorConstant.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            getText(
                                                title: controller
                                                    .review_count.value +
                                                    " Ratings",
                                                size: 13,
                                                fontFamily: interMedium,
                                                color: ColorConstant.blackColor,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            /* Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: getText(
                                              title:
                                                  "Senoritapp rating index based on 300 rating across",
                                              size: 12,
                                              fontFamily: interMedium,
                                              color: ColorConstant.qrViewText,
                                              fontWeight: FontWeight.w600),*/
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  1.5,
                                              padding: new EdgeInsets.only(
                                                  right: 13.0),
                                              child: Text(
                                                softWrap: true,
                                                "Senoritapp rating index based on 300 rating across",
                                                // overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: interMedium,
                                                  color: ColorConstant.greyColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              height: 1,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: getText(
                                  lineHeight: 1.6,
                                  title: "User Reviews",
                                  size: 14,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0, bottom: 0),
                                  shrinkWrap: true,
                                  itemCount: controller.getRatingList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    //var model = controller.allWalletList[index];
                                    var model = controller.getRatingList[index];
                                    return Padding(
                                      padding:
                                      EdgeInsets.only(top: 0.0, bottom: 10),
                                      child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {},
                                          child: reviewUi(context, model)),
                                    );
                                  }),
                            ),
                          ],
                        )
                            :Center(
                          child: Column(
                            children: [
                              Image.asset(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                AppImages.noDataFound,
                              ),
                              getText(
                                  lineHeight: 1.6,
                                  title: "No Data Found",
                                  size: 14,
                                  fontFamily: interSemiBold,
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                : Obx(() => controller.photosList.isEmpty
                    ? SizedBox()
                    : GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 0),
                        itemCount: controller.photosList.length,
                        itemBuilder: (context, index) {
                          var model = controller.photosList[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 3, right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(ImgView(controller.photosList),
                                            transition: Transition.cupertino);
                                        // _showImageDialog(context,  ApiUrls.offerImageBase  + model.banner);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorConstant.addMoney),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              ApiUrls.offerImageBase +
                                                  model.banner,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          // border:
                                          //     Border.all(color: Theme.of(context).accentColor),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )));
  }

  Widget menuUi(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          controller.getPriceList[index]['name'],
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13.0,
            fontFamily: interMedium,
            color: ColorConstant.offerTextBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 0,
        ),
        ListView.builder(
            itemCount: controller.getPriceList[index]['data'].length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      width: 18,
                      height: 18,
                      AppImages.menuImg,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    /*Text(
                      controller.getPriceList[index]['data'][i]['item_name'],
                      //  priceListModel['Bridal/Groom Packages'][0]['item_name'].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontFamily: interMedium,
                        color: ColorConstant.qrViewText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),*/
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.8,
                      child: Text(
                        controller.getPriceList[index]['data'][i]['item_name'],
                        //  priceListModel['Bridal/Groom Packages'][0]['item_name'].toString(),

                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: interMedium,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "₹ ${controller.getPriceList[index]['data'][i]['price'].toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: interMedium,
                          color: ColorConstant.offerTextBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  Widget reviewUi(BuildContext context, model) {
    DateTime dateTime = DateTime.parse(model.created_at).toLocal();
    String formattedDateTime = DateFormat.yMd().add_jm().format(dateTime);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.asset(
                  item.image,
                  width: 45.0,
                  height: 45.0,
                  fit: BoxFit.fill,
                ),
              ),*/

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        formattedDateTime.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: interMedium,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              model.rating != ""
                  ? /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: ColorConstant.greenStar,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 9, bottom: 9),
                        child: Row(
                          children: [
                            getText(
                                title: model.rating + ".0",
                                size: 15,
                                fontFamily: interMedium,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              AppImages.reviewStar,
                              width: 12.0,
                              height: 12.0,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    )*/
                  Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: ColorConstant.greenColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Row(
                          children: [
                            getText(
                                title:  model.rating+".0",
                                size: 12,
                                fontFamily: interMedium,
                                color: ColorConstant.white,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              width: 2,
                            ),
                            Image.asset(
                              width: 9,
                              height: 9,
                              color: ColorConstant.white,
                              AppImages.rating,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 1.1,
          ),
          child: Text(
            model.review,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: interMedium,
              letterSpacing: 0.4,
              color: ColorConstant.qrViewText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 13, bottom: 0),
          child: Row(
            children: [
              Text(
                "",
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: interMedium,
                  letterSpacing: 0.4,
                  color: ColorConstant.qrViewText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              /* Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.reportScreen);
                },
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: ColorConstant.fitterLine)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13, right: 13, top: 9, bottom: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getText(
                            title: "Report",
                            size: 13,
                            fontFamily: interMedium,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w500),
                      ],
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorConstant.fitterLine),
        ),
      ],
    );
  }

  Widget specialOffers(BuildContext context) {
    return CarouselSlider(
      items: <Widget>[
        for (var i = 0; i < controller.spacialOffer.length; i++)
          Container(
            margin: const EdgeInsets.only(
              top: 5.0,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(controller.offersUrl.value.toString() +
                    "/" +
                    controller.spacialOffer[i]['banner']),
                fit: BoxFit.cover,
              ),
              // border:
              //     Border.all(color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
      ],
      options: CarouselOptions(
        height: 320.0,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 500),
        viewportFraction: 1,
      ),
    );
  }

  void ratingUi(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enableDrag: true,
        builder: (builder) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.reviewController.text = "";
                      Navigator.pop(context, true);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8)),
                      child: Image.asset(
                        height: 35,
                        width: 35,
                        AppImages.crossBtn,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))
                        //set border radius more than 50% of height and width to make circle
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: getText(
                                title: "Write a Review",
                                size: 17,
                                fontFamily: interRegular,
                                color: ColorConstant.blackColor,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: getText(
                                    title:
                                        "How would you rate your experience?",
                                    size: 12,
                                    fontFamily: interRegular,
                                    color: ColorConstant.offerTextBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              /*RatingBarIndicator(
                                  rating: 2.5,
                                  itemCount: 5,
                                  itemSize: 30.0,

                                  itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.red,
                                      )),*/
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                // ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,

                                itemSize: 25,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);

                                  controller.userRating = rating.toString();

                                  /*controller.userRating==rating.toString();*/
                                  //showToast(rating.toString());
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: getText(
                                    title: "Tell us about your experience",
                                    size: 12,
                                    fontFamily: interRegular,
                                    color: ColorConstant.offerTextBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 7),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  // <-- TextField width// <-- TextField height
                                  child: TextField(
                                    controller: controller.reviewController,
                                    maxLines: 10,
                                    minLines: 1,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          color: ColorConstant.greyColor,
                                          fontSize: 12),
                                      hintText: 'Enter Review',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 7, bottom: 8),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (controller.userRating == "") {
                                  showToast("Rating Is Required");
                                } else if (controller.reviewController.text ==
                                    "") {
                                  showToast("Review Is Required");
                                } else {
                                  controller.submitReviewApiFunction(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                    left: 0, right: 5, top: 13, bottom: 13),
                                decoration: BoxDecoration(
                                    color: ColorConstant.onBoardingBack,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Center(
                                  child: getText(
                                      title: "Apply",
                                      size: 17,
                                      fontFamily: interRegular,
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
