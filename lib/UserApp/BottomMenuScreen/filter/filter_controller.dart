import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController{
final selectedFilterIndex = 0.obs;
var currentRangeValues = const RangeValues(0, 100).obs;

static String valueToString(double value) {
  return value.toStringAsFixed(0);
}
}