
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'appimage.dart';

searchBar({required bool readOnly, Function()?onTap,ValueChanged<String>? onChanged}) {
  return Container(
    height: 49,
    margin:const EdgeInsets.only(left: 15,right: 15,top: 10),
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
            color: ColorConstant.addPriceListText
        )
    ),
    alignment: Alignment.center,
    child: TextFormField(
      readOnly: readOnly,
      autofocus: true,
      style: TextStyle(
          color: ColorConstant.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: interRegular),
      decoration: InputDecoration(
          prefixIcon: Container(
            alignment: Alignment.center,
            height: 20,
            width: 20,
            child: Image.asset(
              AppImages.search,
              height: 20,
              width: 20,
            ),
          ),
          hintText: 'Search on senoritaapp...',
          hintStyle:const TextStyle(
              color: ColorConstant.qrViewText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: interRegular),
          border: InputBorder.none),
      onChanged: onChanged,
      onTap: onTap
    ),
  );
}
