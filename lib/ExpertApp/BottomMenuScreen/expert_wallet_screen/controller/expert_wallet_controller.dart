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
import '../../expert_dashboard_screen/model/transaction_model.dart';
import '../../expert_home_screen/model/expert_home_model.dart';
import '../model/wallet_model.dart';

class ExpertWalletController extends GetxController {
  String token = "";

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final perPage = 8.obs;

  ///Transaction List
  final allWalletList = [].obs;

  ///Points
  final totalPoints="".obs;

  final isLoading = false.obs;




  @override
  Future<void> onInit() async {
    SizeConfig().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    allWalletListApiFunction();
    super.onInit();
  }


  allWalletListApiFunction() async {
    page.value=1;

    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.walletExpert));
    request.fields.addAll({
      'page_numbar': page.value.toString(),
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    isLoading.value = true;
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    isLoading.value = false;
    allWalletList.clear();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        totalPoints.value= result['wallat']['totalBlance'].toString()??"";
        for (int i = 0; i < result['credithistory'].length; i++) {
          WalletTransactionModel model = WalletTransactionModel(
            result['credithistory'][i]['id'].toString()??"",
            result['credithistory'][i]['txn_id'].toString()??"",
            result['credithistory'][i]['payer_name'].toString()??"",
            result['credithistory'][i]['points'].toString()??"",
            result['credithistory'][i]['created_at'].toString()??"",

          );
          allWalletList.add(model);
        }
        count.value=result['total_count'];
        // showToast(count.toString());
      }
    }
  }

  allWalletListApiPaginationApiFunction() async {
    if(isLoadMoreRunning.value==false){
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false
      ) {
        if (count.value>allWalletList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer' + token};
          var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.walletExpert));
          request.fields.addAll({
            'page_numbar': page.value.toString(),
          });
          request.headers.addAll(headers);
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode == 200) {
            final result = jsonDecode(response.body) as Map<String, dynamic>;
            if (result['success'] == true && result['success'] != null) {
              for (int i = 0; i < result['credithistory'].length; i++) {
                WalletTransactionModel model = WalletTransactionModel(
                  result['credithistory'][i]['id'].toString()??"",
                  result['credithistory'][i]['txn_id'].toString()??"",
                  result['credithistory'][i]['payer_name'].toString()??"",
                  result['credithistory'][i]['points'].toString()??"",
                  result['credithistory'][i]['created_at'].toString()??"",

                );
                allWalletList.add(model);
              }
              isLoadMoreRunning.value=false;
            }
          }
        }
      }}
  }
}
