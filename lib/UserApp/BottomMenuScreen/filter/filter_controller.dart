import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_cat_model.dart';
import 'package:senorita/model/merge_category_model.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';

import '../../../ExpertApp/BottomMenuScreen/specialoffers/model/expert_category_subcat_model.dart';
import '../../../api_config/ApiConstant.dart';
import '../../../api_config/Api_Url.dart';

class FilterController extends GetxController{
final selectedFilterIndex = 0.obs;
final selectedRating = 0.0.obs;
final currentRangeValues = 0.0.obs;
List <FilterCatSubCatModel> categoryList = [];
var categoryModel = ExpertCategorySubCatModel().obs;
final priceList = ['500-699','700-999','1000-1499','1500-1999'].obs;
final discountList = ['0-10',"10-30","30-50","50-70","70-90","Buy 1 Get 1"];
final ratingList = [ '1 * & above', '2 * & above', '3 * & above', '4 * & above', '5 * & above',];
final selectedPriceValue = ''.obs;
final selectedDiscountValue = ''.obs;
var mergeCategoryModel = MergeCategoryModel().obs;

final sortByList = ['Offers','Expert top rated','New Arrivals'].obs;

final selectedSort = 10.obs;

final route = ''.obs;
@override
  void onInit() async{
route.value = Get.parameters['route']!;
  Future.delayed(Duration.zero,(){
    getCategoryApiFunction();
  });
    super.onInit();
  }

static String valueToString(double value) {
  return value.toStringAsFixed(0);
}


getCategoryApiFunction() async {
  showCircleProgressDialog(navigatorKey.currentContext!);
  var body = {
    'category':'1'
  };
  final response = await ApiConstants.post(url: ApiUrls.mergeCategoryListUrl,body: body);
  Get.back();
  if (response != null && response['success'] == true) {
    if (response!=null&& response['success']!=false&& response['data'] != null) {
      mergeCategoryModel.value = MergeCategoryModel.fromJson(response);
    }
  }
}}
