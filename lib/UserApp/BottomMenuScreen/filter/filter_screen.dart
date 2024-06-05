import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/stringConstants.dart';

class FilterScreen extends GetView<FilterController>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, "Filter", () {
        Get.back();
      }),
      body: Column(
        children: [
          Row(
            children: [
              filterTypesWidget(),
              Expanded(child: viewFiltersWidget())
            ],
          )
        ],
      ),
    );
  }

  viewFiltersWidget(){
    return distanceWidget();
  }

  distanceWidget(){
    return  RangeSlider(
      values:controller.currentRangeValues.value,
      min: 0,
      max: 100,
      divisions: 10,
      labels: RangeLabels(
        controller.currentRangeValues.value.start.round().toString(),
        controller.currentRangeValues.value.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        // setState(() {
          controller.currentRangeValues.value = values;
        // });
      },
    );
  }

  filterTypesWidget(){
    return Column(
      children: [
        filterType('Category',0),
        filterType('Distance',1),
        filterType('Price',2),
        filterType('Discount',3),
        filterType('Rating',4),
      ],
    );
  }

  filterType(String title,int index){
    return Obx(()=>GestureDetector(
        onTap: (){
          controller.selectedFilterIndex.value=index;
        },
        child: Container(
          width: 110,
          alignment: Alignment.centerLeft,
          padding:const EdgeInsets.only(top: 20,bottom: 20,left: 12),
          decoration: BoxDecoration(
            color:controller.selectedFilterIndex.value==index?
            ColorConstant.whiteColor:
            ColorConstant.detailsBackCard
          ),
          child: getText(title: title,
              size: 15, fontFamily: poppinsMedium,
              color: ColorConstant.blackColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}