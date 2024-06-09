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
import 'package:senorita/widget/rating_widget.dart';

class FilterScreen extends GetView<FilterController>{

  @override
  Widget build(BuildContext context){
    print(controller.mergeCategoryModel.value.selectedCategory);
    return Scaffold(
      appBar: appBar(context, "Filter", () {
        Get.back();
      },actions: [
        GestureDetector(
          onTap: (){
            sortByBottomSheet(context);
          },
          child: const Padding(
            padding:  EdgeInsets.only(right: 15),
            child: getText(title: 'Sort by', size: 13,
                fontFamily: poppinsRegular, color: ColorConstant.pointBg,
                fontWeight: FontWeight.w400),
          ),
        )
      ]),
      body: SingleChildScrollView(
        padding:const EdgeInsets.only(
          left: 20,right: 15,top: 5
      ),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categoryWidget(),
            priceFilterWidget(),
            discountFilterWidget(),
            ratingFilterWidget(),
            distanceWidget()
          ],
        )),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: ColorConstant.white,
          boxShadow: [
            BoxShadow(
              offset:const Offset(0, -2),
              color: ColorConstant.blackColor.withOpacity(.1),
              blurRadius: 10
            )
          ]
        ),
        padding:const EdgeInsets.only(left: 21,right: 22,top: 10,bottom: 10),
        child: Column(
          children: [
            CustomBtn(title: 'Apply', height: 50, width: double.infinity,
                onTap: (){
              String subCatId='';
              String catId = controller.mergeCategoryModel.value.selectedCategory.value.map((e)=>e['id']).join(',');
              for(int i=0;i<controller.mergeCategoryModel.value.data!.length;i++){
                for(int j=0;j<controller.mergeCategoryModel.value.data![i].baseCategoryArray!.length;j++){
                  if(controller.mergeCategoryModel.value.data![i].baseCategoryArray![j].selectedSubCategory.isNotEmpty){
                  subCatId = controller.mergeCategoryModel.value.data![i].baseCategoryArray![j].selectedSubCategory.map((e)=>e).join(',');
                }
              }}
              print(subCatId);
              // Get.back(result: [
              //       {'category':},
              //
              //     ]);
                }, color: ColorConstant.appColor),
            // ScreenSize.height(6),
           Container(
             height: 25,
             alignment: Alignment.center,
             color: ColorConstant.white,
             child: const getText(title: 'Reset Filter',
                  size: 13, fontFamily: interMedium, color: ColorConstant.blackLight,
                  fontWeight: FontWeight.w400),
           )
          ],
        ),
      ),
    );
  }

  categoryWidget(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       headingWidget('Categories'),
        ScreenSize.height(15),
        controller.mergeCategoryModel!=null&& controller.mergeCategoryModel.value.data!=null?
        ListView.separated(
          separatorBuilder: (context,sp){
            return ScreenSize.height(20);
          },
            itemCount: controller.mergeCategoryModel.value.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
          return Obx(()=>Column(
              children: [
            GestureDetector(
              onTap: (){
                print(controller.mergeCategoryModel.value.data![index].id);

                if(controller.mergeCategoryModel.value.data![index].isSelectedCat.value){
                  /// default value
                  for(int i=0;i<controller.mergeCategoryModel.value.selectedCategory.value.length;i++){
                    print(controller.mergeCategoryModel.value.selectedCategory[i]);
                    if(controller.mergeCategoryModel.value.selectedCategory.value[i]['id'].toString()==controller.mergeCategoryModel.value.data![index].id.toString()){
                      controller.mergeCategoryModel.value.selectedCategory.removeAt(i);
                    }
                  }
                  controller.mergeCategoryModel.value.data![index].isSelectedCat.value=false;
                  controller.mergeCategoryModel.value.isOpenSubCategory.value=1000;
                }
                else{
                  controller.mergeCategoryModel.value.data![index].isSelectedCat.value=true;
                  controller.mergeCategoryModel.value.isOpenSubCategory.value=index;
                  controller.mergeCategoryModel.value.selectedCategory.value.add({
                    "name":controller.mergeCategoryModel.value.data![index].name.toString(),
                    "id":controller.mergeCategoryModel.value.data![index].id.toString()
                  });
                }
              },
              child: Row(
                children: [
               Obx(() => checkBoxWidget(controller.mergeCategoryModel.value.data![index].isSelectedCat.value?
               ColorConstant.appColor:ColorConstant.white)),
                    ScreenSize.width(6),
                    Expanded(
                    child: getText(title: controller.mergeCategoryModel.value.data![index].name,
                    size: 12, fontFamily: interRegular,
                    color: ColorConstant.qrViewText, fontWeight: FontWeight.w400),
                    ),
                    ScreenSize.width(2),
                     GestureDetector(
                       onTap: (){
                         if(controller.mergeCategoryModel.value.isOpenSubCategory.value==index){
                           controller.mergeCategoryModel.value.isOpenSubCategory.value=1000;
                           ///defualt value
                         }
                         else{
                           controller.mergeCategoryModel.value.isOpenSubCategory.value=index;
                         }
                       },
                       child: Icon(
                         controller.mergeCategoryModel.value.isOpenSubCategory.value==index? Icons.minimize:
                        Icons.add,color:controller.mergeCategoryModel.value.isOpenSubCategory.value==index? ColorConstant.appColor:ColorConstant.qrViewText,size: 17,),
                     )
                    ],
                    ),
            ),
                controller.mergeCategoryModel!=null&&controller.mergeCategoryModel.value.data!=null&&
                    controller.mergeCategoryModel.value.data![index].baseCategoryArray!=null&&
                controller.mergeCategoryModel.value.isOpenSubCategory.value==index?
                ListView.separated(
                  separatorBuilder: (context,sp1){
                    return ScreenSize.height(11);
                  },
                  shrinkWrap: true,
                    padding:const EdgeInsets.only(top: 11,left: 25),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.mergeCategoryModel.value.data![index].baseCategoryArray!.length,
                    itemBuilder: (context,sbIndex){
                  return GestureDetector(
                    onTap: (){
                      if(controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].isSelectedSubCat.value){
                        controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].isSelectedSubCat.value=false;
                        for(int i=0;i<controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].selectedSubCategory.length;i++){
                          if(controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].selectedSubCategory[i]==controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].id.toString()){
                            controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].selectedSubCategory.removeAt(i);
                          }
                        }
                      }
                      else{
                        controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].isSelectedSubCat.value=true;
                        controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].selectedSubCategory.add(controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].id.toString());
                      }
                    },
                    child: Row(
                      children: [
                       Obx(() =>  checkBoxWidget(controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].isSelectedSubCat.value?
                       ColorConstant.appColor:ColorConstant.white),
                       ),
                        ScreenSize.width(6),
                        Expanded(
                          child: getText(title: controller.mergeCategoryModel.value.data![index].baseCategoryArray![sbIndex].name,
                              size: 11, fontFamily: interRegular,
                              color: ColorConstant.qrViewText, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                }):Container()
              ],
            ),
          );
        }):Container(),
      ],
    );
  }

  priceFilterWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSize.height(20),
        headingWidget('Price'),
        ScreenSize.height(15),
        ListView.separated(
            separatorBuilder: (context,sp){
              return ScreenSize.height(14);
            },
              itemCount: controller.priceList.length,
              shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
                    getText(title: "Rs. ${controller.priceList[index]}",
                        size: 13, fontFamily: interMedium, color:
                        ColorConstant.blackColor,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  discountFilterWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSize.height(20),
        headingWidget('Discount'),
        ScreenSize.height(15),
        ListView.separated(
            separatorBuilder: (context,sp){
              return ScreenSize.height(14);
            },
          physics: const NeverScrollableScrollPhysics(),
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
                      getText(title: "${controller.discountList[index]}${controller.discountList.length-1==index?'':"%"}",
                          size: 13, fontFamily: interMedium, color:
                          ColorConstant.blackColor,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                ),
              );
            },
        ),
      ],
    );
  }


  ratingFilterWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSize.height(20),
        headingWidget('Rating'),
        ScreenSize.height(13),
        Row(
          children: [
            ratingWidget(size: 20,
                initalRating: controller.selectedRating.value,
                isGesture: false, onRatingUpdate: (val){
              controller.selectedRating.value=val;
                }),
            ScreenSize.width(6),
            getText(title: "${controller.selectedRating.value.toString()} +",
                size: 13, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500)
          ],
        ),
      ],
    );
  }

  distanceWidget(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenSize.height(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            headingWidget("Distance"),
            headingWidget("${controller.currentRangeValues.value.round().toString()} Km"),
          ],
        ),
        // ScreenSize.height(15),
        Slider(
            activeColor: ColorConstant.appColor,
            max: 100,
            min: 0,
            inactiveColor: ColorConstant.appColor.withOpacity(.5),
            value: controller.currentRangeValues.value,
            onChanged: (val){
          controller.currentRangeValues.value = val;
            })
        ],
    );
  }

  headingWidget(String title){
    return   getText(title: title,
        size: 13, fontFamily: interMedium, color: ColorConstant.blackColor, fontWeight: FontWeight.w500);
  }


  sortByBottomSheet(BuildContext context){
    showModalBottomSheet(context: context,
        backgroundColor: ColorConstant.white,
        shape:const OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.whiteColor),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        builder: (context){
      return StatefulBuilder(
        builder: (context,state) {
          return Container(
            decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: ColorConstant.whiteColor
          ),
            padding:const EdgeInsets.only(top: 27,left: 26,right: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(title: 'Sort By',
                        size:18, fontFamily: interMedium, color: ColorConstant.blackColor,
                        fontWeight: FontWeight.w600),
                   GestureDetector(
                       onTap: (){
                         Get.back();
                       },
                       child: const Icon(Icons.close,))
                  ],
                ),
                ListView.separated(
                  padding:const EdgeInsets.only(top: 26,bottom: 26),
                  separatorBuilder: (context,sp){
                    return ScreenSize.height(5);
                  },
                    itemCount: controller.sortByList.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                  return Obx(()=>Container(
                      height: 36,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color:controller.selectedSort.value==index? const Color(0xffFFF7F9):ColorConstant.whiteColor,
                      child: InkWell(
                        onTap: (){
                          controller.selectedSort.value = index;
                          state((){});
                        },
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getText(title: controller.sortByList[index],
                                  size: 14, fontFamily: interMedium, color: ColorConstant.black3333,
                                  fontWeight: FontWeight.w400),
                              customRadioButton(index)
                            ],
                          ),
                        ),

                    ),
                  );
                })
              ],
            ),
          );
        }
      );
        });
  }

  customRadioButton(int index){
    return Container(
      height: 20,
      width: 20,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color:controller.selectedSort.value==index?ColorConstant.appColor: ColorConstant.dot),
        color:controller.selectedSort.value==index?ColorConstant.appColor: ColorConstant.dot
      ),
      child:controller.selectedSort.value==index?
     const Icon(Icons.check,color: ColorConstant.whiteColor,size: 13,):Container(),
    );
  }
}