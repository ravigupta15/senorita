import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/controller/expert_wallet_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_wallet_screen/expert_wallet.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/profile.dart';
import 'package:senorita/UserApp/BottomMenuScreen/wallet_screen/wallet.dart';
import 'package:senorita/utils/toast.dart';
import 'package:senorita/utils/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../UserApp/category_details_screen/model/offers_list_model.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../addOffers/addOffersScreen.dart';
import '../../addOffers/controller/addOffersController.dart';
import '../../expert_edit_profile_screen/models/edit_categorymodel.dart';
import '../../expert_home_screen/expert_homescreen.dart';
import '../../expert_profile_screen/controller/expert_profile_controller.dart';
import '../../expert_profile_screen/expert_profile.dart';
import 'package:http/http.dart' as http;

import '../model/transaction_model.dart';


class ExpertDashboardController extends GetxController {
  final AddOfferController offerController = Get.put(AddOfferController());
  final ExpertWalletController expertWalletController = Get.put(ExpertWalletController());
  final ExpertProfileController expertProfileController = Get.put(ExpertProfileController());
 final selectIndex=0.obs;
 final expertName="".obs;
 final expertProfileImage="".obs;

  var isSwitched = true.obs;

  String Id="";
 String token = "";


 //Home Screen Data
 //var isSwitched = false.obs;
 final allCallData = [].obs;
 final isLoading = false.obs;
 String profile="";
  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  final perPage = 8.obs;

  ///Transaction List
  final allTransactionList = [].obs;
  final onlineOffline="".obs;

  ///Points
  final totalPoints="".obs;


  ///Detail data
  final name = "".obs;
  final image = "".obs;
  final experience = "".obs;
  final location = "".obs;
  final expertise = "".obs;
  final categoryName = "".obs;
  final status = "".obs;
  final bio = "".obs;
  final email = "".obs;
  final distance = "".obs;
  final categoryString = "".obs;
  final mobile = "".obs;
  final kodagoCard = "".obs;
  final subCategoryList = [].obs;
  final subCategoryIdList = [].obs;
  final subCategoryNameList = [].obs;


  ///Bottom Nav Bar
  final screens=[
    const ExpertHomeScreen(),
    const AddOfferScreen(),
    const ExpertWalletScreen(),
    ExpertProfile(),
  ];

  void toggleSwitch() {
    isSwitched.value = !isSwitched.value;
  }


  final selectedIndex = 0.obs;

  void changeIndex(int index){
    selectedIndex.value = index;

    index==3?expertProfileController.profileApiFunction():index==0?expertProfileApiFunction():
    SizedBox();
  }

  @override
  Future<void> onInit() async {
    expertProfileApiFunction();
    expertProfileController.profileApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //profileApiFunction("");
    token = prefs.getString("token").toString();
   // allTransactionApiFunction();
    super.onInit();

  }

  onlineStatusFunction() async {
    final response = await ApiConstants.getWithToken(url: ApiUrls.getExpertStatus, useAuthToken: true);
    if (response != null && response['success'] == true) {
      print(response['data']);
      status.value=response['data']['status'] ?? "";
    }
  }


  expertProfileApiFunction() async {
    try{
      final result = await InternetAddress.lookup('example.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        {
          subCategoryList.clear();
          subCategoryNameList.clear();
          subCategoryIdList.clear();

          //showCircleProgressDialog(Get.context!);
          final response = await ApiConstants.getWithToken(url: "${ApiUrls.getExpertProfileDetail}", useAuthToken: true);
          // isLoading.value = true;
          if (response != null && response['success'] == true) {
            //  Get.back();

            expertName.value=response['data']['name'] ?? "";
            expertProfileImage.value=response['data']['image_url'] ?? "";
            name.value=response['data']['name'] ?? "";
            status.value=response['data']['status'].toString() ?? "";
            print( status.value.toString());
           // showToast(status.value.toString());
            isSwitched.value=status.value=='0'?false:true;
            location.value=response['data']['address']??"";
            kodagoCard.value=response['data']['expert_details']['kodago_card_url'];
            bio.value=response['data']['expert_details']['about']?? "";
            experience.value=response['data']['expert_details']['experience']?? "";

            image.value=response['data']['image_url'] ?? "";
            location.value=response['data']['address']??"";
            categoryString.value=response['data']['expert_details']['category']['name'].toString();
            for (int i = 0; i < response['data']['expert_sub_category'].length; i++) {
              EditSubCategoryModel model = EditSubCategoryModel(
                  response['data']['expert_sub_category'][i]['sub_category_details']['id'].toString(),
                  response['data']['expert_sub_category'][i]['sub_category_details']['name'].toString()

              );
              subCategoryIdList.add(model.id);
              subCategoryNameList.add(model.name);
              subCategoryList.add(model);
            }
          }
          else
          {
            response['message'].toString();
          }
        }else{
        internetSnackbar();
      }
    }
    catch(e)
    {

    }

  }


  allTransactionApiFunction() async {
    page.value=1;
    showCircleProgressDialog(Get.context!);
    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.updateExpertHome));
    request.fields.addAll({
      'page_numbar': page.value.toString(),
    });
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    isLoading.value = true;
    var response = await http.Response.fromStream(streamedResponse);
    log(response.body);
    Get.back();
    isLoading.value = false;
    allTransactionList.clear();
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result['success'] == true && result['success'] != null) {
        totalPoints.value= result['wallat']['totalBlance'].toString();
        for (int i = 0; i < result['credithistory'].length; i++) {
          TransactionModel model = TransactionModel(
            result['credithistory'][i]['id'].toString()??"",
            result['credithistory'][i]['payer_name'].toString()??"",
            result['credithistory'][i]['points'].toString()??"",
            result['credithistory'][i]['remark'].toString()??"",
            result['credithistory'][i]['txn_status'].toString()??"",
            result['credithistory'][i]['created_at'].toString()??"",

          );
          allTransactionList.add(model);
        }
        count.value=result['total_count'];
        // showToast(count.toString());
      }
    }
  }

  allTransactionPaginationApiFunction() async {
    if(isLoadMoreRunning.value==false){
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false
      ) {
        if (count.value>allTransactionList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer' + token};
          var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.updateExpertHome));
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
                TransactionModel model = TransactionModel(
                  result['credithistory'][i]['id'].toString()??"",
                  result['credithistory'][i]['payer_name'].toString()??"",
                  result['credithistory'][i]['points'].toString()??"",
                  result['credithistory'][i]['remark'].toString()??"",
                  result['credithistory'][i]['txn_status'].toString()??"",
                  result['credithistory'][i]['created_at'].toString()??"",

                );
                allTransactionList.add(model);
              }
              isLoadMoreRunning.value=false;
            }
          }
        }
      }}
  }

  expertUpdateApiFunction(BuildContext context) async {
   showCircleProgressDialog(context);
   final response =
   await ApiConstants.getWithToken(url:  "${ApiUrls.updateExpertStatus}", useAuthToken: true);
   if (response != null && response['success'] == true) {
     Navigator.of(context).pop();
     response['data'].toString();
     toggleSwitch();
   }
   else
   {
     Navigator.of(context).pop();
   }
 }

  logout() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.remove("isLogin");
   prefs.remove("userIsLogin");
   prefs.remove("expertIsLogin");

   Get.offAllNamed(AppRoutes.loginScreen);
 }
}
