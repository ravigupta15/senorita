import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/model/user_special_offer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../home_screen/model/home_model.dart';

class OffersController extends GetxController {
  String token = "";
  List allOffersList = [];

  ///Home Screen
  final selectedCategoryId = "".obs;

  ///loading
  final isOnlineExpertLoading = false.obs;

  ///Pagination
  final count = 1.obs;
  final preventCall = false.obs;
  final page = 1.obs;
  final hasNextPage = true.obs;
  final isFirstLoadRunning = false.obs;
  final isLoadMoreRunning = false.obs;
  ScrollController? paginationController;
  final perPage = 10.obs;
  final isLoading = false.obs;

  //search
  final searchList = [].obs;
  final isSearch = false.obs;

  final isCategoryLoading = false.obs;

  final latitude = "".obs;
  final longitude = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    allOffersApiFunction(1);
    super.onInit();
  }

  allOffersApiFunction(int hasOffers) async {
    page.value = 1;
    showCircleProgressDialog(Get.context!);
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));

    if (selectedCategoryId != "") {
      request.fields.addAll({
        'page_numbar': page.value.toString(),
        'has_offer': hasOffers.toString(),
        'lat': latitude.value.toString(),
        'lng': longitude.value.toString(),
        'category_id': selectedCategoryId.toString()
      });
      print({
        'page_numbar': page.value.toString(),
        'has_offer': hasOffers.toString(),
        'lat': latitude.value.toString(),
        'lng': longitude.value.toString(),
        'category_id': selectedCategoryId.toString()
      });
    } else {
      request.fields.addAll({
        'page_numbar': page.value.toString(),
        'has_offer': "1",
        'lat': latitude.value.toString(),
        'lng': longitude.value.toString(),
      });
    }
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse)
        .timeout(const Duration(seconds: 60));
    log(response.body);
    Get.back();
    isLoading.value = false;
    allOffersList.clear();
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true && result['success'] != null) {
        for (int i = 0; i < result['data'].length; i++) {
          UserSpecialOfferModel model = UserSpecialOfferModel.fromJson(result['data'][i]);
          allOffersList.add(model);
        }
        count.value = result['total_count'];
      }
    } else {
    }
  }

  allOffersPaginationApiFunction() async {
    if (isLoadMoreRunning.value == false) {
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false) {
        if (count.value > allOffersList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer $token'};
          var request =
              http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
          if (selectedCategoryId != "") {
            request.fields.addAll({
              'page_numbar': page.value.toString(),
              'has_offer': "1",
              'lat': latitude.value.toString(),
              'lng': longitude.value.toString(),
              'category_id': selectedCategoryId.toString()
            });
          } else {
            request.fields.addAll({
              'page_numbar': page.value.toString(),
              'has_offer': "1",
              'lat': latitude.value.toString(),
              'lng': longitude.value.toString(),
            });
          }
          request.headers.addAll(headers);
          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode == 200) {
            final result = json.decode(response.body) ;
            if (result['success'] == true && result['success'] != null) {
              List list = [];
              for (int i = 0; i < result['data'].length; i++) {
                UserSpecialOfferModel model = UserSpecialOfferModel.fromJson(result['data'][i]);
                list.add(model);
              }
              allOffersList = allOffersList+list;
              isLoadMoreRunning.value = false;
            }
          }
        }
      }
    }
  }

}
