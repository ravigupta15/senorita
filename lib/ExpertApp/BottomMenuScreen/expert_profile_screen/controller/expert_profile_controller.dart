import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_profile_screen/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../widget/error_box.dart';

class ExpertProfileController extends GetxController {
  // final expertId = ''.obs;
  // String id="";// Initialize with your desired upper value
 var model = ProfileModel().obs;
  @override
  onInit() async {
    profileApiFunction();
    super.onInit();
  }

  profileApiFunction() async {
    final response = await ApiConstants.getWithToken(url: ApiUrls.getExpertProfileDetail, useAuthToken: true);
    if (response != null && response['success'] == true) {
      print(response['data']);
      model.value = ProfileModel.fromJson(response);
      }
  }

}
