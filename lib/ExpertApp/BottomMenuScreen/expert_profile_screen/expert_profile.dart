import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/menu_priceList/controller/menuPriceListcontroller.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import 'controller/expert_profile_controller.dart';

class ExpertProfile extends GetWidget<ExpertProfileController> {
  const ExpertProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: /*appBar(context, "Profile", () {
          Get.back();
        }),*/
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 30,
          title: getText(
              title: "Profile",
              size: 17,
              fontFamily: interSemiBold,
              letterSpacing: 0.7,
              color: ColorConstant.blackColor,
              fontWeight: FontWeight.w400),
          centerTitle: true,
        ),

        //backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
        body: SingleChildScrollView(

          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.white, ColorConstant.screenBack],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [_buildUserDetails(), _buildOtherMenuOption(context)],
            ),
          ),
        ),
      ),
    );
  }

  /// Profile Detail Widget
  Widget _buildUserDetails() {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 190,
                width: 190,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.imgProfileBack,
                      ),
                      fit: BoxFit.fill,
                    )),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        border: Border.all(
                          width: 5,
                          color: Colors.black26.withOpacity(0.04),
                        )),
                    child: /*ClipOval(
                      child: Image.asset(
                        height: 100,
                        width: 100,
                        AppImages.photoTwo,
                        fit: BoxFit.cover,
                      ),
                    ),*/
                        Obx(()=>
                          controller.profile.value.isEmpty
                              ? ClipOval(
                                  child: Image.asset(
                                    height: 100,
                                    width: 100,
                                    AppImages.photoTwo,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: CachedNetworkImage(
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                    imageUrl: controller.profile.value.toString(),
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => new Icon(Icons.person),
                                   /* height: 100,
                                    width: 100,
                                    controller.profile.value.toString(),
                                    fit: BoxFit.cover,*/
                                  ),
                                ),
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Obx(
                () => Center(
                  child: getText(
                      title: controller.name.value.toString(),
                      size: 18,
                      fontFamily: interSemiBold,
                      color: ColorConstant.blackColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => Center(
                  child: getText(
                      title: controller.mobile.value.toString(),
                      size: 13,
                      fontFamily: interRegular,
                      color: ColorConstant.greyColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  /// Other Menu Option Widget
  Widget _buildOtherMenuOption(BuildContext context) {
    DashboardController dashboardController = DashboardController();

    return SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))
            //set border radius more than 50% of height and width to make circle
            ),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(AppRoutes.expertEditProfileScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
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
                Get.toNamed(AppRoutes.addPhotos);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
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
                                  height: 20,
                                  width: 20,
                                  AppImages.profilePhotos,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Center(
                                child: getText(
                                    title: "Photos",
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
                final menuPriceController = Get.put(MenuPriceListController());
                menuPriceController.expertId.value = controller.expertId.value;
                Get.toNamed(AppRoutes.menuPriceList);
                print(controller.expertId.value);
                menuPriceController.onInit();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
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
                                    title: "Menu & Price List",
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
              onTap: ()
              {
                Get.toNamed(AppRoutes.helpSupportScreen,
                    arguments: ['termsCondition', ""]);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
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
              behavior: HitTestBehavior.opaque,
              onTap: ()
              {
                Get.toNamed(AppRoutes.helpSupportScreen,
                    arguments: ['helpSupport', ""]);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
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
              behavior: HitTestBehavior.opaque,
              onTap: () {
                userLogoutDialogBox(context, dashboardController);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: 'Logout',
                          size: 18,
                          fontFamily: celiaRegular,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(15),
                      getText(
                          title: 'Are you sure want to logout?',
                          size: 15,
                          fontFamily: celiaRegular,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w400),
                      ScreenSize.height(30),
                      Row(
                        children: [
                          Flexible(
                              child: CustomBtn(
                                  title: 'No',
                                  height: 44,
                                  width: 100,
                                  color: ColorConstant.onBoardingBack,
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
