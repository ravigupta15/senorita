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
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../home_screen/model/home_model.dart';

class SingleCategoryListScreen extends GetView<SingleCategoryListController> {
  const SingleCategoryListScreen({key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ));
    return Scaffold(
      backgroundColor: ColorConstant.white,
      // drawer: drawer(context, controller),
      appBar: appBar(context, () {
        Get.back();
      }),
      body:
      RefreshIndicator(
        onRefresh: () => controller.allCategoryApiFunction(controller.categoryId.toString()),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
            } else if (scrollNotification is ScrollEndNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 40) {
                controller.allCategoryPaginationApiFunction(controller.categoryId.toString());
                // controller.selectedTabBar.value ==0?
                // productPaginApiFunction():servicePaginApiFunction();
              }
            }
            return true;
          },
          child: Column(
            children: [
               Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Container(
                        color: ColorConstant.homeBackground,
                        child:    Obx(
                              () => controller.isLoading.value
                              ? allExpertShimmer()
                              : controller.allCategoryList.isNotEmpty?SizedBox(
                            child: RefreshIndicator(
                              onRefresh: () {
                                allExpertShimmer();
                                return controller.allCategoryApiFunction(controller.categoryId.toString());
                              },
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.allCategoryList.length,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    var model = controller.allCategoryList[index];

                                    return expertUi(context, model);
                                  }),
                            ),
                          ):
                              Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: getText(
                                  title: "",
                                  size: 15,
                                  fontFamily: interMedium,
                                  color: ColorConstant.blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                  ),
                ),
              const SizedBox(height: 15,),

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Column(
            children: [
              Divider(
                height: 2,
                 thickness: 1,
                color: ColorConstant.drawerEmail,

              ),
              Card(
                margin: EdgeInsets.zero,
                child: Container(
                  height: 53,
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: ()
                          {
                            controller.shortBySheet(context);
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                height: 15,
                                width: 15,
                                AppImages.shortBy,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(
                                      title: "Sort by",
                                      size: 13,
                                      fontFamily: interMedium,
                                      letterSpacing: 0.2,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(height: 3,),
                                  const getText(
                                      title: "Popularity",
                                      size: 11,
                                      letterSpacing: 0.2,
                                      fontFamily: interRegular,
                                      color: ColorConstant.qrViewText,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: ColorConstant.dot,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              height: 15,
                              width: 15,
                              AppImages.filterBy,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(width: 15,),
                            GestureDetector(
                              onTap: ()
                              {
                                controller.filterSheet(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText(
                                      title: "Filter",
                                      size: 13,
                                      fontFamily: interMedium,
                                      letterSpacing: 0.2,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(height: 3,),
                                  getText(
                                      title: "Apply filter",
                                      size: 11,
                                      letterSpacing: 0.2,
                                      fontFamily: interRegular,
                                      color: ColorConstant.qrViewText,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),

            ],
          )
        ),
      ),
    );
  }


  expertUi(BuildContext context, model) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(AppRoutes.categoryDetailsScreen);
          Get.toNamed(AppRoutes.categoryDetailsScreen,
              arguments: [model.userId,
                controller.latitude.toString(),controller.longitude.toString()]
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //set border radius more than 50% of height and width to make circle
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorConstant.white,

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                        child: /*Image.network(
                          model.imageUrl.toString(),
                          *//* "https://dealsdekho.com/wp-content/uploads/2023/01/Nykaa-Upcoming-Sales.png",*//*
                          height: 295,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),*/
                        /*CachedNetworkImage(
                          height: 295,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: model.imageUrl.toString(),
                          errorWidget: (context, url, error) =>Image.network(
                            "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                            height: 295,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),*/
                        CachedNetworkImage(
                          height: 200,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: model.imageUrl.toString(),
                          errorWidget: (context, url, error) =>
                              Image.network(
                                "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                                height: 250,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 2,right: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: new EdgeInsets.only(right: 13.0),
                                  child: new Text(
                                    model.userName,
                                    overflow: TextOverflow.ellipsis,
                                    style:  new TextStyle(
                                      fontSize: 14.0,
                                      letterSpacing: 0,
                                      fontFamily: interSemiBold,
                                      color: ColorConstant.blackColorDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                model.avg_rating.toString()!="null"?
                                Container(
                                  decoration: BoxDecoration(
                                      color: ColorConstant.greenColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(
                                          color: ColorConstant.greenColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      children: [
                                        getText(
                                            title: model.avg_rating.toString()+".0",
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
                                ):SizedBox(),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            getText(
                                title: model.categoryName.toString(),
                                size: 12,
                                fontFamily: interMedium,

                                color: ColorConstant.blackLight,
                                fontWeight: FontWeight.w400),

                            SizedBox(
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      model.address!=null && model.address!="null"?
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  width: 18,
                                  height: 18,
                                  AppImages.location,
                                ),
                                SizedBox(width: 3,),

                                Container(
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  padding: new EdgeInsets.only(right: 13.0),
                                  child: new Text(
                                    model.address.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: interMedium,
                                      color: ColorConstant.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ):SizedBox(),

                      model.lat!=null &&   model.lat!="null"?
                      Padding(
                        padding: const EdgeInsets.only(left: 5,top: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  width: 13,
                                  color: ColorConstant.greyColor,
                                  height: 13,
                                  AppImages.distance,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  padding: new EdgeInsets.only(right: 13.0),
                                  child: new Text(" "+
                                      model.distance.toString()+" Km",
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
                           /* SizedBox(
                              height: 10,
                            ),*/
                          ],
                        ),
                      ):SizedBox(),


                     /* Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Image.asset(
                          width: MediaQuery.of(context).size.width,
                          color: ColorConstant.checkBox,

                          AppImages.dotLine,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 6,right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Exp. ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    letterSpacing: 0.6,
                                    fontFamily: interMedium,
                                    color: ColorConstant.onBoardingBack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "- ${model.experience} year",
                                  *//* "4",*//*
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

                            int.parse(model.offer_count) > 0?
                            Row(
                              children: [
                                Image.asset(
                                  width: 17,
                                  height: 17,
                                  AppImages.specialOffer,
                                ),
                                const SizedBox(width: 5,),
                                const Text("Special offer",
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                    fontSize: 14.0,
                                    letterSpacing: 0.6,
                                    fontFamily: interMedium,
                                    color: ColorConstant.blueColorOffer,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ):SizedBox(),
                          ],
                        ),
                      ),*/
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


  expertCardData(BuildContext context, model) {
    return GestureDetector(
      onTap: () {
        var userId = model.userId.toString();
        var expertId = model.expertId.toString();
        Get.toNamed( AppRoutes.categoryDetailsScreen,
            arguments: ['login', userId.toString(), expertId.toString()]);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 10,
          right: 10,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              //set border radius more than 50% of height and width to make circle
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8, right: 15, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorConstant.white),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.imageUrl),
                      radius: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* getText(
                                    title: model.userName,
                                    size: 14,
                                    fontFamily: celiaMedium,
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w500),*/
                                new Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  padding: new EdgeInsets.only(right: 13.0),
                                  child: new Text(
                                    model.userName,
                                    overflow: TextOverflow.ellipsis,
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: celiaMedium,
                                      color: ColorConstant.blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                getText(
                                    title: "Experience " +
                                        model.experience.toString() +
                                        " Years",
                                    size: 13,
                                    fontFamily: celiaRegular,
                                    color: ColorConstant.homeExp,
                                    fontWeight: FontWeight.w400),
                                getText(
                                    title: model.categoryName.toString(),
                                    size: 13,
                                    fontFamily: celiaRegular,
                                    color: ColorConstant.homeExp,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                            /* Spacer(),
                            model.offer_count > 0.toString()
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xffE9FCF0)),
                                    height: 55,
                                    width: 55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.asset(
                                          height: 55,
                                          width: 55,
                                          AppImages.offerNew,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),*/
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
      leadingWidth: 30,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.backIcon,
                      color: Colors.black87,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                Center(
                  child: getText(
                      title: controller.categoryName.value,
                      size: 18,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
                Center(
                  child: getText(
                      title: "",
                      size: 16,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
      centerTitle: true,
    );
  }
}
/*final startPointPrice=20.0.obs;
   final endPointPrice=10.0.obs;*/