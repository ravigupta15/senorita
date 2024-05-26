import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/appimage.dart';
import 'controller/splash_controller.dart';
class SplashScreen extends GetView<SplashController> {
  const SplashScreen({key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Image.asset(
                fit: BoxFit.cover,
                AppImages.splashCenter,
              )),
        ),
      ],
    ));
  }
}
