import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../widget/error_box.dart';

class WalletController extends GetxController {
  final name="".obs;
  final email="".obs;
  final mobile="".obs;
  final id="".obs;// Initialize with your desired upper value

  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value=prefs.getString("id").toString();
    super.onInit();
  }

  callApiFunction()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // isLoading.value = true;
    var headers = {'Authorization': 'Bearer ${prefs.getString("token").toString()}'};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.transactionUrl));
    request.fields.addAll({
      'user_id':'1',
      'type':'reward'
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log(response.body);
    // Get.back();
    // allOffersList.clear();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
      }
    }
    else
    {
      Get.back();
    }

  }

}
