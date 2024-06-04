
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';

checkBoxWidget(Color color, ){
  return  Container(
    height: 22,width: 22,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorConstant.onBoardingBack)
    ),
    alignment: Alignment.center,
    child: Icon(Icons.check,size: 16,color: ColorConstant.white,),
  );
}
