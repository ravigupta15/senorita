import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:senorita/UserApp/BottomMenuScreen/all_category_screen/all_category_screen.dart';
import 'package:senorita/UserApp/BottomMenuScreen/all_category_screen/controller/all_category_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../CommonScreens/loginScreen/loginScreen.dart';
import '../../../../ScreenRoutes/routes.dart';
import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/toast.dart';
import '../../home_screen/homescreen.dart';
import '../../home_screen/model/home_model.dart';
import '../../offers_screen/controller/offers_controller.dart';
import '../../offers_screen/offers_screen.dart';
import '../../profile_screen/controller/profile_controller.dart';
import '../../profile_screen/profile.dart';

class OffersController extends GetxController {
  String token = "";
  final onlineExpertList = [].obs;
  final cityList = [].obs;
  final allOffersList = [].obs;

  ///Home Screen
  RxInt selectedAddressType = (-1).obs;
  final selectedCategoryId = "".obs;
  String categoryId = "";
  String profileBack = "";
  final allExpertList = [].obs;

  ///loading
  final isOnlineExpertLoading = false.obs;
  final isCityLoading = false.obs;
  final allSelected=false.obs;
  final cityName = "All".obs;
  final categoryList =[].obs;

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

  //search
  final searchList = [].obs;
  final isSearch = false.obs;

  final isCategoryLoading= false.obs;

  final latitude = "".obs;
  final longitude = "".obs;
  final listing_base_url = "".obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token").toString();
    latitude.value = prefs.getString("lat").toString();
    longitude.value = prefs.getString("long").toString();
    print("cuttentlatitudeOffer"+latitude.value.toString());
    print("cuttentlongitudeOffer"+longitude.value.toString());
    allOffersApiFunction(1);
    categoryApiFunction();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  allOffersApiFunction(int hasOffers) async {
    page.value=1;
    showCircleProgressDialog(Get.context!);
    isLoading.value = true;
    var headers = {'Authorization': 'Bearer' + token};
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));

    if (selectedCategoryId != "") {
      request.fields.addAll({
        'page_numbar': page.value.toString(),
        'has_offer':hasOffers.toString(),
        'lat':latitude.value.toString(),
        'lng':longitude.value.toString(),
        'category_id': selectedCategoryId.toString()
      });
      print({'page_numbar': page.value.toString(),
        'has_offer':hasOffers.toString(),
        'lat':latitude.value.toString(),
        'lng':longitude.value.toString(),
        'category_id': selectedCategoryId.toString()});
    } else {
      request.fields.addAll({
        'page_numbar': page.value.toString(),
        'has_offer':"1",
        'lat':latitude.value.toString(),
        'lng':longitude.value.toString(),
      });
    }
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse).timeout(const Duration(seconds: 60));
    log(response.body);
    Get.back();
    isLoading.value = false;
    allOffersList.clear();
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
          allOffersList.add(model);
        }
        count.value=result['total_count'];
      }
    }
    else
    {
      Get.back();
    }
  }

  allOffersPaginationApiFunction() async {
    if(isLoadMoreRunning.value==false){
      if (hasNextPage.value == true &&
          isFirstLoadRunning.value == false &&
          isLoadMoreRunning.value == false
      ) {
        if (count.value>allOffersList.length) {
          ++page.value;
          isLoadMoreRunning.value = true;
          var headers = {'Authorization': 'Bearer' + token};
          var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.getExperts));
          if (selectedCategoryId != "") {
            request.fields.addAll({
              'page_numbar': page.value.toString(),
              'has_offer':"1",
              'lat':latitude.value.toString(),
              'lng':longitude.value.toString(),
              'category_id': selectedCategoryId.toString()
            });
          } else {
            request.fields.addAll({
              'page_numbar': page.value.toString(),
              'has_offer':"1",
              'lat':latitude.value.toString(),
              'lng':longitude.value.toString(),
            });
          }
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
                allOffersList.add(model);
              }
              isLoadMoreRunning.value=false;
            }
          }
        }
      }}
  }

  categoryApiFunction() async {
    categoryList.clear();
    isCategoryLoading.value=true;
    final response = await ApiConstants.getWithToken(url: ApiUrls.expertCategoriesApiUrl, useAuthToken: true);
    if (response != null && response['success'] == true) {
      isCategoryLoading.value =false;
      if (response['data'] != null) {
        for (int i = 0; i < response['data'].length; i++) {
          print(response['data'],);
          PopularCategoryModel model = PopularCategoryModel(
              response['data'][i]['imageUrl'].toString(),
              response['data'][i]['name'].toString(),
              response['data'][i]['id'].toString());
          categoryList.add(model);
        }

      }
    }
  }

}
