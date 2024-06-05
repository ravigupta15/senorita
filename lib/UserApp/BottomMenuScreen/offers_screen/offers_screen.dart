import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/offers_screen/controller/offers_controller.dart';
import 'package:senorita/UserApp/salon_details_screen/controller/salon_details_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../helper/searchbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/my_sperator.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../home_screen/shimmer/all_expert_shimmer.dart';

class OffersScreen extends GetView<OffersController> {
  const OffersScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: appBar(context, 'Special Offer', () => null,isShowLeading: false),
      body: RefreshIndicator(
        onRefresh: () => controller.allOffersApiFunction(2),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
            } else if (scrollNotification is ScrollEndNotification) {
              if (scrollNotification.metrics.pixels >=
                  scrollNotification.metrics.maxScrollExtent - 40) {
                controller.allOffersPaginationApiFunction();
                // controller.selectedTabBar.value ==0?
                // productPaginApiFunction():servicePaginApiFunction();
              }
            }
            return true;
          },
          child: Obx(
            () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Row(
                          children: [
                            Expanded(child: searchBar(readOnly: true, onTap: (){
                              Get.toNamed(AppRoutes.searchScreen);
                            })),
                            ScreenSize.width(10),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoutes.filterScreen);
                              },
                              child: Container(
                                height: 49,
                                width: 49,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Color(0xffD9D9D9)
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(AppImages.filterIcon,height: 20,width:20,color: Color(0xff767676),),
                              ),
                            )
                          ],
                        ),
                      ),
                      ScreenSize.height(5),
                      //   const SizedBox(
                    //     height: 20,
                    //   ),
                    // const  Padding(
                    //     padding: EdgeInsets.only(left: 22),
                    //     child: getText(
                    //         title:
                    //             "Please select categories and get best offer",
                    //         size: 14,
                    //         textAlign: TextAlign.center,
                    //         letterSpacing: 0.0,
                    //         textOverflow: TextOverflow.ellipsis,
                    //         fontFamily: interMedium,
                    //         color: ColorConstant.blackLight,
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    //   const SizedBox(
                    //     height: 0,
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.only(bottom: 10),
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 135,
                    //     child: SingleChildScrollView(
                    //       scrollDirection: Axis.horizontal,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 8),
                    //         child: Row(
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 controller.selectedAddressType.value = -1;
                    //                 controller.allSelected.value = true;
                    //                 controller.selectedCategoryId.value = '';
                    //                 controller.selectedAddressType.value = (-1);
                    //                 controller.allOffersApiFunction(1);
                    //               },
                    //               child: Padding(
                    //                 padding: EdgeInsets.only(top: 10, left: 10),
                    //                 child: Column(
                    //                   children: [
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                           borderRadius:
                    //                               BorderRadius.circular(100),
                    //                           border: Border.all(
                    //                             width: 2.0,
                    //                             color: Colors.transparent,
                    //                             style: BorderStyle.none,
                    //                           )),
                    //                       child: Container(
                    //                         width: 100,
                    //                         height: 75,
                    //                         decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.all(
                    //                               Radius.circular(10)),
                    //                           shape: BoxShape.rectangle,
                    //                           border: Border.all(
                    //                             /*Colors.black26,*/
                    //                             color: controller
                    //                                         .selectedAddressType
                    //                                         .value ==
                    //                                     -1
                    //                                 ? ColorConstant
                    //                                     .onBoardingBack
                    //                                 : Colors.black26,
                    //                           ),
                    //                           image: DecorationImage(
                    //                               alignment: Alignment.center,
                    //                               image: AssetImage(
                    //                                 AppImages.allCategory,
                    //                               ),
                    //                               fit: BoxFit.fill),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     SizedBox(
                    //                       height: 7,
                    //                     ),
                    //                     Center(
                    //                       child: getText(
                    //                           title: "All Category",
                    //                           size: 12,
                    //                           textAlign: TextAlign.center,
                    //                           letterSpacing: 0.5,
                    //                           fontFamily: interMedium,
                    //                           color: controller
                    //                                       .selectedAddressType
                    //                                       .value ==
                    //                                   -1
                    //                               ? ColorConstant.onBoardingBack
                    //                               : ColorConstant.blackColor,
                    //                           fontWeight: FontWeight.w600),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(
                    //               width: 15,
                    //             ),
                    //             Obx(() => Container(
                    //                   height: 500,
                    //                   child: ListView.builder(
                    //                       shrinkWrap: true,
                    //                       scrollDirection: Axis.horizontal,
                    //                       itemCount:
                    //                           controller.categoryList.length,
                    //                       itemBuilder: (BuildContext context,
                    //                           int index) {
                    //                         var model =
                    //                             controller.categoryList[index];
                    //                         return GestureDetector(
                    //                             behavior:
                    //                                 HitTestBehavior.opaque,
                    //                             onTap: () {
                    //                               controller.selectedAddressType
                    //                                   .value = index;
                    //                               controller.categoryId = model
                    //                                   .categoryId
                    //                                   .toString();
                    //                               controller.selectedCategoryId
                    //                                       .value =
                    //                                   model.categoryId
                    //                                       .toString();
                    //                               controller
                    //                                   .allOffersApiFunction(1);
                    //                               // controller.onlineExpertsApiFunction();
                    //                             },
                    //                             child: tabBarCategory(
                    //                                 index, model));
                    //                       }),
                    //                 )),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                      Expanded(
                        child: Container(
                            color: ColorConstant.white,
                            child: Obx(
                              () => controller.isLoading.value
                                  ? allExpertShimmer()
                                  : controller.allOffersList.isNotEmpty
                                      ? SizedBox(
                                          child: RefreshIndicator(
                                            onRefresh: () {
                                              /*allExpertShimmer();*/
                                              return controller
                                                  .allOffersApiFunction(1);
                                            },
                                            child: ListView.separated(
                                                separatorBuilder: (context,sp){
                                                  return const SizedBox(height: 23,);
                                                },
                                                shrinkWrap: true,
                                                padding:const EdgeInsets.only(left: 15,right: 14,top: 15),
                                                itemCount: controller
                                                    .allOffersList.length,
                                                physics:const ScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var model = controller
                                                      .allOffersList[index];
                                                  return expertUi(
                                                      context, model);
                                                }),
                                          ),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Center(
                                            child: getText(
                                                title: "No Data Found",
                                                size: 15,
                                                fontFamily: interMedium,
                                                color: ColorConstant.blackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                            )),
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
                  )
                ),
        ),
      ),
    );
  }

  Widget tabBarCategory(int index, model) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    width: 2.0,
                    color: Colors.transparent,
                    style: BorderStyle.none,
                  )),
              child: Obx(
                () => Container(
                  width: 100,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: controller.selectedAddressType.value == index
                          ? ColorConstant.onBoardingBack
                          : Colors.black26,
                    ),
                    image: DecorationImage(
                        alignment: Alignment.center,
                        image: NetworkImage(model.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Obx(
                () => getText(
                    title: model.categoryName,
                    size: 12,
                    textAlign: TextAlign.center,
                    letterSpacing: 0.5,
                    textOverflow: TextOverflow.ellipsis,
                    fontFamily: interMedium,
                    color: controller.selectedAddressType.value == index
                        ? ColorConstant.onBoardingBack
                        : ColorConstant.blackColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }

  expertUi(BuildContext context, model) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.categoryDetailsScreen);
        Get.toNamed(AppRoutes.categoryDetailsScreen, arguments: [
          model.userId,
          controller.latitude.toString(),
          controller.longitude.toString()
        ]);
        final categoryController = Get.put(SalonDetailController());
        categoryController.categoryId.value= model.userId.toString();
        categoryController.lat.value= controller.latitude.toString();
        controller.longitude.toString();
        categoryController.onInit();
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
                    shape: BoxShape.circle,
                    color: ColorConstant.white,
                  ),
                  child: ClipRRect(
                    borderRadius:const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    child: CachedNetworkImage(
                      height: 200,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: model.imageUrl.toString(),
                      errorWidget: (context, url, error) => Image.network(
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
                  padding: const EdgeInsets.only(left: 11,top: 8,bottom: 8,right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    title:
                                      model.subCat!=null&&model.subCat.isNotEmpty?
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
                     const  SizedBox(
                        height: 2 ,
                      ),
                    ],
                  ),
                ),
                model.address != null && model.address != "null"
                    ? Padding(
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
                    : SizedBox(),
                model.address != null && model.address != "null"
                    ? Padding(
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
                            /* SizedBox(
                              height: 10,
                            ),*/
                          ],
                        ),
                      )
                    : SizedBox(),
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
                      ),
                      model.offers!=null&& model.offers.isNotEmpty ?
                       Text(
                      model.offers[0]['type']=='buyget'?
                     "BUY 1 GET 1 FREE":
                      "Flat ${model.offers[0]['discount_pecent']}% Discount",
                        style:const TextStyle(
                          fontSize: 14.0,
                          fontFamily: interBold,
                          color: ColorConstant.darkBlueColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ) :const SizedBox(),
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

  expertCardData(BuildContext context, model) {
    return GestureDetector(
      onTap: () {
        var userId = model.userId.toString();
        var expertId = model.expertId.toString();
        Get.toNamed(AppRoutes.categoryDetailsScreen,
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
}
