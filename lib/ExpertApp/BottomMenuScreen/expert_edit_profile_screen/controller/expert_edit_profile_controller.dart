import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_edit_profile_screen/models/edit_categorymodel.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../api_config/ApiConstant.dart';
import '../../../../api_config/Api_Url.dart';
import '../../../../helper/getText.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/showcircledialogbox.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/stringConstants.dart';
import '../../../../utils/toast.dart';
import '../../../../widget/error_box.dart';
import '../../expert_dashboard_screen/controller/dashboard_controller.dart';
import '../../expert_profile_screen/controller/expert_profile_controller.dart';

class ExpertEditProfileController extends GetxController {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  ///Address
  final addressString = "".obs;
  final cityString = "".obs;
  final stateString = "".obs;
  final latString = "".obs;
  final lngString = "".obs;

  final chargeController = TextEditingController();
  final bioController = TextEditingController();
  final kodagoCardController = TextEditingController();
  final experienceController = TextEditingController();

  final expController = TextEditingController();

  final aboutUsController = TextEditingController();


  ExpertDashboardController dashboardController=ExpertDashboardController();

  final userFormKey = GlobalKey<FormState>();
  final checkBoxValue = false.obs;
  final passwordVisible = true.obs;
  final termsConditionValue = 0.obs;
  final isLoading = false.obs;
  var mobile = "";
  var email = "";
  final expertProfileImage="".obs;

  ///Country data
  RxInt selectedCountryType = (-1).obs;
  final countryString = "".obs;
  final allCountryList = [].obs;
  final countryId = "".obs;

  ///State data
  RxInt selectedStateType = (-1).obs;
  final stateId = "".obs;
  final allStateList = [].obs;

  ///City data
  RxInt selectedCityType = (-1).obs;

  final cityId = "".obs;
  final allCityList = [].obs;
  final selectCityId = "".obs;

  ///Category data
  final selectedCategoryType = 0.obs;
  final categoryString = "".obs;
  final categoryId = "".obs;
  final allCategoryList = [].obs;
  final selectCategoryId = "".obs;

  ///Image Picker
  final imgFile = Rx<File?>(null);
  final imgUrl = ''.obs;


  // search
  final isNotMatchCity = false.obs;
  final searchList = [].obs;
  final dropdownDataList = [].obs;
  final allData = [].obs;
  var isChecked = false.obs;
  String Id="";
  String expertId="";
  final oneValue = ''.obs;

  ///DropDown
  final countrySharedPrf = ''.obs;
  String token="";



  ///SubCategory data
  RxInt selectedSubCategoryType = (-1).obs;
  final subCategoryString = "".obs;
  final subCategoryId =  "".obs;
  final subCategoryList = [].obs;
  final subCategoryIdList = [].obs;
  final subCategoryNameList = [].obs;



  final ne = [].obs;

  final subCategoryName = "".obs;
  ExpertProfileController expertProfileController=ExpertProfileController();

  var latDouble=0.0;
  var lngDouble=0.0;

  @override
  void onInit() async{
    SizeConfig().init();

    addressString.value = Get.parameters['address'] ?? 'Current Address';
    cityString.value = Get.parameters['city'].toString() ?? '';
    stateString.value = Get.parameters['state'].toString() ?? '';
    latString.value = Get.parameters['currentLat'].toString() ?? '' ;
    lngString.value = Get.parameters['currentLong'].toString() ?? '' ;


  //  showToast(addressString.value);

    if(latString.value!="null" || lngString.value!="null")
    {
      latDouble =double.parse(latString.value);
      lngDouble =double.parse(lngString.value);
    }
    else
    {

    }

    /*if(addressString.value=='Current Address')
      {
        getCityApiFunction();
        getCategoryApiFunction();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Id=prefs.getString("id").toString();
        expertId=prefs.getString("expert_id").toString();
        token=prefs.getString("token").toString();
        expertProfileApiFunction();
      }*/
    getCityApiFunction();
    getCategoryApiFunction();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Id=prefs.getString("id").toString();
    expertId=prefs.getString("expert_id").toString();
    token=prefs.getString("token").toString();
    expertProfileApiFunction();



    super.onInit();
  }

  void resetValues() {
    fullNameController.clear();
    emailController.clear();
    numberController.clear();
    expController.clear();


  }


  final picker = ImagePicker();


  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        builder: (builder) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))
                  //set border radius more than 50% of height and width to make circle
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.camera_alt, Colors.pink, "Camera")),
                          GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: iconcreation(
                                  Icons.insert_photo, Colors.purple, "Gallery"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        getText(
            title: text,
            size: 14,
            fontFamily: celiaRegular,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      //imgUrl.value = pickedImage.path;
      imgFile.value=File(pickedImage.path);
      print(imgFile);
    } else {
      showToast("Error No image selected");
    }
  }


  validation() async {
    if (userFormKey.currentState!.validate()) {
      //loginApiFunction();
    }
  }

  expertProfileApiFunction() async {
    showCircleProgressDialog(Get.context!);
    final response = await ApiConstants.getWithToken(url: "${ApiUrls.getExpertProfileDetail}", useAuthToken: true);
    isLoading.value = true;
    if (response != null && response['success'] == true) {
      Get.back();
      imgUrl.value=response['data']['image_url']??'';
      fullNameController.text=response['data']['name'].toString();
      numberController.text=response['data']['mobile'].toString();
      emailController.text=response['data']['email'].toString();

      Get.parameters['address']!=null?
      addressString.value:addressString.value=response['data']['address'].toString();

      cityString.value=response['data']['city'].toString();
      stateString.value=response['data']['state'].toString();
      latString.value=response['data']['lat'].toString();
      lngString.value=response['data']['lng'].toString();

      categoryString.value=response['data']['expert_details']['category']['name'].toString();
      selectedCategoryType.value=response['data']['expert_details']['category']['id']-1;
      categoryId.value=response['data']['expert_details']['category']['id'].toString();
      getSubCategoryApiFunction(categoryId.value.toString());
      for (int i = 0; i < response['data']['expert_sub_category'].length; i++) {
        EditSubCategoryModel model = EditSubCategoryModel(
          response['data']['expert_sub_category'][i]['sub_category_details']['id'].toString(),
          response['data']['expert_sub_category'][i]['sub_category_details']['name'].toString()

        );
        subCategoryIdList.add(model.id);
        subCategoryNameList.add(model.name);
        subCategoryList.add(model);
      }
      expController.text=response['data']['expert_details']['experience'].toString();
      kodagoCardController.text=response['data']['expert_details']['kodago_card_url'].toString();
      aboutUsController.text=response['data']['expert_details']['about'].toString();
    }
    else
    {
      response['message'].toString();
    }
  }



  submitExpertProfileApi(BuildContext context) async {
    showCircleProgressDialog(Get.context!);
    print("vbdfb${imgUrl.value}");
    isLoading.value = true;
    var headers = {
      'Authorization': 'Bearer'+token
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.updateExpertProfileDetail,));
    var stringSubCategory=subCategoryIdList.join(",");
    request.fields.addAll({
      'name': fullNameController.text.toString(),
      'mobile': numberController.text.toString(),
      'email': emailController.text.toString(),
      'address': addressString.toString(),
      'city': cityString.toString(),
      'state': stateString.toString(),
      'lat': latString.toString(),
      'lng': lngString.toString(),
      'category_id': categoryId.toString(),
      'sub_categories': stringSubCategory.toString(),
      'experience': expController.text.toString(),
      'kodago_card_url': kodagoCardController.text.toString(),
      'about': aboutUsController.text.toString(),
      'device_token': "dJuWepgXRnK-orOuvSS0Be:APA91bEW6fLfWOAaOu8bqRekvCjEfgjGHL0xffPpZSSQSNfZD5"
          "HfV_4KHzJdIss6dy0UAtdjD-N8_MlhmZcFMJNbdVjrOtxbZWTi47ig3To0nA0NpQfmSnPwQlmP64xNpNklyWRSmPCB",
    });
    request.headers.addAll(headers);

    if (imgFile.value==null) {
      
    }
    else {
      final file = await http.MultipartFile.fromPath('profile_picture', imgFile.value!.path);
      request.files.add(file);
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.back();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {
        showToast(result["message"].toString());
        Get.back();
        Get.offAllNamed(AppRoutes.expertDashboardScreen);
      }
      else
      {
        showErrorMessageDialog(context, result["message"].toString());
      }
    }
  }

  getCityApiFunction() async {
    final response = await ApiConstants.get(
        url: ApiUrls.cityApiUrl + "/" + "all");
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCityList.value = response['data'];
      }
    }
  }
  getCategoryApiFunction() async {
    final response = await ApiConstants.get(url: ApiUrls.expertCategoriesApiUrl);
    if (response["success"] == true) {
      if (response['data'] != null) {
        allCategoryList.value = response['data'];
      }
    }
    //showToast(response["message"]);
  }
  getSubCategoryApiFunction(id) async {
    //showCircleProgressDialog(context);
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.expertSubCategoriesApiUrl));
    request.fields.addAll({
      'category': id,
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
   //   Navigator.of(context).pop();
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      if (result["success"] == true) {

        subCategoryList.value = result['data'];

      }
      else
      {
       // showErrorMessageDialog(result["message"].toString());
      }
    }
  }
}
