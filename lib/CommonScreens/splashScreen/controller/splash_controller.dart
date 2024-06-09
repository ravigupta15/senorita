import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ScreenRoutes/routes.dart';
import '../../walkthrough_screen/walkthrough_screen.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    callToNavigate();
  }

  void getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      // activegps.value = false;
    } else {
      // activegps.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      // initialposition = LatLng(position.latitude, position.longitude);
      print(
          "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
      // lat.add(position.longitude);
      // long.add(position.longitude);

      // currentLat.value = position.latitude;
      // currentLong.value = position.longitude;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lat', position.latitude.toString());
      prefs.setString('long', position.longitude.toString());
      // subLocality.value = placemark[0].subLocality.toString();
      // address.value =
      //     placemark[0].street.toString()+","+
      //         placemark[0].thoroughfare.toString()+","+
      //         placemark[0].subLocality.toString()+","+
      //         placemark[0].locality.toString()+","+
      //         placemark[0].administrativeArea.toString()+","+
      //         placemark[0].country.toString();
      // city.value=placemark[0].locality.toString();
      // state.value=placemark[0].administrativeArea.toString();
      // _mapController.moveCamera(CameraUpdate.newLatLng(initialposition));
    }
  }

  callToNavigate() async {
    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getBool("initScreen")==true)
        {
          Get.offAllNamed(AppRoutes.loginScreen);
          if (prefs.getBool('isLogin') == true) {
            if (prefs.getBool('userIsLogin') == true) {
              Get.offAllNamed(AppRoutes.dashboardScreen);
            } else if (prefs.getBool('expertIsLogin') == true) {
              Get.offAllNamed(AppRoutes.expertDashboardScreen);
            }
          }
        }
      else
        {
          Get.to(OnboardingScreen());
        }

    });
  }
}
