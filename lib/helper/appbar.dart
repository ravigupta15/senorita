
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';
import '../utils/stringConstants.dart';
import 'appimage.dart';
import 'getText.dart';

AppBar appBar(BuildContext context, String title, Function() onTap,{isShowLeading =true}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0.0,
    leadingWidth: 28,
    leading:isShowLeading? Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
          height: 25,
          width: 25,
          alignment: Alignment.centerRight,
          child: GestureDetector(
              onTap: onTap,
              child: Image.asset(
                AppImages.backIcon,
                height: 25,
                width: 25,
              ))),
    ):Container(),
    title: getText(
        title: title,
        size: 17,
        fontFamily: interSemiBold,
        letterSpacing: 0.7,
        color: ColorConstant.blackColor,
        fontWeight: FontWeight.w400),
    centerTitle: true,
  );
}
