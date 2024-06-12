import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLocationController extends GetxController{

  final isShowAddressDropDownItem = false.obs;
  final searchController = TextEditingController();

  final recentAddress = ''.obs;
  final recentSubLocality = ''.obs;

  @override
  void onInit() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    recentAddress.value= prefs.getString('recentAddress')??'';
    recentSubLocality.value = prefs.getString('recentSubLocality')??'';
    // TODO: implement onInit
    super.onInit();
  }

  final suggestionList = [].obs;
  Future<void> searchAddress(String input) async {
     String apiKey = 'AIzaSyBSc7xDt-OoXTcYb3IjIcsAmns-RhuofL4'; // Replace with your API key
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    log(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // setState(() {
        suggestionList.value = data['predictions'];
            // .map<String>((prediction) => prediction['description'])
            // .toList();
      // });
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

}