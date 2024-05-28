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
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ));
    return Scaffold(
      backgroundColor: ColorConstant.white,
      // drawer: drawer(context, controller),
      appBar: appBar(context,controller.categoryName.value, () {
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
                        color: ColorConstant.white,
                        child:    Obx(
                              () => controller.isLoading.value
                              ? allExpertShimmer()
                              : controller.allCategoryList.isNotEmpty?SizedBox(
                            child: RefreshIndicator(
                              onRefresh: () {
                                allExpertShimmer();
                                return controller.allCategoryApiFunction(controller.categoryId.toString());
                              },
                              child: ListView.separated(
                                  separatorBuilder: (context,sp){
                                return const SizedBox(height: 23,);
                              },
                                  padding:const EdgeInsets.only(left: 15,right: 14),
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
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.categoryDetailsScreen);
        Get.toNamed(AppRoutes.categoryDetailsScreen,
            arguments: [model.userId,
              controller.latitude.toString(),controller.longitude.toString()]
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset:const Offset(0, -2),
                color: ColorConstant.blackColor.withOpacity(.2),
                blurRadius: 10
            )
          ]
      ),
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
                    child:
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 11,right: 12,top: 8,bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.userName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: interSemiBold,
                                    color: ColorConstant.blackColorDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3,),
                                getText(
                                    title: model.subCat!=null&&model.subCat.isNotEmpty?
                                    model.subCat.map((subCat)=>subCat['name']).join(', '):"",
                                    size: 13,
                                    fontFamily: interMedium,
                                    color: ColorConstant.blackLight,
                                    fontWeight: FontWeight.w500)
                                ,
                              ],
                            ),
                          ),

                          Container(
                            decoration:const BoxDecoration(
                              color: ColorConstant.greenStar,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(4)),),
                            padding:const EdgeInsets.only(left: 5,right: 4,top: 3,bottom: 4),
                            child: Row(
                              children: [
                                getText(
                                    title:
                                    model.avg_rating==null?'0.0':
                                    model.avg_rating.toString().contains('.')?
                                    model.avg_rating.toString():"${model.avg_rating.toString()}.0",
                                    size: 13,
                                    fontFamily: interMedium,
                                    color: ColorConstant.white,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(
                                  width: 2,
                                ),
                                Image.asset(
                                  width: 10,
                                  height: 10,
                                  color: ColorConstant.white,
                                  AppImages.rating,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
                model.address!=null && model.address!="null"?
                Padding(
                  padding: const EdgeInsets.only(left: 11,right: 12),
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
                          SizedBox(
                            width: 3,
                          ),
                          Flexible(
                            child: Text(
                              model.address.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: interMedium,
                                color: ColorConstant.blackLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      const  SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                )
                    :SizedBox(),

                model.lat!=null &&   model.lat!="null"?
                Padding(
                  padding: const EdgeInsets.only(left: 11 ,right: 12, top: 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            width: 13,
                            height: 13,
                            AppImages.distance,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Flexible(
                            child:  Text(
                              " " + model.distance.toString() + " Km",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: interMedium,
                                color: ColorConstant.blackLight,
                                fontWeight: FontWeight.w500,
                              ),),
                          )
                        ],
                      ),
                    ],
                  ),
                )
                    :SizedBox(),

                const Padding(
                  padding:  EdgeInsets.only(left: 11, right: 12,top: 10),
                  child: MySeparator(color: Color(0xffD6D5D5)),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 11, top: 11, right: 12),
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
                              fontFamily: interMedium,
                              color: ColorConstant.pointBg,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "- ${model.experience} year",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: interMedium,
                              color: ColorConstant.blackLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),int.parse(model.offer_count) > 0
                          ?
                      Row(
                        children: [
                          Image.asset(
                            width: 17,
                            height: 17,
                            AppImages.specialOffer,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Special offer",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: interMedium,
                              color: ColorConstant.darkBlueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  // expertCardData(BuildContext context, model) {
  //   return GestureDetector(
  //     onTap: () {
  //       var userId = model.userId.toString();
  //       var expertId = model.expertId.toString();
  //       Get.toNamed( AppRoutes.categoryDetailsScreen,
  //           arguments: ['login', userId.toString(), expertId.toString()]);
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //         top: 0,
  //         left: 10,
  //         right: 10,
  //       ),
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width,
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: ColorConstant.white,
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: [
  //                 BoxShadow(
  //                     offset:const Offset(0, -2),
  //                     color: ColorConstant.blackColor.withOpacity(.2),
  //                     blurRadius: 10
  //                 )
  //               ]
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //                 left: 8, right: 15, top: 15, bottom: 15),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.circle, color: ColorConstant.white),
  //                   child: CircleAvatar(
  //                     backgroundImage: NetworkImage(model.imageUrl),
  //                     radius: 24,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               /* getText(
  //                                   title: model.userName,
  //                                   size: 14,
  //                                   fontFamily: celiaMedium,
  //                                   color: ColorConstant.blackColor,
  //                                   fontWeight: FontWeight.w500),*/
  //                               new Container(
  //                                 width: MediaQuery.of(context).size.width / 2,
  //                                 padding: new EdgeInsets.only(right: 13.0),
  //                                 child: new Text(
  //                                   model.userName,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: new TextStyle(
  //                                     fontSize: 14.0,
  //                                     fontFamily: celiaMedium,
  //                                     color: ColorConstant.blackColor,
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                 ),
  //                               ),
  //                               getText(
  //                                   title: "Experience " +
  //                                       model.experience.toString() +
  //                                       " Years",
  //                                   size: 13,
  //                                   fontFamily: celiaRegular,
  //                                   color: ColorConstant.homeExp,
  //                                   fontWeight: FontWeight.w400),
  //                               getText(
  //                                   title: model.categoryName.toString(),
  //                                   size: 13,
  //                                   fontFamily: celiaRegular,
  //                                   color: ColorConstant.homeExp,
  //                                   fontWeight: FontWeight.w400),
  //                             ],
  //                           ),
  //                           /* Spacer(),
  //                           model.offer_count > 0.toString()
  //                               ? Container(
  //                                   decoration: BoxDecoration(
  //                                       borderRadius: BorderRadius.circular(50),
  //                                       color: const Color(0xffE9FCF0)),
  //                                   height: 55,
  //                                   width: 55,
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(5.0),
  //                                     child: ClipRRect(
  //                                       borderRadius: BorderRadius.all(
  //                                           Radius.circular(10)),
  //                                       child: Image.asset(
  //                                         height: 55,
  //                                         width: 55,
  //                                         AppImages.offerNew,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 )
  //                               : SizedBox(),*/
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: 2,
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
/*final startPointPrice=20.0.obs;
   final endPointPrice=10.0.obs;*/