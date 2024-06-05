import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/utils/showcircledialogbox.dart';
import 'package:senorita/utils/utils.dart';

import '../../../ExpertApp/BottomMenuScreen/specialoffers/model/expert_category_subcat_model.dart';
import '../../../api_config/ApiConstant.dart';
import '../../../api_config/Api_Url.dart';

class FilterController extends GetxController{
final selectedFilterIndex = 0.obs;
var currentRangeValues = const RangeValues(0, 100).obs;

var categoryModel = ExpertCategorySubCatModel().obs;
final priceList = ['0-100','100-1000','1000-10000','10000+'].obs;
final discountList = ['0-10%',"10-30%","30-50%","50-70%","70-90%"];
final ratingList = [ '1 * & above', '2 * & above', '3 * & above', '4 * & above', '5 * & above',];
final selectedPriceValue = ''.obs;
final selectedDiscountValue = ''.obs;
final selectedRatingValue = ''.obs;

@override
  void onInit() async{
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
  final response = await ApiConstants.post(url: ApiUrls.expertSubCategoriesApiUrl,body: body);
  Get.back();
  if (response != null && response['success'] == true) {
    if (response!=null&& response['success']!=false&& response['data'] != null) {
      categoryModel.value = ExpertCategorySubCatModel.fromJson(response);
    }
  }
}

}