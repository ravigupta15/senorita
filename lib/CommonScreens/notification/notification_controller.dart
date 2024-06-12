import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';

import '../../api_config/ApiConstant.dart';
import '../../api_config/Api_Url.dart';

class NotificationController extends GetxController{

  @override
  void onInit() {
    print(Get.parameters['userId']);
    super.onInit();
  }

  callNotificationApiFunction()async{
    print('object');
    var body = {
      'user_id':Get.find<ProfileController>().model.value.data!.id.toString()
    };
    print(body);
    final response = await ApiConstants.post(url: ApiUrls.notificationUrl,body: body);

    if (response != null && response['success'] == true) {
      if (response!=null&& response['success']!=false&& response['data'] != null) {
        // categoryModel.value = ExpertCategorySubCatModel.fromJson(response);
      }
    }

  }
}