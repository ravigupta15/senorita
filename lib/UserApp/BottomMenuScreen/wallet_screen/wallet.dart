import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

    return WillPopScope(
      onWillPop: () async
      {
        Get.toNamed(AppRoutes.dashboardScreen,);
        return true;
      },
      child: Scaffold(
        appBar: appBar(context, "Wallet", () {
          Get.back();
        }),
        backgroundColor: ColorConstant.screenBack.withOpacity(0.4),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           /* Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: SizedBox(
                height: 100,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 5,
                  color: ColorConstant.walletCard,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: "Total Pay Amount",
                            size: 13,
                            fontFamily: interMedium,
                            letterSpacing: 0.8,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Center(
                                child: getText(
                                    title: "₹ 5,000",
                                    size: 22,
                                    fontFamily: interSemiBold,
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: ()
                              {
                                Get.toNamed(AppRoutes.qrCodeScreen);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.onBoardingBack,
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                      border: Border.all(color: ColorConstant.onBoardingBack)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                                    child: getText(
                                        title: "Pay Now",
                                        size: 12,
                                        fontFamily: interMedium,
                                        color: ColorConstant.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),

            Expanded(
              child: SizedBox(
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 16,),
                      Center(
                        child: getText(
                            title: "Recent Transaction",
                            size: 16,
                            letterSpacing: 0.4,
                            fontFamily: interSemiBold,
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 25,),
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
              ),
            )*/



            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2,
                    fit: BoxFit.cover,
                    AppImages.comingSoon,
                  ),
                ),
              ),
            )





          ],
        ),
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
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(
                            title: "Paid to Senoritaapp",
                            size: 15,
                            fontFamily: interMedium,
                            color: ColorConstant.blackColorDark,
                            fontWeight: FontWeight.w500),

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),

                  Spacer(),
                  getText(
                      title: "₹ 25,000",
                      size: 14,
                      fontFamily: interMedium,
                      color: ColorConstant.blackColorDark,
                      fontWeight: FontWeight.w500),
                ],),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: getText(
                    title: "28 July, 05:32",
                    size: 14,
                    fontFamily: interLight,
                    color: ColorConstant.blackLight,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10,),
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
