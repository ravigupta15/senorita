import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/all_expert_shimmer.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/popular_category_shimmer.dart';
import 'package:senorita/UserApp/BottomMenuScreen/single_category_list_screen/controller/single_category_list_controller.dart';
import 'package:senorita/api_config/Api_Url.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/widget/no_data_found.dart';
import 'package:senorita/widget/view_salon_widget.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/format_rating.dart';
import '../../../utils/my_sperator.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../home_screen/model/home_model.dart';

class SingleCategoryListScreen extends GetView<SingleCategoryListController> {
  const SingleCategoryListScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: appBar(context, controller.categoryName.value, () {
        Get.back();
      }),
      body: RefreshIndicator(
        onRefresh: () =>
            controller.allCategoryApiFunction(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
            } else if (scrollNotification is ScrollEndNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 40) {
                controller.allCategoryPaginationApiFunction();
                // controller.selectedTabBar.value ==0?
                // productPaginApiFunction():servicePaginApiFunction();
              }
            }
            return true;
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: searchBar(
                            readOnly: true,
                            onTap: () {
                              Get.toNamed(AppRoutes.searchScreen);
                            })),
                    ScreenSize.width(10),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.filterScreen,parameters: {'route':'single'})?.then((value) {
                          if(value!=null){
                            controller.hasOffer.value = value['offer'].toString();
                            controller.category.value = value['category'].toString();
                            controller.subCategory.value= value['subcat'].toString();
                            controller.price.value = value['price'].toString();
                            controller.discount.value= value['discount'].toString();
                            controller.rating.value = value['topRated'].isNotEmpty?
                            value['topRated'].toString(): value['rating']==0.0?'':value['rating'].toString();
                            controller.distance.value = value['distance']=='0-0'?'':value['distance'].toString();
                            controller.newArrivals.value = value['arrivals'].toString();
                            controller.allCategoryApiFunction();
                          }
                        });
                      },
                      child: Container(
                        height: 49,
                        width: 49,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xffD9D9D9))),
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImages.filterIcon,
                          height: 20,
                          width: 20,
                          color: Color(0xff767676),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ScreenSize.height(5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: Obx(
                    () => controller.isLoading.value
                        ? allExpertShimmer()
                        : controller.allCategoryList.isNotEmpty
                            ? SizedBox(
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    allExpertShimmer();
                                    return controller
                                        .allCategoryApiFunction();
                                  },
                                  child: ListView.separated(
                                      separatorBuilder: (context, sp) {
                                        return const SizedBox(
                                          height: 20,
                                        );
                                      },
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 14,
                                          top: 15,
                                          bottom: 30),
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.allCategoryList.length,
                                      physics: const ScrollPhysics(),
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        var model = controller
                                            .allCategoryList[index];
                                        return salonWidget(context, model, 'single', () {
                                          Get.toNamed(AppRoutes.categoryDetailsScreen, arguments: [
                                            model.userId,
                                            controller.latitude.toString(),
                                            controller.longitude.toString()
                                          ]);
                                        });
                                      }),
                                ),
                              )
                            : noDataFound()
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
     );
  }
}