import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/logoutdialogbox_user.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/profile_controller.dart';

class Profile extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = DashboardController();

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Center(
                    child: getText(
                        title: "Profile ",
                        size: 18,
                        fontFamily: interSemiBold,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Obx(
                    () => Center(
                      child: getText(
                          title: controller.name.value.toString(),
                          size: 16,
                          fontFamily: interSemiBold,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Center(
                      child: getText(
                          title: controller.mobile.value.toString(),
                          size: 14,
                          fontFamily: interRegular,
                          color: ColorConstant.blackLight,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))
                      //set border radius more than 50% of height and width to make circle
                      ),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.toNamed(AppRoutes.editProfile)?.then((value) {
                            controller.onInit();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Image.asset(
                                            height: 28,
                                            width: 28,
                                            AppImages.profileUsers,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: getText(
                                              title: "Personal Information",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Center(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.arrow,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 30,
                                color: ColorConstant.dividerColor,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.toNamed(AppRoutes.walletScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Image.asset(
                                            height: 28,
                                            width: 28,
                                            AppImages.profileWallet,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: getText(
                                              title: "Wallet",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Center(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.arrow,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 30,
                                color: ColorConstant.dividerColor,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.helpSupportScreen,
                              arguments: ['termsCondition', ""]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Image.asset(
                                            height: 28,
                                            width: 28,
                                            AppImages.profileTerms,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: getText(
                                              title: "Terms & Condition",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Center(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.arrow,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 30,
                                color: ColorConstant.dividerColor,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.helpSupportScreen,
                              arguments: ['helpSupport', ""]);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 12, right: 12, top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Image.asset(
                                            height: 28,
                                            width: 28,
                                            AppImages.profileHelp,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: getText(
                                              title: "Help & Support",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Center(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.arrow,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 30,
                                color: ColorConstant.dividerColor,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          userLogoutDialogBox(context, dashboardController);
                          // userLogoutDialogBox(context, dashboardController);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: Image.asset(
                                            height: 28,
                                            width: 28,
                                            AppImages.profileLogout,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Center(
                                          child: getText(
                                              title: "Logout",
                                              size: 13,
                                              fontFamily: interSemiBold,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Center(
                                      child: Image.asset(
                                        height: 20,
                                        width: 20,
                                        AppImages.arrow,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void userLogoutDialogBox(
    BuildContext context,
    DashboardController dashboardController,
  ) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getText(
                          title: 'Logout',
                          size: 18,
                          fontFamily: celiaRegular,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(10),
                      getText(
                          title: 'Are you sure want to logout?',
                          size: 13,
                          fontFamily: celiaRegular,
                          color: ColorConstant.greyColor,
                          fontWeight: FontWeight.w400),
                      ScreenSize.height(30),
                      Row(
                        children: [
                          Flexible(
                              child: CustomBtn(
                                  title: 'No',
                                  height: 44,
                                  width: 100,
                                  color: ColorConstant.c0Color,
                                  onTap: () {
                                    Get.back();
                                  })),
                          ScreenSize.width(15),
                          Flexible(
                              child: CustomBtn(
                                  title: 'Yes',
                                  height: 44,
                                  width: 100,
                                  color: ColorConstant.onBoardingBack,
                                  onTap: () {
                                    dashboardController.logout();
                                  })),
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
