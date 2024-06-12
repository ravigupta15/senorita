import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/CommonScreens/notification/notification_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/my_sperator.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';

class NotificationScreen extends GetView<NotificationController>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, 'Notification', () => Get.back()),
      body: ListView.separated(
        separatorBuilder: (context,sp){
          return Column(
            children: [
              ScreenSize.height(19),
             const MySeparator(height: 1,color: ColorConstant.dot,),
              ScreenSize.height(14),
            ],
          );
        },
          padding:const EdgeInsets.only(left: 18,right: 17,bottom: 40,top: 10),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return notificationWidget();
      }),
    );
  }

  dashedBorderWidget(){
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: [5, 3], // Dash pattern [dash length, gap length]
      color: Colors.black,
      strokeWidth: 1,
      child: Container(
        // width: 1,
        // height: 1, // Adjust height as needed
      ),
    );
  }
  notificationWidget(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: (){

          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 55,
              width: 55,
              color: Colors.red,
            ),
          ),
        ),
        ScreenSize.width(9),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   getText(title: 'Ajeax Carry',
                      size: 16, fontFamily: interMedium, color: ColorConstant.black3333,
                      fontWeight: FontWeight.w500),
                   getText(title: '11:30',
                      size: 14, fontFamily: interMedium, color: ColorConstant.black3333,
                      fontWeight: FontWeight.w500),

                ],
              ),
              ScreenSize.height(8),
          const  Text( 'Lorem Ipsum is simply dummy text of the printing and typesetting.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13, fontFamily: interRegular, color: ColorConstant.redeemTextDark,
                      fontWeight: FontWeight.w400
                  ),),
            ],
          ),
        ),

      ],
    );
  }
}