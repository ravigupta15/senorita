import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:senorita/helper/appimage.dart';
import 'package:http/http.dart' as http;
import '../../../helper/appbar.dart';
import '../../../helper/custombtn_new.dart';
import '../../../helper/getText.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/size_config.dart';
import '../../../utils/stringConstants.dart';
import '../../../utils/toast.dart';
import '../../../widget/customTextField.dart';
import 'controller/priceListcontroller.dart';
import 'model/topic.dart';

class AddPriceListScreen extends GetView<PriceListController> {
  const AddPriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, "Menu & Price List", () {
        Get.back();
      }),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {},
        child: Image.asset(AppImages.downArrow,
            width: SizeConfig.imageSizeMultiplier * 7),
      ),*/
      body: /*Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ),
          ],
        ),
      )*/
          Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.allCategoryList.isNotEmpty?
                          categoryDialogBox(context):showToast("Data Loading Please Wait");
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
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, bottom: 10),
                                  child: getText(
                                      title:
                                          controller.categoryString.value == ""
                                              ? registerCategory
                                              : controller.categoryString.value,
                                      textAlign: TextAlign.start,
                                      size: 13,
                                      fontFamily: interRegular,
                                      color: ColorConstant.black2,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                        child: Image.asset(
                                          height: 8,
                                          width: 8,
                                          AppImages.arrowRegister,
                                        ),
                                /*  Icon(
                                                Icons.arrow_back_ios_rounded)*/
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => controller.selectedCategoryType.value != (-1)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 65),
                                  child: Row(
                                    children: [
                                      getText(
                                          title: "Tittle",
                                          textAlign: TextAlign.start,
                                          size: 13,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w600),
                                      Spacer(),
                                      getText(
                                          title: "Price",
                                          textAlign: TextAlign.center,
                                          size: 13,
                                          fontFamily: interMedium,
                                          color: ColorConstant.blackColor,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                ),
                                /* Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.lightColor.withOpacity(0.2),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                      height: 40,
                                      child: TextFormField(
                                        controller: controller.enterTitle,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 15),
                                          hintText: "Enter Title",
                                          hintStyle: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: interRegular,
                                              color: ColorConstant.addPriceListText),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              width: 1.0,
                                            ), // BorderSide
                                          ),
                                          // OutlineInputBorder
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorConstant
                                                    .addPriceListText), // BorderSide
                                          ),
                                          // OutlineInputBorder
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorConstant
                                                    .addPriceListText), // BorderSide
                                          ), // OutlineInputBorder
                                        ),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: interRegular,
                                            color: ColorConstant
                                                .redeemTextDark), // InputDecoration
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      width: 100,
                                      height: 45,
                                      child: Row(
                                        children: [
                                          getText(
                                              title: "₹",
                                              textAlign: TextAlign.center,
                                              size: 16,
                                              fontFamily: celiaRegular,
                                              color: ColorConstant.blackColor,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 80,
                                            child: TextFormField(
                                              controller: controller.enterPrice,
                                              keyboardType: TextInputType.number,
                                              onChanged: (text) {
                                                if(controller.enterPrice.text.length>0)
                                                  {
                                                    controller.addButton.value=true;
                                                  }
                                                else
                                                  {
                                                    controller.addButton.value=false;
                                                  }

                                              },
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                isDense: true,
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 12),
                                                hintText: "Enter Price",

                                                hintStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: interRegular,
                                                    color: ColorConstant
                                                        .addPriceListText),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  borderSide: const BorderSide(
                                                    width: 2.0,
                                                  ), // BorderSide
                                                ),
                                                // OutlineInputBorder
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  borderSide: const BorderSide(
                                                      width: 1.5,
                                                      color: ColorConstant
                                                          .addPriceListText), // BorderSide
                                                ),
                                                // OutlineInputBorder
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  borderSide: const BorderSide(
                                                      width: 2.0,
                                                      color: ColorConstant
                                                          .addPriceListText), // BorderSide
                                                ), // OutlineInputBorder
                                              ),

                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: interRegular,
                                                  color: ColorConstant
                                                      .redeemTextDark), // InputDecoration
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          */ /*Obx(()=>
                                           controller.addButton.value==true?
                                            GestureDetector(
                                              onTap: ()
                                              {
                                                GroupTitleDataModel model =
                                                GroupTitleDataModel(
                                                    userId: "51",
                                                    item_name: controller.enterTitle.text,
                                                    price: controller.enterPrice.text);
                                                controller.addTopicList.add(model);
                                              },
                                              child: Image.asset(
                                                height: 25,
                                                width: 25,
                                                AppImages.addPrice,
                                              ),
                                            ):Container(
                                                decoration: BoxDecoration(
                                                    color: ColorConstant.noData,
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(5))),
                                              child: Icon(
                                                color: Colors.white,
                                                  Icons.add)
                                            */ /**/ /*  Image.asset(
                                                height: 25,
                                                width: 25,
                                                AppImages.addPrice,
                                              ),*/ /**/ /*
                                            ),
                                          )*/ /*
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),*/
                              ],
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            //Category
            Flexible(
              flex: 3,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.only(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.addTopicList.length,
                    itemBuilder: (context, index) {
                      var model = controller.addTopicList[index];

                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstant.lightColor.withOpacity(0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: model.titleController,

                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 15),
                                        hintText: "Type Title",
                                        hintStyle: const TextStyle(
                                            fontSize: 13,
                                            fontFamily: interRegular,
                                            color:
                                                ColorConstant.addPriceListText),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                          ), // BorderSide
                                        ),
                                        // OutlineInputBorder
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: ColorConstant
                                                  .addPriceListText), // BorderSide
                                        ),
                                        // OutlineInputBorder
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: ColorConstant
                                                  .addPriceListText), // BorderSide
                                        ), // OutlineInputBorder
                                      ),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: interRegular,
                                          color: ColorConstant
                                              .redeemTextDark), // InputDecoration
                                    ),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    width: 100,
                                    height: 45,
                                    child: Row(
                                      children: [
                                        getText(
                                            title: "₹",
                                            textAlign: TextAlign.center,
                                            size: 14,
                                            fontFamily: celiaRegular,
                                            color: ColorConstant.blackColor,
                                            fontWeight: FontWeight.w400),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 80,
                                          child: TextFormField(
                                            controller: model.priceController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(4)
                                            ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 15),
                                              hintText: "Price",
                                              hintStyle: const TextStyle(
                                                  fontSize: 13,

                                                  fontFamily: interRegular,
                                                  color: ColorConstant
                                                      .addPriceListText),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                  width: 2.0,
                                                ), // BorderSide
                                              ),
                                              // OutlineInputBorder
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    width: 1.5,
                                                    color: ColorConstant
                                                        .addPriceListText), // BorderSide
                                              ),
                                              // OutlineInputBorder
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: ColorConstant
                                                        .addPriceListText), // BorderSide
                                              ), // OutlineInputBorder
                                            ),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: interRegular,
                                                color: ColorConstant
                                                    .redeemTextDark), // InputDecoration
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (model.status.value) {
                                              print('if${model.status.value}');
                                              controller.removeItems(index);
                                            } else {
                                              if (model.titleController.text
                                                      .isNotEmpty &&
                                                  model.priceController.text
                                                      .isNotEmpty) {
                                                model.status.value = true;
                                                print(
                                                    'else${model.status.value}');
                                                controller.sendDataList.add({
                                                  'item_name': model
                                                      .titleController.text,
                                                  'price':
                                                      model.priceController.text
                                                });
                                                controller.updateItems();
                                              } else {
                                                showToast(
                                                    "Enter title and price");
                                              }
                                            }
                                            // controller.addTopicList.removeAt(index);
                                            // controller.addTopicList.remove(model1);
                                          },
                                          child: Image.asset(
                                            height: 23,
                                            width: 23,
                                            model.status.value
                                                ? AppImages.removePrice
                                                : AppImages.addPrice,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            //AddTopicWidget(context),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: Obx(
              () => Column(
                children: [
                  controller.selectedCategoryType.value != (-1)
                      ? CustomBtnNew(
                          title: loginButton,
                          height: 46,
                          width: double.infinity,
                          rectangleBorder: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent, width: 1.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: ColorConstant.onBoardingBack,
                          onTap: () {
                            bool checkValidation = false;
                            print(controller.addTopicList.length);
                            controller.sendDataList.clear();
                            for (int i = 0;
                                i < controller.addTopicList.length;
                                i++) {
                              if(controller.addTopicList[controller.addTopicList.length-1].titleController.text.isNotEmpty&&
                                  controller.addTopicList[controller.addTopicList.length-1].priceController.text.isNotEmpty){
                                checkValidation=true;
                              }
                              else{
                                checkValidation=false;
                              }
                              controller.sendDataList.add({
                                'item_name': controller
                                    .addTopicList[i].titleController.text,
                                'price': controller
                                    .addTopicList[i].priceController.text
                              });
                            }
                            // print(sendDataList);
                            if(checkValidation){
                              controller.submitMultipleItems(
                                  context, controller.sendDataList);
                            }
                            else{
                              EasyLoading.showToast('Add Price and title');
                            }

                          },
                          textColor: ColorConstant.whiteColor)
                      : SizedBox(),
                ],
              ),
            )),
      ),
    );
  }

  /* Widget AddTopicWidget(BuildContext context) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.addTopicList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(color: ColorConstant.addPriceBack.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                children: [

                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 40,

                      child:
                      TextFormField(
                        controller: controller.enterTopic,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          hintText: "Type Title",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: interRegular,
                            color: ColorConstant.addPriceListText
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                            ), // BorderSide
                          ),
                          // OutlineInputBorder
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: ColorConstant.addPriceListText
                            ), // BorderSide
                          ),
                          // OutlineInputBorder
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: ColorConstant.addPriceListText
                            ), // BorderSide
                          ), // OutlineInputBorder
                        ),
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: interRegular,
                            color: ColorConstant.redeemTextDark), // InputDecoration
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 100,
                      height: 45,
                      child: Row(
                        children: [
                           getText(
                              title: "₹",
                              textAlign: TextAlign.center,
                              size: 16,
                              fontFamily: celiaRegular,
                              color: ColorConstant.blackColor,
                              fontWeight: FontWeight.w400),
                          SizedBox(width: 10,),
                          SizedBox(
                            height: 40,
                            width: 80,
                            child: TextFormField(
                              controller: controller.enterTopic,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15),
                                hintText: "Price",
                                hintStyle: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: interRegular,
                                    color: ColorConstant.addPriceListText
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                  ), // BorderSide
                                ),
                                // OutlineInputBorder
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 1.5,
                                      color: ColorConstant.addPriceListText
                                  ), // BorderSide
                                ),
                                // OutlineInputBorder
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2.0,
                                      color: ColorConstant.addPriceListText
                                  ), // BorderSide
                                ), // OutlineInputBorder
                              ),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: interRegular,
                                  color: ColorConstant.redeemTextDark), // InputDecoration
                            ),
                          ),
                          SizedBox(width: 10,),
                          Image.asset(
                            height: 25,
                            width: 25,
                            AppImages.removePrice,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
                  ),
              ),
            ),
          );
        },
      ),
    );
  }

  subCategory(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Container(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                          () => Container(
                        height: 300,
                        child: ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.subCategoryList.length,
                            itemBuilder: (context, index) {
                              SubCategoryPriceModel model = SubCategoryPriceModel.fromJson(controller.subCategoryList[index]);
                              return Column(
                                children: [
                                  Obx(
                                        () => GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          if (controller.stringList.contains(controller.subCategoryList[index].toString())) {
                                            controller.stringList.remove(controller.subCategoryList[index].toString());
                                            print(controller.stringList[index].toString());
                                          } else {
                                            controller.stringList.add(model.name.toString());
                                            controller.subCategoryIdList.add(model.id.toString());

                                            //
                                            //  showToast((controller.subCategoryIdList).join(","));



                                          }
                                        },
                                        child: ListTile(
                                          title: Text(model.name.toString()),
                                          trailing: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(2),
                                              border: Border.all(
                                                color: controller.stringList.contains(model.name.toString())
                                                    ? Colors.blue
                                                    : Colors.grey.shade500,
                                              ),
                                              color: controller.stringList.contains(model.name.toString())
                                                  ? Colors.blue
                                                  : Colors.white,
                                            ),
                                            child: controller.stringList.contains(model.name.toString())
                                                ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 14,
                                            )
                                                : null,
                                          ),
                                        )),
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
                                size: 17,
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
                                size: 17,
                                fontFamily: interRegular,
                                color: ColorConstant.onBoardingBack,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        });
  }*/

  categoryDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, state) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: ColorConstant.dividerColor,
                      height: 1,
                    ),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
  
                      // color: Colors.white,
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, bottom: 15, top: 4),
                          itemCount: controller.allCategoryList.length,
                          itemBuilder: (context, index) {
                            CategoryPriceModel model = CategoryPriceModel.fromJson(
                                controller.allCategoryList[index]);
                            return Column(
                              children: [
                               const SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      controller.selectedCategoryType.value = index;
                                      controller.categoryString.value =
                                          model.name.toString();
                                      controller.categoryId.value =
                                          model.id.toString();

                                      controller.selectedCategoryType.value != (-1)
                                          ? controller.addTopicList.clear()
                                          : SizedBox();
                                      // controller.submitMultipleItems(context);
                                    },
                                    child: Row(
                                      children: [
                                        controller.selectedCategoryType.value ==
                                                index
                                            ? const Icon(
                                                Icons.radio_button_checked,
                                                size: 20,
                                                color: ColorConstant.onBoardingBack,
                                              )
                                            : const Icon(
                                                color: ColorConstant.greyColor,
                                                size: 20,
                                                Icons.radio_button_off_outlined,
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          model.name.toString(),
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
                          left: 15, right: 15, bottom: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const getText(
                                title: "Cancel",
                                size: 17,
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
                              if (controller.selectedCategoryType.value == -1) {
                                showToast("Please Select Category");
                              } else {
                                controller.updateItems();
                                Navigator.pop(context);
                              }
                            },
                            child: const getText(
                                title: "Ok",
                                size: 17,
                                fontFamily: interRegular,
                                color: ColorConstant.onBoardingBack,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          );
        });
  }
}
