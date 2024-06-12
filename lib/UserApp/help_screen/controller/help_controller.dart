import 'package:get/get.dart';
import '../../../utils/size_config.dart';

class helpController extends GetxController {
  final url = "".obs;
  final isLoading=true.obs;
  final loadingPercentage = 0.obs;
  String helpAndTermsString="";
  String kodagoCardUrl="";
  void changeUrl(String newUrl) {
    url.value = newUrl;
  }
  @override
  void onInit() {
    helpAndTermsString=Get.arguments[0];
    kodagoCardUrl=Get.arguments[1];
    if(helpAndTermsString=="termsCondition")
    {
      url.value="https://senoritaapp.com/backend/senorita-terms-conditions";
    }
    else if(helpAndTermsString=="helpSupport")
    {
      url.value="https://senoritaapp.com/backend/senorita-help-support";
    }
    else if(helpAndTermsString=="detail")
    {
      url.value=kodagoCardUrl.toString();
    }
    SizeConfig().init();
    super.onInit();
  }




}
