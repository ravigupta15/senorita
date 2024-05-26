import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../widget/error_box.dart';

class PriceListController extends GetxController {
  final hideSubtopic = false.obs;
  final hidechildTopic = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final addButton = false.obs;
  String token = "";
  ///Category data
  RxInt selectedCategoryType = (-1).obs;
  final categoryString = "".obs;
  final categoryId = "".obs;
  final allCategoryList = [].obs;
  final sendDataList = [].obs;

  //New Data Add
  final addTopicList = [].obs;

  Map jsonObject = {};

  updateItems() {
    var model = AddPriceModel();
    addTopicList.add(model);
  }

  removeItems(index) {
    addTopicList.removeAt(index);
  }

  @override
  void onInit() async {
    getCategoryPriceApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    update();
    super.onInit();
  }


  getCategoryPriceApiFunction() async {
    final response = await ApiConstants.getWithToken(
        url: ApiUrls.expertSubCategoriesPriceApiUrl, useAuthToken: true);
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCategoryList.value = response['data'];
      }
    }
    //showToast(response["message"]);
  }

  submitMultipleItems(BuildContext context, List dataList) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer' + token
    };
    var request = http.Request('POST', Uri.parse('https://senoritaapp.com/backend/public/api/add_multiple_items'));
    request.body = json.encode({
      "sub_category_id": categoryId.value.toString(),
      "items": dataList
    });
    print(request.body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     Get.back();
      //showToast(request[''])
    }
    else {
      print(response.reasonPhrase);
    }
  }
}

class AddPriceModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final status = false.obs;
}
