import 'package:flutter/material.dart';
import 'package:senorita/utils/color_constant.dart';

import '../helper/getText.dart';
import '../utils/stringConstants.dart';

Widget noDataFound(){
  return  Center(
    child: getText(
        title: 'No data found',
        textAlign: TextAlign.center,
        size: 14,
        fontFamily: celiaMedium,
        color: ColorConstant.appColor,
        fontWeight: FontWeight.w500),
  );
}