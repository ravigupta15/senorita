class ApiUrls {
  ///Base Url
 // static const String apiBaseUrl = "https://senoritaapp.com/backend/public/api/";
 //  static const String apiBaseUrlTesting = "https://senoritaapp.com/staging-backend/public/api/";
 //  static const String offerImageBase = "https://senoritaapp.com/staging-backend/public/upload/offers/";

  ///Live Url
  static const String apiBaseUrlTesting = "https://senoritaapp.com/backend/public/api/";
  static const String offerImageBase = "https://senoritaapp.com/backend/public/upload/offers/";

  ///Common Screen
  static const String login = "${apiBaseUrlTesting}login";
  static const String submitOtp = "${apiBaseUrlTesting}verifyOtp";
  static const String resendOtp = "${apiBaseUrlTesting}resendOtp";

  ///User Api Url
  static const String homeScreen = "${apiBaseUrlTesting}user_home_page";
  static const String userRegistration = "${apiBaseUrlTesting}register";
  static const String getProfile = "${apiBaseUrlTesting}get-user-details";
  static const String getExperts = "${apiBaseUrlTesting}experts";
  static const String citiesApiUrl = "${apiBaseUrlTesting}cities";
  static const String updateUserProfile = "${apiBaseUrlTesting}update-user-details";
  static const String getCategoryDetails = "${apiBaseUrlTesting}expert-detail";
  static const String expertCategoriesApiUrl = "${apiBaseUrlTesting}categories";
  static const String expertSubCategoriesApiUrl = "${apiBaseUrlTesting}sub-categories";
  static const String expertSubCategoriesPriceApiUrl = "${apiBaseUrlTesting}selected_sub_category_list";
  static const String expertAddMultipleItemApiUrl = "${apiBaseUrlTesting}add_multiple_items";
  static const String homeScreenDetails = "${apiBaseUrlTesting}expert-detail";

  ///Expert Api Url
  static const String registerExpert = "${apiBaseUrlTesting}create-expert";
  static const String cityApiUrl = "${apiBaseUrlTesting}getCities";
  static const String categoryApiUrl = "${apiBaseUrlTesting}categories";

  static const String getExpertStatus = "${apiBaseUrlTesting}get-expert-status";
  static const String updateExpertStatus = "${apiBaseUrlTesting}update-expert-status";
  static const String getExpertProfileDetail = "${apiBaseUrlTesting}expert-profile";
  static const String updateExpertProfileDetail = "${apiBaseUrlTesting}update-expert-details";
  static const String updateExpertHome = "${apiBaseUrlTesting}expert_home_page";
  static const String walletExpert = "${apiBaseUrlTesting}expert_wallet";
  static const String selectedSubCategory = "${apiBaseUrlTesting}selected_sub_category_list";


  static const String getPriceList = "${apiBaseUrlTesting}list_items";

  static const String getUserReview = "${apiBaseUrlTesting}expert-review-by-id";

  static const String submitReview = "${apiBaseUrlTesting}submit-rating";

  static const String removePriceList = "${apiBaseUrlTesting}delete_item";




  //offer Api Url
  static const String expertAllOffer = "${apiBaseUrlTesting}list_offer";
  static const String deleteOffer = "${apiBaseUrlTesting}delete_offer";
  static const String addOffer = "${apiBaseUrlTesting}add_offer";
}
