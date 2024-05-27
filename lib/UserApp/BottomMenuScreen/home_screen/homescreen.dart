import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/home_screen/shimmer/all_expert_shimmer.dart';
import 'package:senorita/helper/network_image_helper.dart';
import 'package:senorita/widget/no_data_found.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/format_rating.dart';
import '../../../utils/my_sperator.dart';
import '../../../utils/stringConstants.dart';
import '../dashboard_screen/controller/dashboard_controller.dart';

class HomeScreen extends GetView<DashboardController> {
  const HomeScreen({key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ));
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
                searchBar(),
                //Slider
                Obx(()=>
                controller.bannerList.isNotEmpty?
                Padding(
                    padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Container(
                        padding:const EdgeInsets.only(top: 0),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Obx(
                              () => controller.isLoading.value
                              ? homeScreenShimmer()
                              : SizedBox(
                            child: RefreshIndicator(
                                onRefresh: () {
                                  homeScreenShimmer();
                                  return controller
                                      .allHomeScreenApiFunction(
                                      controller.currentLat.value
                                          .toString(),
                                      controller.currentLong.value
                                          .toString(),'',true);
                                },
                                child: CarouselSlider(
                                  items: <Widget>[
                                    for (var i = 0;
                                    i <
                                        controller
                                            .bannerList.length;
                                    i++)
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${controller.offerBaseUrl.value.toString()}/${controller
                                                    .bannerList[i]['banner']}"
                                                    ),
                                            fit: BoxFit.fill,
                                          ),
                                          // border:
                                          //     Border.all(color: Theme.of(context).accentColor),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                  ],
                                  options: CarouselOptions(
                                    height: 250.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    autoPlayCurve:
                                    Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                    const Duration(milliseconds: 500),
                                    viewportFraction: 1,
                                  ),
                                )),
                          ),
                        ))):const SizedBox(),
                ),
                //All Expertise

                // all category
                categoryWidget(),
                Padding(
                  padding: const EdgeInsets.only(right: 12, left: 12,top: 15),
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
                      const SizedBox(height: 20,),
                      ListView.separated(
                        separatorBuilder: (context,sp){
                          return const SizedBox(height: 23,);
                        },
                      padding:const EdgeInsets.only(left: 15,right: 14),
                      shrinkWrap: true,
                      itemCount: controller.allExpertList.length,
                      physics:const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var model = controller.allExpertList[index];
                        return expertUi(context, model);
                      }
                ),
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

  expertUi(BuildContext context, model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.categoryDetailsScreen, arguments: [
          model['user']['id'].toString(),
          controller.lat.toString(),
          controller.long.toString(),
        ]);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.white,
                  ),
                  child: ClipRRect(
                    borderRadius:const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    child: /*Image.network(
                      controller.listing_base_url.value+model['user']['profile_picture'].toString(),
                      height: 295,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),*/
                    model['user']!=null?   CachedNetworkImage(
                      height: 200,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      imageUrl: controller.listing_base_url.value +
                          model['user']['profile_picture'].toString(),
                      errorWidget: (context, url, error) =>
                          Image.network(
                        "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                        height: 250,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ): Image.network(
                      "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                      height: 250,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
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
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    softWrap: true,
                                      model['user']!=null?
                                    model['user']['name'].toString():"",
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
                                  model['category'] != null &&
                                      model['category'] != "null"
                                      ? getText(
                                      title: model['category']['name']?? '',
                                      size: 13,
                                      fontFamily: interMedium,
                                      color: ColorConstant.blackLight,
                                      fontWeight: FontWeight.w500)
                                      : SizedBox(),
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
                                      model['avg_rating']==null?'0.0':
                                      model['avg_rating'].toString().contains('.')?
                                      model['avg_rating'].toString():"${model['avg_rating'].toString()}.0",
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
                       const SizedBox(height: 2,),
                      ],
                    ),
                  ),
                  model['user']!=null&& model['user']['address'] != null &&
                          model['user']['address'] != "null"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    width: 18,
                                    height: 18,
                                    AppImages.location,
                                  ),
                                const  SizedBox(
                                    width: 3,
                                  ),
                                  Flexible(
                                    child: Text(
                                        model['user']!=null? model['user']['address'].toString():'',
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
                           const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        )
                      :const SizedBox(),
                  model['user']!=null&&model['user']['lat'] != null &&
                          model['user']['lat'] != "null"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5, top: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    width: 13,
                                    color: ColorConstant.blackLight,
                                    height: 13,
                                    AppImages.distance,
                                  ),
                                 const SizedBox(
                                    width: 3,
                                  ),
                                  Flexible(
                                    child: Text(
                                      " " +
                                          model['user']['distance']
                                              .toString() +
                                          " km",
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
                            ],
                          ),
                        )
                      :const SizedBox(),
                 const Padding(
                    padding:  EdgeInsets.only(left: 10, right: 10,top: 10),
                    child: MySeparator(color: Color(0xffD6D5D5)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 11, right: 5),
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
                              "- ${model['experience'].toString()} year",
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
                        int.parse(model['offer_count'].toString(),) <
                                0
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
              ),
            )
          ],
        ),
      ),
    );
  }

  searchBar() {
    return Container(
        height: 49,
        margin:const EdgeInsets.only(left: 15,right: 15,top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: ColorConstant.addPriceListText
          )
        ),
        alignment: Alignment.center,
        child: TextFormField(
          style: TextStyle(
              color: ColorConstant.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: interRegular),
          decoration: InputDecoration(
              prefixIcon: Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                child: Image.asset(
                  AppImages.search,
                  height: 20,
                  width: 20,
                ),
              ),
              hintText: 'Search on senoritaapp...',
              hintStyle:const TextStyle(
                  color: ColorConstant.qrViewText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: interRegular),
              border: InputBorder.none),
          onChanged: (val){
            controller.allHomeScreenApiFunction(controller.currentLat.value.toString(),
                controller.currentLong.value.toString(),val,false);
          },
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
            padding: const EdgeInsets.only(left:10,right: 15),
            child: GestureDetector(
              onTap: (){
              },
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
                      onTap: (){
                        print('object');
                        controller.categoryApiFunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Obx(()=>Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text( controller.subLocality.value.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: interMedium,
                                        color: ColorConstant.blackColor,
                                        fontWeight: FontWeight.w500
                                    ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Image.asset(AppImages.dropdown,width: 11,height: 6,)
                                ],
                              ),
                              const SizedBox(height: 2,),
                              getText(
                                  title:
                                  controller.address.value.toString(),
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

  categoryWidget(){
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
          padding: EdgeInsets.only(left: 13),
          child: Text('Popular Category',
            style: TextStyle(
              fontSize: 18,
              color: ColorConstant.black3333,
              fontWeight: FontWeight.w500,
              fontFamily: interSemiBold
            ),
            ),
        ),
          const SizedBox(height: 15,),
          controller.categoryModel.value!=null&&controller.categoryModel.value!.data!=null?SingleChildScrollView(
              child: SizedBox(
                height: 116,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.categoryModel.value!.data!.length, (index) {
                      return GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.singleCategoryListScreen,arguments: [controller.categoryModel.value!.data![index].id.toString(),controller.categoryModel.value!.data![index].name.toString()]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6,right: 6),
                            child: Container(
                              height:100,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: ColorConstant.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        offset:const Offset(0, -1),
                                        blurRadius: 10,color: ColorConstant.blackColor.withOpacity(.2)
                                    )
                                  ]
                              ),
                              padding: EdgeInsets.only(left: 5,right: 5),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NetworkImageHelper(img:"${controller.categoryModel.value!.baseUrl}/${controller.categoryModel.value!.data![index].iconImage}",
                                    width: 35.0,height: 35.0,
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(controller.categoryModel.value!.data![index].name??'',
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,fontWeight: FontWeight.w500,
                                        fontFamily: interMedium
                                    ),),
                                ],
                              ),
                            ),
                          ),
                        );
                    }),
                  ),
                ),
              ),
          ):Container()
        ],
      ),
    );
  }
}
