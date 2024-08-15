import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:senorita/utils/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../walkthrough_screen/walkthrough_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    LocationService.getUserLocation();
    callToNavigate();
  }

  callToNavigate() async {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool("initScreen") == true) {
        Get.offAllNamed(AppRoutes.loginScreen);
        if (prefs.getBool('isLogin') == true) {
          if (prefs.getBool('userIsLogin') == true) {
            Get.offAllNamed(AppRoutes.dashboardScreen);
          } else if (prefs.getBool('expertIsLogin') == true) {
            Get.offAllNamed(AppRoutes.expertDashboardScreen);
          }
        }
      } else {
        Get.to(OnboardingScreen());
      }
    });
  }
}
