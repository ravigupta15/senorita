import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:senorita/UserApp/BottomMenuScreen/dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/UserApp/BottomMenuScreen/profile_screen/controller/profile_controller.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../../helper/appbar.dart';
import '../../../helper/appimage.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/screensize.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../utils/validation.dart';
import '../../../widget/customTextField.dart';
import 'controller/wallet_controller.dart';


class Wallet extends GetWidget<WalletController> {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: appBar(context, "Wallet",
              isShowLeading: Get.find<DashboardController>().selectedIndex==2?false:true,
              () {
        Get.back();
      }),
      backgroundColor: ColorConstant.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.walletCard,
                borderRadius:const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    offset:const Offset(0, 3),
                    color: ColorConstant.black3333.withOpacity(.2),
                    blurRadius: 14
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 12,right: 12,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: "Total available points",
                          size: 13,
                          fontFamily: interMedium,
                          letterSpacing: 0.8,
                          color: ColorConstant.blackColor,
                          fontWeight: FontWeight.w500),
                      const SizedBox(height: 4,),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Center(
                          child: getText(
                              title: "₹ ${profileController.walletAmount.value}",
                              size: 22,
                              fontFamily: interSemiBold,
                              color: ColorConstant.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ()
                      {
                        Get.toNamed(AppRoutes.qrCodeScreen);
                      },
                      child: Image.asset(AppImages.qrExpert,height: 44,width: 44,)
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30,),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)
                ),
                boxShadow: [
                  BoxShadow(
                    offset:const Offset(0, -2),
                    color: ColorConstant.black3333.withOpacity(.2),
                    blurRadius: 10
                  )
                ]
              ),
              child: Column(
                children: [
                 const SizedBox(height: 24,),
                  Center(
                    child: getText(
                        title: "Recent Transaction",
                        size: 14,
                        fontFamily: poppinsMedium,
                        color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                 const SizedBox(height: 25,),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {

                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                              },
                              child: walletTransaction(context));
                        }),
                  ),
                ],
              ),
            ),
          )



          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 0, right: 0),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(10.0),
          //       child: Image.asset(
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height/2,
          //         fit: BoxFit.cover,
          //         AppImages.comingSoon,
          //       ),
          //     ),
          //   ),
          // )
          //




        ],
      ),
    );
  }
  walletTransaction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18,right: 18,top: 0,bottom: 6),
      child: GestureDetector(
        onTap: () {

        },
        child: SizedBox(
          height: 63,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    width: 20,
                    height: 20,
                    AppImages.transaction,),
                const  SizedBox(width: 10,),
               const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title: "Paid to Senoritaapp",
                        size: 14,
                        fontFamily: poppinsMedium,
                        color: ColorConstant.blackColorDark,
                        fontWeight: FontWeight.w400),

                  ],
                ),
                const  SizedBox(height: 5,),
                 const Spacer(),
                 const getText(
                      title: "₹ 25,000",
                      size: 14,
                      fontFamily: poppinsMedium,
                      color: ColorConstant.blackColorDark,
                      fontWeight: FontWeight.w400),
                ],),
             const SizedBox(height: 2,),
             const Padding(
                padding:  EdgeInsets.only(left: 29),
                child: getText(
                    title: "28 July, 05:32",
                    size: 12,
                    fontFamily: poppinsMedium,
                    color: ColorConstant.blackLight,
                    fontWeight: FontWeight.w500),
              ),
            const  SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-15,
                color: ColorConstant.dividerColor,
                height: 1,
              ),

            ],
          ),
        ),
      ),
    );
  }

}
