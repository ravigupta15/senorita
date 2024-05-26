import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import '../../expert_registration_screen/googleMap/googleMapScreen.dart';
import '../../expert_registration_screen/models/category_model.dart';
import '../../expert_registration_screen/models/city_model.dart';
import 'controller/expert_edit_profile_controller.dart';

class ExpertEditProfileScreen extends GetView<ExpertEditProfileController> {
  const ExpertEditProfileScreen({key});

  @override
  Widget build(BuildContext context) {
    // controller.getSubCategoryApiFunction(context, controller.categoryId.value);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: appBar(context, "Personal Information", () {
          Get.back();
        }),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: controller.userFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenSize.height(10),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Column(
                          children: [
                            _buildUploadImage(context),
                            const SizedBox(
                              height: 15,
                            ),
                            _buildExpertInfo(context)
                          ],
                        ),
                      ),
                      ScreenSize.height(15),
                      CustomBtn(
                          title: "Save",
                          height: 50,
                          width: double.infinity,
                          color: ColorConstant.onBoardingBack,
                          onTap: () {
                            if (controller.userFormKey.currentState!
                                .validate()) {
                              controller.submitExpertProfileApi(context)
                                  .then((value) {

                                return null;
                              });
                            } else {
                              print(" not validate");
                            }
                          }),
                      ScreenSize.height(15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Profile Detail Widget
  Widget _buildUploadImage(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.imgProfileBack,
                  ),
                  fit: BoxFit.fill,
                )),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        border: Border.all(
                          width: 5,
                          color: Colors.black45.withOpacity(0.1),
                        )),
                    child: Stack(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.showImagePicker(context);
                            },
                            child: Container(
                              height: SizeConfig.screenHeightConstant * 7,
                              width: SizeConfig.screenHeightConstant * 7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0, color: Colors.white),
                                shape: BoxShape.circle,
                              ),
                              child: controller.imgUrl.value.isEmpty &&
                                      controller.imgFile.value == null
                                  ? Image.asset(
                                      AppImages.profileImg,
                                    )
                                  : controller.imgFile.value != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(
                                                controller.imgFile.value!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                            controller.imgUrl.value,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 15,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage,
                          Permission.camera,
                        ].request();
                        if (statuses[Permission.storage]!.isGranted &&
                            statuses[Permission.camera]!.isGranted) {
                          controller.showImagePicker(context);
                        } else {
                          print('no permission provided');
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          controller.showImagePicker(context);
                        },
                        child: Container(
                          child: SizedBox(
                              width: SizeConfig.screenHeightConstant * 5,
                              height: SizeConfig.screenHeightConstant * 5,
                              child: Image.asset(
                                AppImages.edit,
                              )),
                        ),
                      ),
                    )),
              ],
            )),
      ],
    );
  }

  /// Profile Detail Widget
  Widget _buildExpertInfo(BuildContext context) {
    return Column(
      children: [
        ///Name Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: registerFullName,
            auto: AutovalidateMode.onUserInteraction,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: controller.fullNameController,
            validator: (value) {
              if (value == null || value == "") {
                return "Please enter FullName";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),

        ///Number Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: registerMobileNumber,
            auto: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            isReadOnly: true,
            inputFormatters: [
              new LengthLimitingTextInputFormatter(10),
            ],
            controller: controller.numberController,
            validator: (value) {
              if (value == null ||
                  value.length != 10 ||
                  (!isValidPhone(value, isRequired: true))) {
                return "Mobile Number must be of 10 digit";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),

        ///Email Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: registerEmailAddress,
            auto: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            isReadOnly: true,
            controller: controller.emailController,
            validator: (value) {
              if (value == null || (!isValidEmail(value, isRequired: true))) {
                return "Please enter valid email";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),

        ///Current Location Data Widget
        Obx(
          () => GestureDetector(
            onTap: () {
             /* if (controller.latString.value != "null" || controller.lngString.value != "null") {
                Get.toNamed(AppRoutes.editMap,arguments: [
                  controller.latDouble,
                  controller.lngDouble,
                  controller.addressString.value.toString()]);
              } else {
                Get.toNamed(AppRoutes.editMap,arguments: [
                  null,null,null]);
              }*/
            },
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorConstant.addMoney,
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 10,right: 10,top: 0, bottom: 3),
                child: Row(
                  children: [
                    /*Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        child: getText(
                            title: controller.addressString.value == ""
                                ? "Select Location"
                                : controller.addressString.value,
                            textAlign: TextAlign.start,
                            size: 15,
                            fontFamily: interRegular,
                            color: ColorConstant.black2,
                            fontWeight: FontWeight.w500),
                      ),
                    ),*/
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      child: Text(
                        controller.addressString.value == ""
                            ? "Select Location"
                            : controller.addressString.value,
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: interRegular,
                            color: ColorConstant.qrViewText,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                        size: 20,
                        color: ColorConstant.blackLight,
                        Icons.my_location)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        //Category
        Obx(
          () => GestureDetector(
            onTap: () {
              categoryDialogBox(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorConstant.addMoney,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: getText(
                          title: controller.categoryString.value == ""
                              ? registerCategory
                              : controller.categoryString.value,
                          textAlign: TextAlign.start,
                          size: 14,
                          fontFamily: interRegular,
                          color: ColorConstant.qrViewText,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      height: 8,
                      width: 8,
                      AppImages.arrowRegister,
                    ),
                    /*Icon(
                                              Icons.arrow_back_ios_rounded)*/
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),

        ///SubCategory
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            /*controller.categoryString.value == ""?showToast("Select Category First")
                :subCategory(context);*/
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorConstant.addMoney,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: ()
                      {
                        subCategory(context);
                      },
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                              child: getText(
                                  title: registerSubCategory,
                                  textAlign: TextAlign.start,
                                  size: 14,
                                  fontFamily: interRegular,
                                  color: ColorConstant.qrViewText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              height: 8,
                              width: 8,
                              AppImages.arrowRegister,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Obx(
                      () => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.subCategoryNameList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 20, top: 5),
                              child: Row(
                                children: [
                                  getText(
                                      title:
                                          controller.subCategoryNameList[index],
                                      size: 13,
                                      fontFamily: interRegular,
                                      color: ColorConstant.qrViewText,
                                      fontWeight: FontWeight.w400),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      controller.subCategoryNameList.removeAt(index);
                                      controller.subCategoryIdList.removeAt(index);
                                  //    model.id.toString()

                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.highlight_remove_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        ScreenSize.height(15),

        ///Exp Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: registerExperience,
            auto: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            controller: controller.expController,
            inputFormatters: [
              new LengthLimitingTextInputFormatter(2),
            ],
            textInputType: TextInputType.number,
            validator: (value) {
              if (value.toString().isEmpty) {
                return "Please enter Experience";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),

        ///Kodago Card Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: "Kodago Card(URL:-https://card.kodago.com/username)",
            auto: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            controller: controller.kodagoCardController,
            validator: (value) {
              if (value == null || (!kodagoCard(value, isRequired: true))) {
                return "Please enter Kodago Card (URL)";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),

        ///aboutUs Data Widget
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CustomTextField(
            hintText: "",
            labelText: registerAboutUs,
            auto: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            controller: controller.aboutUsController,
            validator: (value) {
              if (value.toString().isEmpty) {
                return "Please enter AboutUs";
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 0),
      ],
    );
  }

  categoryDialogBox(BuildContext context) {
    controller.getCategoryApiFunction();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, bottom: 5, top: 10),
                    child: Row(
                      children: [
                        getText(
                            title: "Category",
                            size: 14,
                            fontFamily: interRegular,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: ColorConstant.onBoardingBack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: ColorConstant.dividerColor,
                    height: 1,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            left: 15, right: 10, bottom: 15, top: 10),
                        itemCount: controller.allCategoryList.length,
                        itemBuilder: (context, index) {
                          CategoryModel model = CategoryModel.fromJson(
                              controller.allCategoryList[index]);

                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.selectedCategoryType.value = index;
                                    controller.categoryString.value = model.name.toString();
                                    controller.categoryId.value = model.id.toString();
                                    controller.getSubCategoryApiFunction(model.id.toString());
                                    controller.subCategoryNameList.clear();
                                    // Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      controller.selectedCategoryType.value ==
                                              index
                                          ? const Icon(
                                              Icons.radio_button_checked,
                                        size: 20,
                                              color:
                                                  ColorConstant.onBoardingBack,
                                            )
                                          : const Icon(
                                              Icons.radio_button_off_outlined,
                                        color: ColorConstant.greyColor,
                                        size: 20,
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(model.name.toString(),
                                        style: const TextStyle(
                                          color: ColorConstant.greyColor,
                                          fontSize: 14,
                                          fontFamily: interRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: getText(
                              title: "Cancel",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller.selectedCategoryType.value == -1
                                ? showToast("Please Select Category")
                                : Navigator.pop(context);
                          },
                          child: getText(
                              title: "Ok",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        });
  }


  subCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 10, bottom: 5, top: 10),
                    child: Row(
                      children: [
                        getText(
                            title: "Sub Category",
                            size: 14,
                            fontFamily: interRegular,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                        const Spacer(),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: ColorConstant.onBoardingBack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: ColorConstant.dividerColor,
                    height: 1,
                  ),
                  Obx(
                        () => Container(
                      width: double.maxFinite,
                      height: 300,
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.subCategoryList.length,
                          itemBuilder: (context, index) {
                            SubCategoryModel model =
                            SubCategoryModel.fromJson(controller.subCategoryList[index]);
                            return Column(
                              children: [
                                Obx(() => GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                     /* // controller.subCategoryNameList.add(model.name.toString());
                                      // controller.subCategoryIdList.add(model.id.toString());
                                      if (controller.subCategoryNameList.contains(model.name.toString())) {
                                        controller.subCategoryNameList.removeAt(index);
                                        controller.subCategoryList..removeAt(index);
                                        controller.subCategoryIdList.removeAt(index);
                                        state;
                                      }
                                      else {
                                        controller.subCategoryNameList.add(model.name.toString());
                                        controller.subCategoryIdList.add(model.id.toString());
                                      }
*/
                                      bool isContains = false;
                                      for (int i = 0;
                                      i <
                                          controller.subCategoryNameList
                                              .length;
                                      i++) {
                                        print(controller
                                            .subCategoryNameList[i]);
                                        if (controller
                                            .subCategoryNameList[i] ==
                                            model.name) {
                                          isContains = true;
                                          print(
                                              "if...${controller.subCategoryNameList[i]}");
                                          controller.subCategoryNameList
                                              .removeAt(i);
                                          controller.subCategoryIdList
                                              .removeAt(i);

                                          break;
                                        }
                                      }

                                      if (!isContains) {
                                        controller.subCategoryNameList
                                            .add(model.name.toString());
                                        controller.subCategoryIdList
                                            .add(model.id.toString());
                                      }

                                    },
                                    child: /*ListTile(
                                      title:  Text(model.name.toString(),
                                        style: const TextStyle(
                                          color: ColorConstant.greyColor,
                                          fontSize: 13,
                                          fontFamily: interRegular,
                                        ),
                                      ),
                                      trailing: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                          border: Border.all(
                                            color: controller.subCategoryNameList
                                                .contains(model.name
                                                .toString())
                                                ? Colors.blue
                                                : Colors.grey.shade500,
                                          ),
                                          color: controller.subCategoryNameList
                                              .contains(
                                              model.name.toString())
                                              ? Colors.blue
                                              : Colors.white,
                                        ),
                                        child: controller.subCategoryNameList
                                            .contains(
                                            model.name.toString())
                                            ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                            : null,
                                      ),
                                    )*/
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                      child: Row(
                                        children: [
                                          Text(model.name.toString(),
                                            style: const TextStyle(
                                              color: ColorConstant.greyColor,
                                              fontSize: 13,
                                              fontFamily: interRegular,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(2),
                                              border: Border.all(
                                                color: controller.subCategoryNameList.contains(model.name.toString())
                                                    ? Colors.blue
                                                    : Colors.grey.shade500,
                                              ),
                                              color: controller.subCategoryNameList.contains(model.name.toString())
                                                  ? Colors.blue
                                                  : Colors.white,
                                            ),
                                            child: controller.subCategoryNameList.contains(model.name.toString())
                                                ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 13,
                                            )
                                                : null,
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left:15,right:10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: ColorConstant.dividerColor,
                                    height: 1,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: getText(
                              title: "Cancel",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller.selectedSubCategoryType.value == ""
                                ? showToast("Please Select Category")
                                : Navigator.pop(context);
                          },
                          child: getText(
                              title: "Ok",
                              size: 14,
                              fontFamily: interRegular,
                              color: ColorConstant.onBoardingBack,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          );
        });
  }


  multiSelectDialogBox(BuildContext context, list, model) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, top: 10, bottom: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: model.valueList.isEmpty
                          ? Container()
                          : GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                model.valueList.clear();
                                for (int i = 0; i < list.length; i++) {
                                  list[i]['name'] = false;
                                  state(() {});
                                }
                              },
                              child: const Icon(Icons.close)),
                    ),
                  ),
                  ListView.separated(
                      separatorBuilder: (context, sp) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      itemCount: controller.allCategoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            if (list[index]['isSelected'] == false) {
                              list[index]['isSelected'] = true;
                              model.valueList.add(list[index]['value']);
                            } else {
                              list[index]['isSelected'] = false;
                              for (int i = 0; i < model.valueList.length; i++) {
                                if (list[index]['value']
                                        .toString()
                                        .removeAllWhitespace ==
                                    model.valueList[i]
                                        .toString()
                                        .removeAllWhitespace) {
                                  model.valueList.removeAt(i);
                                }
                              }
                            }
                            state(() {});
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(list[index]['value'].toString()),
                                checkBox(index, list[index]['isSelected'])
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }),
          );
        });
  }

  checkBox(int index, isSelected) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
              color: index == isSelected ? Colors.blue : Colors.grey.shade500),
          color: isSelected ? Colors.blue : Colors.white),
      alignment: Alignment.center,
      child: index == isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            )
          : null,
    );
  }
}
