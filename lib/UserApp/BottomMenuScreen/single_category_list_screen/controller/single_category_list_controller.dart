import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:senorita/helper/getText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ExpertApp/expert_registration_screen/models/category_model.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/appimage.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/stringConstants.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/toast.dart';
import '../../home_screen/model/home_model.dart';

class SingleCategoryListController extends GetxController {
  final categoryName = "".obs;
  final shortByList = [].obs;
  RxInt selectedCategoryType = (-1).obs;
  final categoryString = "".obs;
  final categoryId = "".obs;
  final allCategoryList = [].obs;

  final startPointPrice = 0.0.obs;
  final endPointPrice = 70.0.obs;

  final filterButton = false.obs;
  final filterButton1 = false.obs;

  //search
  final searchList = [].obs;
  final isSearch = false.obs;

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  ScrollController? paginationController;
  final perPage = 10.obs;
  final isLoading= false.obs;
  String token = "";

  final filterPrice = [
    'Under Rs. 499',
    'Rs. 500-699',
    'Rs. 700-999',
    'Rs. 1000-1499',
    'Rs. 1500-1999',
  ].obs;

  final filterType = [
    'Price',
    'Customer\nRatings',
    'Distance',
  ].obs;

  final filterRating = [
    '1 * & above',
    '2 * & above',
    '3 * & above',
    '4 * & above',
    '5 * & above',
  ].obs;

  final filterUiChange = "0".obs;
  RxInt selectedFilterType = (0).obs;

  final lowerValue = 50.obs;
  final upperValue = 180.obs;

  final locationResult = "0".obs;

  final selectedCategoryId = "".obs;

  final latitude = "".obs;
  final longitude = "".obs;

  @override
  Future<void> onInit() async {
    //categoryName=Get.arguments[1];
    if (Get.arguments[1] != null) {
      categoryName.value = Get.arguments[1];
    } else {
      categoryName.value = "";
    }
    if (Get.arguments[0] != null) {
      categoryId.value = Get.arguments[0];
    } else {
      categoryId.value = "";
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    print("cuttentlatitudeOffer"+latitude.value.toString());
    print("cuttentlongitudeOffer"+longitude.value.toString());
    allCategoryApiFunction(categoryId.toString());
    getShortByListApiFunction();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void shortBySheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      getText(
                          title: "Sort by",
                          size: 18,
                          letterSpacing: 0.4,
                          fontFamily: interRegular,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      //Category
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        right: 10,
                                        bottom: 15,
                                        top: 10),
                                    itemCount: shortByList.length,
                                    itemBuilder: (context, index) {
                                      CategoryModel model =
                                          CategoryModel.fromJson(
                                              shortByList[index]);
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Obx(
                                            () => GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                selectedCategoryType.value =
                                                    index;
                                                categoryString.value =
                                                    model.name.toString();
                                                categoryId.value =
                                                    model.id.toString();

                                                // Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  getText(
                                                      title:
                                                          model.name.toString(),
                                                      size: 13,
                                                      fontFamily: interMedium,
                                                      color: ColorConstant
                                                          .offerTextBlack,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  Spacer(),
                                                  selectedCategoryType.value ==
                                                          index
                                                      ? const Icon(
                                                          Icons.check_circle,
                                                          color: ColorConstant
                                                              .onBoardingBack,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .radio_button_off_outlined,
                                                          color: ColorConstant
                                                              .fitterLine,
                                                        ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void filterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  //   selectedCategoryType = (-1).obs;
                  selectedFilterType = (0).obs;
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        getText(
                            title: "Filters",
                            size: 18,
                            letterSpacing: 0.4,
                            fontFamily: interRegular,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorConstant.borderFilter,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8))),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: filterType.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Obx(
                                              () => Container(
                                                color:
                                                    selectedFilterType.value ==
                                                            index
                                                        ? ColorConstant.white
                                                        : ColorConstant
                                                            .borderFilter,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Obx(
                                                      () => GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .opaque,
                                                        onTap: () {
                                                          selectedFilterType
                                                              .value = index;
                                                          index == 0
                                                              ? filterUiChange
                                                                  .value = "0"
                                                              : index == 1
                                                                  ? filterUiChange
                                                                          .value =
                                                                      "1"
                                                                  : filterUiChange
                                                                          .value =
                                                                      "2";
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8,
                                                                  right: 5,
                                                                  top: 12,
                                                                  bottom: 10),
                                                          child: getText(
                                                              title: filterType[
                                                                      index]
                                                                  .toString(),
                                                              size: 13,
                                                              fontFamily:
                                                                  interRegular,
                                                              color: selectedFilterType
                                                                          .value ==
                                                                      index
                                                                  ? ColorConstant
                                                                      .onBoardingBack
                                                                  : ColorConstant
                                                                      .qrViewText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
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
                            ),
                            Obx(() => filterUi(filterUiChange.value)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      width: MediaQuery.of(context).size.width,
                      color: ColorConstant.fitterLine,
                      height: 1,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, bottom: 8, top: 8),
                      child: Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 35, right: 35, top: 1, bottom: 1),
                              child: const getText(
                                  title: "Reset filter",
                                  size: 13,
                                  fontFamily: interRegular,
                                  color: ColorConstant.qrViewText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.only(
                                  left: 0, right: 5, top: 13, bottom: 13),
                              decoration: BoxDecoration(
                                  color: ColorConstant.onBoardingBack,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: getText(
                                    title: "Apply",
                                    size: 14,
                                    fontFamily: interRegular,
                                    color: ColorConstant.white,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget filterUi(String filterUiChange) {
    return Expanded(
      flex: 6,
      child: filterUiChange == "0"
          ? Column(
              children: [
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: 15, right: 10, bottom: 0, top: 10),
                    itemCount: filterPrice.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Obx(
                            () => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                selectedCategoryType.value = index;
                                categoryString.value = "asdfgh";
                                categoryId.value = "asdfgh";

                                // Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    selectedCategoryType.value == index
                                        ? const Icon(
                                            Icons.check_box,
                                            color: ColorConstant.onBoardingBack,
                                          )
                                        : Icon(
                                            Icons
                                                .check_box_outline_blank_rounded,
                                            color: ColorConstant.blackLight,
                                          ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    getText(
                                        title: filterPrice[index].toString(),
                                        size: 12,
                                        fontFamily: interMedium,

                                        color: ColorConstant.blackColor,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            )
          : filterUiChange == "1"
              ? Obx(
                  () => Column(
                    children: [
                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 15, right: 10, bottom: 0, top: 10),
                          itemCount: filterRating.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      selectedCategoryType.value = index;
                                      categoryString.value = "asdfgh";
                                      categoryId.value = "asdfgh";

                                      // Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          selectedCategoryType.value == index
                                              ? const Icon(
                                                  Icons.check_box,
                                                  color: ColorConstant
                                                      .onBoardingBack,
                                                )
                                              : Icon(
                                                  Icons
                                                      .check_box_outline_blank_rounded,
                                                  color:
                                                      ColorConstant.blackLight,
                                                ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          getText(
                                              title: filterRating[index]
                                                  .toString(),
                                              size: 13,
                                              fontFamily: interMedium,

                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlutterSlider(
                      values: [0],
                      max: 50,
                      min: 0,
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBarHeight: 10,
                        activeTrackBarHeight: 10,
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorConstant.addPriceBack,
                          border:
                              Border.all(width: 2, color: Colors.transparent),
                        ),
                        activeTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ColorConstant.onBoardingBack),
                      ),
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Material(
                          type: MaterialType.circle,
                          color: Colors.white,
                          elevation: 10,
                          child: Container(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: ColorConstant.onBoardingBack,
                                size: 25,
                              )),
                        ),
                      ),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        lowerValue = lowerValue;
                        upperValue = upperValue;

                        locationResult.value = lowerValue.toString();
                      },
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            getText(
                                title: "Distance is : ",
                                size: 14,
                                fontFamily: interMedium,
                                letterSpacing: 0.4,
                                color: ColorConstant.blackColor,
                                fontWeight: FontWeight.w500),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: getText(
                                  title: locationResult.value + " Km",
                                  size: 13,
                                  fontFamily: interMedium,
                                  letterSpacing: 0.4,
                                  color: ColorConstant.onBoardingBack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  getShortByListApiFunction() async {
    final response =
        await ApiConstants.get(url: ApiUrls.expertCategoriesApiUrl);
    if (response["success"] == true) {
      if (response['data'] != null) {
        shortByList.value = response['data'];
      }
    }
    //showToast(response["message"]);
  }

  allCategoryApiFunction(String categoryId) async {
    page.value=1;
   // showCircleProgressDialog(Get.context!);
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));

    request.fields.addAll({
      'page_numbar': page.value.toString(),
      'has_offer':"2",
      'lat':latitude.value.toString(),
      'lng':longitude.value.toString(),
      'category_id': categoryId.toString()
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log(response.body);
  //  Get.back();
    isLoading.value = false;
    allCategoryList.clear();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['data'].length; i++) {
          OnlineExpertModel model = OnlineExpertModel(
            result['data'][i]['experience'],
            result['data'][i]['status'],
            result['data'][i]['image_url'],
            result['data'][i]['user']['name'],
            result['data'][i]['category_id'],
            result['data'][i]['user']['id'],
            result['data'][i]['user']['mobile'],
            result['data'][i]['category']!=null?result['data'][i]['category']['name']:"",
            result['data'][i]['offer_count'].toString(),
            result['data'][i]['id'],
            result['data'][i]['user']['address'],
            result['data'][i]['user']['distance'],
            result['data'][i]['user']['lat'],
            result['data'][i]['user']['lng'],
            result['data'][i]['avg_rating'],
          );
          isLoading.value = false;
          allCategoryList.add(model);
        }
        count.value=result['total_count'];
      }
    }
    else
    {
      Get.back();
    }
  }

  allCategoryPaginationApiFunction(String categoryId) async {
    if(isLoadMoreRunning.value==false){
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false
      ) {
        if (count.value>allCategoryList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer' + token};
          var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
          request.fields.addAll({
            'page_numbar': page.value.toString(),
            'has_offer':"2",
            'lat':latitude.value.toString(),
            'lng':longitude.value.toString(),
            'category_id': categoryId.toString()
          });
          request.headers.addAll(headers);
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode == 200) {
            final result = jsonDecode(response.body) as Map<String, dynamic>;
            if (result['success'] == true && result['success'] != null) {
              for (int i = 0; i < result['data'].length; i++) {
                OnlineExpertModel model = OnlineExpertModel(
                  result['data'][i]['experience']!=null?result['data'][i]['experience']:"",
                  result['data'][i]['status'],
                  result['data'][i]['image_url'],
                  result['data'][i]['user']['name'],
                  result['data'][i]['category_id'],
                  result['data'][i]['user']['id'],
                  result['data'][i]['user']['mobile'],
                  result['data'][i]['category']!=null?result['data'][i]['category']['name']:"",
                  result['data'][i]['offer_count'],
                  result['data'][i]['id'],
                  result['data'][i]['user']['address'],
                  result['data'][i]['user']['distance'],
                  result['data'][i]['user']['lat'],
                  result['data'][i]['user']['lng'],
                  result['data'][i]['avg_rating'],
                );
                allCategoryList.add(model);
              }
              isLoadMoreRunning.value=false;
            }
          }
        }
      }}
  }
}
