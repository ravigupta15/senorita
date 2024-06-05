import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/all_expert_shimmer.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:senorita/widget/view_salon_widget.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/format_rating.dart';
import '../../../utils/my_sperator.dart';
import '../../../utils/stringConstants.dart';
import '../../../widget/banner_indicator.dart';
import '../dashboard_screen/controller/dashboard_controller.dart';

class HomeScreen extends GetView<DashboardController> {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white, // navigation bar color
    //   statusBarColor: Colors.black, // status bar color
    // ));
    return Scaffold(
      appBar: appBar(context, () => null),
      backgroundColor: ColorConstant.white,
      // drawer: drawer(context, controller),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
          } else if (scrollNotification is ScrollUpdateNotification) {
          } else if (scrollNotification is ScrollEndNotification) {
            if (scrollNotification.metrics.pixels >=
                scrollNotification.metrics.maxScrollExtent - 40) {
              // controller.allExpertPaginationApiFunction();
              // controller.selectedTabBar.value ==0?
              // productPaginApiFunction():servicePaginApiFunction();
            }
          }
          return true;
        },
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: searchBar(
                      readOnly: true,
                      onTap: () {
                        Get.toNamed(AppRoutes.searchScreen);
                      }),
                ),
                //Slider
                Obx(
                  () => controller.bannerList.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 9, right: 9, top: 20),
                          child: Obx(
                            () => controller.isLoading.value &&
                                    controller.bannerList.isEmpty
                                ? homeScreenShimmer()
                                : SizedBox(
                                    child: RefreshIndicator(
                                        onRefresh: () {
                                          // homeScreenShimmer();
                                          return controller
                                              .allHomeScreenApiFunction(
                                                  controller.currentLat.value
                                                      .toString(),
                                                  controller.currentLong.value
                                                      .toString(),
                                                  '',
                                                  true);
                                        },
                                        child: CarouselSlider(
                                          items: <Widget>[
                                            for (var i = 0;
                                                i <
                                                    controller
                                                        .bannerList.length;
                                                i++)
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: NetworkImageHelper(
                                                  img:
                                                      "${controller.offerBaseUrl.value.toString()}/${controller.bannerList[i]['banner']}",
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              ),
                                          ],
                                          options: CarouselOptions(
                                              height: 200.0,
                                              enlargeCenterPage: true,
                                              autoPlay:
                                                  controller.bannerList.length >
                                                          1
                                                      ? true
                                                      : false,
                                              aspectRatio: 16 / 9,
                                              scrollPhysics: controller
                                                          .bannerList.length >
                                                      1
                                                  ? const ScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enableInfiniteScroll: true,
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              viewportFraction: 1,
                                              onPageChanged: (val, _) {
                                                controller.bannerIndex.value =
                                                    val;
                                              }),
                                        )),
                                  ),
                          ))
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.bannerList.length > 1
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  controller.bannerList.length, (index) {
                                return controller.bannerIndex.value == index
                                    ? bannerIndicator(true)
                                    : bannerIndicator(false);
                              })),
                        )
                      : Container(),
                ),
                //All Expertise

                // all category
                categoryWidget(),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getText(
                          title: "Top Rated Salons",
                          size: 18,
                          fontFamily: interSemiBold,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      // Container(
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //       borderRadius:const
                      //       BorderRadius.all(Radius.circular(5)),
                      //       border: Border.all(
                      //           color: ColorConstant.checkBox)),
                      //   child:const Padding(
                      //     padding:  EdgeInsets.all(6.0),
                      //     child: getText(
                      //         title: "Great Offers",
                      //         size: 11,
                      //         fontFamily: interMedium,
                      //         color: ColorConstant.blackColorLight,
                      //         fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    separatorBuilder: (context, sp) {
                      return const SizedBox(
                        height: 23,
                      );
                    },
                    padding: const EdgeInsets.only(left: 15, right: 14),
                    shrinkWrap: true,
                    itemCount: controller.allExpertList.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var model = controller.allExpertList[index];
                      return viewSalonWidget(
                          context, model, controller.listing_base_url.value,
                          () {
                        Get.toNamed(AppRoutes.categoryDetailsScreen,
                            arguments: [
                              model['user']['id'].toString(),
                              controller.lat.toString(),
                              controller.long.toString(),
                            ]);
                      });
                    }),
                /* Obx(() => controller.isLoading.value
                    ? allHomeExpertShimmer()
                    :  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount:
                    controller.allExpertList.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context,
                        int index) {
                      var model =
                      controller.allExpertList[index];

                      return expertUi(context, model);
                    }),*/
                /*Obx(
                        () => controller.isLoading.value
                            ? allExpertShimmer()
                            : SizedBox(
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    allExpertShimmer();
                                    return controller
                                        .allHomeScreenApiFunction(
                                            controller.currentLat.value
                                                .toString(),
                                            controller.currentLong.value
                                                .toString());
                                  },
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.allExpertList.length,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        var model =
                                            controller.allExpertList[index];

                                        return expertUi(context, model);
                                      }),
                                ),
                              ),
                      )*/

                const SizedBox(
                  height: 10,
                ),
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
      ),
    );
  }

  AppBar appBar(BuildContext context, Function() onTap) {
    return AppBar(
      backgroundColor: ColorConstant.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Image.asset(
                    AppImages.homeLocationIcon,
                    height: 30,
                    width: 30,
                    color: ColorConstant.appColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        print('object');
                        // controller.categoryApiFunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      controller.subLocality.value.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    AppImages.dropdown,
                                    width: 11,
                                    height: 6,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              getText(
                                  title: controller.address.value.toString(),
                                  size: 10.5,
                                  fontFamily: interLight,
                                  letterSpacing: .3,
                                  lineHeight: 1.4,
                                  textOverflow: TextOverflow.ellipsis,
                                  color: ColorConstant.black3333,
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 21, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(
              //         AppRoutes.notificationScreen);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 0),
              //     child: Center(
              //       child: Image.asset(
              //         height: 17,
              //         width: 17,
              //         color: Colors.black87,
              //         AppImages.notificationHome,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: 10,
              // ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.walletScreen);
                },
                child: Image.asset(
                  height: 25,
                  width: 25,
                  AppImages.walletIcon,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        )
      ],
      centerTitle: true,
    );
  }

  categoryWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 13),
            child: Text(
              'Popular Category',
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstant.black3333,
                  fontWeight: FontWeight.w500,
                  fontFamily: interSemiBold),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          controller.categoryModel.value != null &&
                  controller.categoryModel.value!.data != null
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: 116,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            controller.categoryModel.value!.data!.length,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.singleCategoryListScreen,
                                  arguments: [
                                    controller
                                        .categoryModel.value!.data![index].id
                                        .toString(),
                                    controller
                                        .categoryModel.value!.data![index].name
                                        .toString()
                                  ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 6),
                              child: Container(
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: ColorConstant.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, -1),
                                          blurRadius: 10,
                                          color: ColorConstant.blackColor
                                              .withOpacity(.2))
                                    ]),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NetworkImageHelper(
                                      img:
                                          "${controller.categoryModel.value!.baseUrl}/${controller.categoryModel.value!.data![index].iconImage}",
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.categoryModel.value!
                                              .data![index].name ??
                                          '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: interMedium),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
