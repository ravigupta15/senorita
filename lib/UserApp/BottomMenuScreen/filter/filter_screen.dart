import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:senorita/UserApp/BottomMenuScreen/filter/filter_controller.dart';
import 'package:senorita/helper/appbar.dart';
import 'package:senorita/helper/custombtn.dart';
import 'package:senorita/helper/getText.dart';
import 'package:senorita/utils/color_constant.dart';
import 'package:senorita/utils/screensize.dart';
import 'package:senorita/utils/stringConstants.dart';
import 'package:senorita/widget/checkbox_widget.dart';

class FilterScreen extends GetView<FilterController>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context, "Filter", () {
        Get.back();
      },),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 40,
              width: 100,
              margin:const EdgeInsets.only(right: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstant.blackLight)
              ),
              child:const getText(title: 'Clear All',
                  size: 16, fontFamily: poppinsMedium,
                  color: ColorConstant.blackLight, fontWeight: FontWeight.w500),
            ),
          ),
          ScreenSize.height(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filterTypesWidget(),
              Expanded(child: SingleChildScrollView(padding:const EdgeInsets.only(
                left: 20,top: 30,right: 15
              ),
              child: viewFiltersWidget(),
              ))
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
            child: CustomBtn(title: 'Filter',
                height: 48, width: double.infinity, onTap: (){},
                color: ColorConstant.appColor),
          )
        ],
      ),
    );
  }

  viewFiltersWidget(){
    return Obx(() => controller.selectedFilterIndex.value==0?
    categoryFilterWidget():controller.selectedFilterIndex.value==1?
    distanceWidget():controller.selectedFilterIndex.value==2?
    priceFilterWidget():controller.selectedFilterIndex.value==3?
    discountFilterWidget():
    ratingFilterWidget());
  }

  categoryFilterWidget(){
   return Obx(()=>controller.categoryModel!=null&& controller.categoryModel.value.data!=null? ListView.separated(
       separatorBuilder: (context,sp){
         return ScreenSize.height(10);
       },
       itemCount: controller.categoryModel.value.data!.length,
       shrinkWrap: true,
       itemBuilder: (context,index){
         return GestureDetector(
           onTap:(){
             if(controller.categoryModel.value.data![index].isSelected.value==false){
               controller.categoryModel.value.data![index].isSelected.value=true;
               controller.categoryModel.value.selectedList.add({
                 "name": controller.categoryModel.value.data![index].name,
                 "id": controller.categoryModel.value.data![index].id
               }
               );
               print('object');
             }
             else{
               controller.categoryModel.value.data![index].isSelected.value=false;
               for(int i=0;i<controller.categoryModel.value.selectedList.length;i++){
                 if(controller.categoryModel.value.selectedList[i]['id']==controller.categoryModel.value.data![index].id){
                   controller.categoryModel.value.selectedList.removeAt(i);
                 }
               }

             }
           },
           child: Container(
             height: 30,
             color: ColorConstant.white,
             child: Row(
                 children: [
                   Obx(() => checkBoxWidget(
                       controller.categoryModel.value.data![index].isSelected.value==true?
                       ColorConstant.appColor:ColorConstant.white)),
                   ScreenSize.width(10),
                   Flexible(
                     child: getText(title: controller.categoryModel.value.data![index].name,
                         size: 15, fontFamily: poppinsMedium, color:
                         ColorConstant.blackLight,
                         fontWeight: FontWeight.w500),
                   )
                 ],
               ),
             ),

         );
       },
     ):Container(),
   );
  }

  priceFilterWidget(){
    return ListView.separated(
        separatorBuilder: (context,sp){
          return ScreenSize.height(10);
        },
          itemCount: controller.priceList.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return GestureDetector(
          onTap:(){
            controller.selectedPriceValue.value=controller.priceList[index];
          },
          child: Container(
            height: 30,
            color: ColorConstant.white,
            child: Row(
              children: [
                Obx(() => checkBoxWidget(
                    controller.selectedPriceValue.value==controller.priceList[index]?
                    ColorConstant.appColor:ColorConstant.white)),
                ScreenSize.width(10),
                getText(title: controller.priceList[index],
                    size: 15, fontFamily: poppinsMedium, color:
                    ColorConstant.blackLight,
                    fontWeight: FontWeight.w500)
              ],
            ),
          ),
        );
      },
    );
  }

  discountFilterWidget(){
    return ListView.separated(
        separatorBuilder: (context,sp){
          return ScreenSize.height(10);
        },
        itemCount: controller.discountList.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap:(){
              controller.selectedDiscountValue.value=controller.discountList[index];
            },
            child: Container(
              height: 30,
              color: ColorConstant.white,
              child: Row(
                children: [
                  Obx(() => checkBoxWidget(
                      controller.selectedDiscountValue.value==controller.discountList[index]?
                      ColorConstant.appColor:ColorConstant.white)),
                  ScreenSize.width(10),
                  getText(title: controller.discountList[index],
                      size: 15, fontFamily: poppinsMedium, color:
                      ColorConstant.blackLight,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
          );
        },
    );
  }

  ratingFilterWidget(){
    return ListView.separated(
      separatorBuilder: (context,sp){
        return ScreenSize.height(10);
      },
      itemCount: controller.ratingList.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap:(){
            controller.selectedRatingValue.value=controller.ratingList[index];
          },
          child: Container(
            height: 30,
            color: ColorConstant.white,
            child: Row(
              children: [
                Obx(() => checkBoxWidget(
                    controller.selectedRatingValue.value==controller.ratingList[index]?
                    ColorConstant.appColor:ColorConstant.white)),
                ScreenSize.width(10),
                getText(title: controller.ratingList[index],
                    size: 15, fontFamily: poppinsMedium, color:
                    ColorConstant.blackLight,
                    fontWeight: FontWeight.w500)
              ],
            ),
          ),
        );
      },
    );
  }

  distanceWidget(){
    return  Column(
      children: [
        RangeSlider(
          values:controller.currentRangeValues.value,
          min: 0,
          max: 100,
          // divisions: 10,
          activeColor: ColorConstant.appColor,
          labels: RangeLabels(
            controller.currentRangeValues.value.start.round().toString(),
            controller.currentRangeValues.value.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            // setState(() {
              controller.currentRangeValues.value = values;
            // });
          },
        ),
        getText(title: "${controller.currentRangeValues.value.start.round().toString()} - ${controller.currentRangeValues.value.end.round().toString()}",
            size: 15, fontFamily: poppinsMedium, color: ColorConstant.blackLight,
            fontWeight: FontWeight.w500)
      ],
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