import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/expert_dashboard_screen/controller/dashboard_controller.dart';
import 'package:senorita/ExpertApp/BottomMenuScreen/specialoffers/controller/special_offer_controller.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/stringConstants.dart';

class SpecialOfferScreen extends GetView<SpecialOfferController>{

  @override
  Widget build(BuildContext context){
    return Obx(()=>Scaffold(
        appBar: appBar(context, "Special Offer",isShowLeading:
        Get.find<ExpertDashboardController>().selectedIndex.value==1?
        false:true, () => Get.back()),
        body: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.addOfferScreen);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 42,
                  margin:const EdgeInsets.only(right: 15),
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:const Color(0xffD9D9D9)
                      )
                  ),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,color: ColorConstant.homeExp,),
                      getText(title: 'Add offer',
                          size: 15, fontFamily: poppinsMedium, color: ColorConstant.homeExp,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}