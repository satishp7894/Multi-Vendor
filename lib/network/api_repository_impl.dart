import 'dart:convert';

import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/address_request.dart';
import 'package:eshoperapp/models/cart.dart';
import 'package:eshoperapp/models/category_product.dart';
import 'package:eshoperapp/models/change_password_request.dart';
import 'package:eshoperapp/models/check_login.dart';
import 'package:eshoperapp/models/forget_password.dart';
import 'package:eshoperapp/models/get_slider.dart';
import 'package:eshoperapp/models/login_request.dart';
import 'package:eshoperapp/models/login_response.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/models/product_comment.dart';
import 'package:eshoperapp/models/register_customer.dart';
import 'package:eshoperapp/models/register_request.dart';
import 'package:eshoperapp/models/update_customer_password.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../models/country_and_state.dart';
import '../models/product_filter_oprion_model.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  static var client = http.Client();

  // static String mainUrl = "http://example.com/MultiVendor/api/MultivendorApi";
  static String mainUrl = "https://proactii.com/MultiVendor/api/MultivendorApi";
  static String countryMainUrl = "https://api.countrystatecity.in/v1";

  // final String secretKey = '12!@34#\$5%';
  // String secretKey = r'12!@34#$5%';

  var checkCustomerMobileEmailUrl = "$mainUrl/checkCustomerMobileEmail";
  var registerCustomerUrl = "$mainUrl/registerCustomer";
  var checkLoginUrl = "$mainUrl/checkLogin";
  var forgetPasswordUrl = "$mainUrl/forgetPassword";
  var customerProfileUrl = "$mainUrl/customerProfile";
  var updateCustomerProfileUrl = "$mainUrl/updateCustomerProfile";
  var updateCustomerPasswordUrl = "$mainUrl/updateCustomerPassword";
  var getAddressUrl = "$mainUrl/getAddress";
  var addAddressUrl = "$mainUrl/addAddress";
  var editAddressUrl = "$mainUrl/editAddress";
  var changeDeliveryAddressUrl = "$mainUrl/changeDeliveryAddress";
  var deleteAddressUrl = "$mainUrl/deleteAddress";
  var getCategoryUrl = "$mainUrl/getCategory";
  var getSliderUrl = "$mainUrl/getSlider";
  var allProductsUrl = "$mainUrl/allProducts";
  var getBrandUrl = "$mainUrl/getBrand";
  var brandProductUrl = "$mainUrl/brandProduct";
  var getAllBrandUrl = "$mainUrl/getAllBrand";
  var productDetailsUrl = "$mainUrl/productDetails";
  var getSimilarProductUrl = "$mainUrl/getSimilarProduct";
  var newProductUrl = "$mainUrl/newProduct";
  var bestSellerProductUrl = "$mainUrl/bestSellerProduct";
  var getRecentsearchkeywordsUrl = "$mainUrl/getRecentsearchkeywords";
  var getProductFilterColorUrl = "$mainUrl/getProductFilterColor";
  var getChildCategoryUrl = "$mainUrl/getChildCategory";
  var getProductFilterOptionUrl = "$mainUrl/getProductFilterOption";
  var getNewLaunchUrl = "$mainUrl/getNewLaunch";
  var getHomeCategoryUrl = "$mainUrl/getHomeCategory";
  var getTrendingBrandsUrl = "$mainUrl/getTrendingBrands";
  var getProductByAttributeAndCategoryUrl = "$mainUrl/getProductByAttributeAndCategory";
  var getCategoryProductWithOffersUrl = "$mainUrl/getCategoryProductwithOffers";
  var searchBykeywordsUrl = "$mainUrl/searchBykeywords";
  var productSortByWithFilterUrl = "$mainUrl/productSortByWithFilter";
  var categoryProductUrl = "$mainUrl/categoryProduct";
  var getOfferWithCategoryListUrl = "$mainUrl/getOfferwithCategoryList";
  var getCartItemsUrl = "$mainUrl/getCartItems";
  var removeFromCartUrl = "$mainUrl/removeFromCart";
  var addToCartUrl = "$mainUrl/addToCart";
  var addToWishlistUrl = "$mainUrl/addToWishlist";
  var moveToWishlistUrl = "$mainUrl/moveToWishlist";
  var removeWishlistItemUrl = "$mainUrl/removeWishlistItem";
  var removeRecentSearchUrl = "$mainUrl/removeRecentSearch";
  var getWishlistItemUrl = "$mainUrl/getWishlistItem";
  var getFrequentSearchUrl = "$mainUrl/getFrequentSearch";
  var emptyCartUrl = "$mainUrl/emptyCart";
  var updateProductQtyUrl = "$mainUrl/updateProductQty";
  var addProductRatingReviewsUrl = "$mainUrl/addProductRatingReviews";
  var getProductFromVariantUrl = "$mainUrl/getProductFromVariant";
  var addOrderUrl = "$mainUrl/addOrder";
  var orderHistoryUrl = "$mainUrl/orderHistory";
  var searchInOrderUrl = "$mainUrl/searchInOrder";
  var getOrderByFilterUrl = "$mainUrl/getOrderByFilter";
  var orderDetailUrl = "$mainUrl/orderDetail";
  var getOrderInvoiceUrl = "$mainUrl/getOrderInvoice";
  var getCountryUrl = "$countryMainUrl/countries";

  var getHomeDesignerUrl = "$mainUrl/getHomeDesigner";
  var getCategoryByAgeUrl = "$mainUrl/getCategoryByAge";
  var getFestiveFashionUrl = "$mainUrl/getFestiveFashion";
  var getCouponListUrl = "$mainUrl/getCouponList";
  var submitHelpCenterUrl = "$mainUrl/submitHelpCenter";


  static Uri getUrl(String endpoind, {String baseUrl = 'fakestoreapi.com'}) {
    var url = Uri.https('${(baseUrl)}', '${(endpoind)}', {'q': '{https}'});
    return url;
  }

  static Uri getMainUrl(String endpoind,
      {String baseUrl = 'onlinehatiya.herokuapp.com'}) {
    var url = Uri.https('${(baseUrl)}', '${(endpoind)}', {'q': '{https}'});
    return url;
  }

  static Map<String, String> header(String token) => {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };

  @override
  Future<CheckLogin?> registerCustomer(
      RegisterRequest registerRequest) async {
    print("url registerCustomerUrl $registerCustomerUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerName ${registerRequest.customerName}");
    // print("url gender ${registerRequest.gender}");
    print("url email ${registerRequest.email}");
    print("url mobile ${registerRequest.mobile}");
    // print("url password ${registerRequest.password}");
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(registerCustomerUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_name': registerRequest.customerName,
          // 'gender': registerRequest.gender,
          'email': registerRequest.email,
          'mobile': registerRequest.mobile,
          // 'password': registerRequest.password,
        });

        var decodedData = json.decode(response.body);
        print("registerCustomerUrl ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("registerCustomerUrl ${response.body}");
          return CheckLogin.fromJson(decodedData);
        } else {
          print("registerCustomerUrl else");
          print("registerCustomerUrl ${response.body}");
          return CheckLogin.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("registerCustomerUrl error ${e}");
        return CheckLogin(status: false, message: e.toString());
      }
    } else {
      return CheckLogin(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<CheckLogin?> checkLogin(LoginRequest login) async {
    print("url checkLogin $checkLoginUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url email ${login.email}");
    // print("url password ${login.password}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(checkLoginUrl), body: {
          'secretkey': AppConstants.secretKey,
          'mobile_email': login.email,
          // 'password': login.password,
        });

        var decodedData = json.decode(response.body);
        print("checkLogin ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("checkLogin ${response.body}");
          return CheckLogin.fromJson(decodedData);
        } else {
          print("checkLogin else");
          print("checkLogin ${response.body}");
          return CheckLogin.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("checkLogin error ${e}");
        return CheckLogin(status: false, message: e.toString());
      }
    } else {
      return CheckLogin(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<UpdateCustomerPassword?> updateCustomerPassword(
      ChangePasswordRequest changePasswordRequest, String customerId) async {
    print("url updateCustomerPassword $updateCustomerPasswordUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url newPassword ${changePasswordRequest.newPassword}");
    print("url currentPassword ${changePasswordRequest.currentPassword}");
    print("url confirmPasswod ${changePasswordRequest.confirmPasswod}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
            await http.post(Uri.parse(updateCustomerPasswordUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'current_password': changePasswordRequest.currentPassword,
          'new_password': changePasswordRequest.newPassword,
          'confirm_password': changePasswordRequest.confirmPasswod,
        });

        var decodedData = json.decode(response.body);
        print("updateCustomerPassword ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("updateCustomerPassword ${response.body}");
          return UpdateCustomerPassword.fromJson(decodedData);
        } else {
          print("updateCustomerPassword else");
          print("updateCustomerPassword ${response.body}");
          return UpdateCustomerPassword.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("updateCustomerPassword error ${e}");
        return UpdateCustomerPassword(status: false, message: e.toString());
      }
    } else {
      return UpdateCustomerPassword(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<ForgetPassword?> forgetPassword(String email) async {
    print("url forgetPasswordUrl $forgetPasswordUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url email ${email}");
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(forgetPasswordUrl), body: {
          'secretkey': AppConstants.secretKey,
          'email': email,
        });

        var decodedData = json.decode(response.body);
        print("forgetPasswordUrl ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("forgetPasswordUrl ${response.body}");
          return ForgetPassword.fromJson(decodedData);
        } else {
          print("forgetPasswordUrl else");
          print("forgetPasswordUrl ${response.body}");
          return ForgetPassword.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("forgetPasswordUrl error ${e}");
        return ForgetPassword(status: false, message: e.toString());
      }
    } else {
      return ForgetPassword(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> customerProfile(String customerId) async {
    print("url customerProfile $customerProfileUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(customerProfileUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("customerProfile ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("customerProfile ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("customerProfile else");
          print("customerProfile ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("customerProfile error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<CheckLogin?> updateCustomerProfile(
      RegisterRequest updateRequest, String customerId, String alterNateMobile, String birthDate) async {
    print("url updateCustomerProfile $updateCustomerProfileUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url customerName ${updateRequest.customerName}");
    print("url gender ${updateRequest.gender}");
    print("url email ${updateRequest.email}");
    print("url mobile ${updateRequest.mobile}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
            await http.post(Uri.parse(updateCustomerProfileUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'customer_name': updateRequest.customerName,
          'gender': updateRequest.gender,
          'email': updateRequest.email,
          'mobile': updateRequest.mobile,
              'alternate_mobile': alterNateMobile,
              'birth_date': birthDate,
        });

        var decodedData = json.decode(response.body);
        print("updateCustomerProfile ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("updateCustomerProfile ${response.body}");
          return CheckLogin.fromJson(decodedData);
        } else {
          print("updateCustomerProfile else");
          print("updateCustomerProfile ${response.body}");
          return CheckLogin.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("updateCustomerProfile error ${e}");
        return CheckLogin(status: false, message: e.toString());
      }
    } else {
      return CheckLogin(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<GetSlider?> getSlider() async {
    print("url getSlider $getSliderUrl");
    print("url secretKey ${AppConstants.secretKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getSliderUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("getSlider ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getSlider ${response.body}");
          return GetSlider.fromJson(decodedData);
        } else {
          print("getSlider else");
          print("getSlider ${response.body}");
          return GetSlider.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getSlider error ${e}");
        return GetSlider(status: false, message: e.toString());
      }
    } else {
      return GetSlider(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> allProducts() async {
    print("url allProducts $allProductsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(allProductsUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("allProducts ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("allProducts ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("allProducts else");
          print("allProducts ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("allProducts error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> newProducts() async {
    print("url newProducts $newProductUrl");
    print("url secretKey ${AppConstants.secretKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(newProductUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("newProducts ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("newProducts ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("newProducts else");
          print("newProducts ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("newProducts error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getBrand() async {
    print("url getBrand $getBrandUrl");
    print("url secretKey ${AppConstants.secretKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url getBrand InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getBrandUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("getBrand ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getBrand else");
          print("getBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getBrand error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("getBrand  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> bestSellerProduct(String chooseType, String customerId) async {
    print("url bestSellerProduct $bestSellerProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("chooseType ${chooseType}");
    print("customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(bestSellerProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("bestSellerProduct ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("bestSellerProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("bestSellerProduct else");
          print("bestSellerProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("bestSellerProduct error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getRecentsearchkeywords(String chooseType, String customerId) async {
    print("url getRecentsearchkeywords $getRecentsearchkeywordsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("chooseType ${chooseType}");
    print("customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getRecentsearchkeywordsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getRecentsearchkeywords ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getRecentsearchkeywords ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getRecentsearchkeywords else");
          print("getRecentsearchkeywords ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getRecentsearchkeywords error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> chooseColor(String? chooseType) async {
    print("url chooseColor $getProductFilterColorUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url secretKey ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getProductFilterColorUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("chooseColor ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("chooseColor ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("chooseColor else");
          print("chooseColor ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("chooseColor error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getChildCategory(String? chooseType) async {
    print("url getChildCategory $getChildCategoryUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getChildCategoryUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getChildCategory ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getChildCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getChildCategory else");
          print("getChildCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getChildCategory error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getProductFilterOption(String? categoryId,String brandId,String chooseType) async {
    print("url getProductFilterOption $getProductFilterOptionUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url categoryId ${categoryId}");
    print("url brandId ${brandId}");
    print("url chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getProductFilterOptionUrl), body: {
          'secretkey': AppConstants.secretKey,
          'category_id': categoryId,
          'brand_id': brandId,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getProductFilterOption ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getProductFilterOption ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getProductFilterOption else");
          print("getProductFilterOption ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getProductFilterOption error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }



  @override
  Future<MainResponse?> getNewLaunch(String? chooseType) async {
    print("url getNewLaunch $getNewLaunchUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getNewLaunchUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getNewLaunch ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("chooseColor ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getNewLaunch else");
          print("getNewLaunch ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getNewLaunch error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getHomeDesigner(String? chooseType) async {
    print("url getHomeDesigner $getHomeDesignerUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getHomeDesignerUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getHomeDesigner ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getHomeDesigner ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getHomeDesigner else");
          print("getHomeDesigner ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getHomeDesigner error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getCategoryByAge(String? chooseType) async {
    print("url getCategoryByAge $getCategoryByAgeUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getCategoryByAgeUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getCategoryByAge ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getCategoryByAge ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getCategoryByAge else");
          print("getCategoryByAge ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getCategoryByAge error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getFestiveFashion(String? chooseType) async {
    print("url getFestiveFashion $getFestiveFashionUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getFestiveFashionUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getFestiveFashion ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getFestiveFashion ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getFestiveFashion else");
          print("getFestiveFashion ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getFestiveFashion error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getCouponList(String? couponId) async {
    print("url getCouponList $getCouponListUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" couponId ${couponId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getCouponListUrl), body: {
          'secretkey': AppConstants.secretKey,
          'coupon_id': couponId,
        });

        var decodedData = json.decode(response.body);
        print("getCouponList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getCouponList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getCouponList else");
          print("getCouponList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getCouponList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getHomeCategory(String? chooseType) async {
    print("url getHomeCategoryUrl $getHomeCategoryUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getHomeCategoryUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getHomeCategoryUrl ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("chooseColor ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getHomeCategoryUrl else");
          print("getHomeCategoryUrl ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getHomeCategoryUrl error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getTrendingBrand(String? chooseType) async {
    print("url getTrendingBrand $getTrendingBrandsUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getTrendingBrandsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("getTrendingBrand ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getTrendingBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getTrendingBrand else");
          print("getTrendingBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("chooseColor error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getProductByAttributeAndCategory(String? id,String? chooseType,String customerId) async {
    print("url chooseColor $getProductByAttributeAndCategoryUrl");
    print(" secretKey ${AppConstants.secretKey}");
    print(" chooseType ${chooseType}");
    print(" customerId ${customerId}");
    print(" id ${id}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getProductByAttributeAndCategoryUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
          'attribute_id': id,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getProductByAttributeAndCategory ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getProductByAttributeAndCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getProductByAttributeAndCategory else");
          print("getProductByAttributeAndCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("chooseColor error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getCategoryProductWithOffers(String offerId,String categoryID,String customerId) async {
    print("url getCategoryProductWithOffers $getCategoryProductWithOffersUrl");
    print("secretKey ${AppConstants.secretKey}");
    print("offerId ${offerId}");
    print("categoryID ${categoryID}");
    print("customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getCategoryProductWithOffersUrl), body: {
          'secretkey': AppConstants.secretKey,
          'offer_id': offerId,
          'category_id': categoryID,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getCategoryProductWithOffers ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getCategoryProductWithOffers ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getCategoryProductWithOffers else");
          print("getCategoryProductWithOffers ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("chooseColor error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> searchBykeywords(String keyword,String customerId,String chooseType) async {
    print("url searchBykeywords $searchBykeywordsUrl");
    print("secretKey ${AppConstants.secretKey}");
    print("keyword ${keyword}");
    print("customerId ${customerId}");
    print("chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(searchBykeywordsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'keyword': keyword,
          'customer_id': customerId,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("searchBykeywords ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("searchBykeywords ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("searchBykeywords else");
          print("searchBykeywords ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("searchBykeywords error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> productSortByWithFilter(String categoryId,String shorBy,dynamic flutterOption,String customerId, String gender, String chooseCode,String tag,String mimPrice,String maxPrice) async {
    print("url productSortByWithFilter $productSortByWithFilterUrl");
    print("secretKey ${AppConstants.secretKey}");
    print("categoryId ${categoryId}");
    print("shorBy ${shorBy}");
    print("flutterOption ${flutterOption}");
    print("customerId ${customerId}");
    print("gender ${gender}");
    print("chooseCode ${chooseCode}");
    print("tag ${tag}");
    print("mimPrice ${mimPrice}");
    print("maxPrice ${maxPrice}");


    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var params = {
          'secretkey': AppConstants.secretKey,
          'category_id': categoryId,
          'sort_by': shorBy,
          'filter_option': flutterOption.toString(),
          'customer_id': customerId,
          'tag': tag,
          'gender': gender,
          'cat_short_code': chooseCode,
          'min_price': mimPrice,
          'max_price': maxPrice,

        };
        var response = await http.post(Uri.parse(productSortByWithFilterUrl), body: params,
            // ,headers: {'Content-type': 'application/json'}
        );

        var decodedData = json.decode(response.body);
        print("productSortByWithFilter ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("productSortByWithFilter ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("productSortByWithFilter else");
          print("productSortByWithFilter ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("productSortByWithFilter error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getCategory() async {
    print("url getCategory $getCategoryUrl");
    print("url secretKey ${AppConstants.secretKey}");
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getCategoryUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("getCategory ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getCategory else");
          print("getCategory ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getCategory error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getAllBrand() async {
    print("url getAllBrand $getAllBrandUrl");
    print("url secretKey ${AppConstants.secretKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url getAllBrand InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getAllBrandUrl), body: {
          'secretkey': AppConstants.secretKey,
        });

        var decodedData = json.decode(response.body);
        print("getAllBrand ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getAllBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getAllBrand else");
          print("getAllBrand ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getAllBrand error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("getAllBrand  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> brandProduct(String brandId,String customerId,String chooseType) async {
    print("url brandProduct $brandProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url brandId ${brandId}");
    print("url customerId ${customerId}");
    print("url chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url brandProduct InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(brandProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'brand_id': brandId,
          'customer_id': customerId,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("brandProduct ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("brandProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("brandProduct else");
          print("brandProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("brandProduct error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("brandProduct  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> productDetails(String productId,String variantCode, String customerId) async {
    print("url productDetails $productDetailsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url productId ${productId}");
    print("url customerId ${customerId}");
    print("url variantCode ${variantCode}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url productDetails InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(productDetailsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'product_id': productId,
          'variant_code': variantCode,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("productDetails ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("productDetails ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("productDetails else");
          print("productDetails ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("productDetails error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("productDetails  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getSimilarProduct(String productId,String categoryId,String customerId) async {
    print("url getSimilarProduct $getSimilarProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url productId ${productId}");
    print("url categoryId ${categoryId}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url getSimilarProduct InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getSimilarProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'product_id': productId,
          'category_id': categoryId,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getSimilarProduct ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getSimilarProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getSimilarProduct else");
          print("getSimilarProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getSimilarProduct error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("getSimilarProduct  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> categoryProduct(String categoryId,String customerId) async {
    print("url categoryProduct $categoryProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url categoryId ${categoryId}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url categoryProduct InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(categoryProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'category_id': categoryId,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("categoryProduct ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("categoryProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("categoryProduct else");
          print("categoryProduct ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("categoryProduct error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("categoryProduct  ${AppConstants.noInternetConn}");
      return MainResponse(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getOfferWithCategoryList(String? chooseType) async {
    print("url OfferWithCategoryList $getOfferWithCategoryListUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url chooseType ${chooseType}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url OfferWithCategoryList InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getOfferWithCategoryListUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': chooseType,
        });

        var decodedData = json.decode(response.body);
        print("OfferWithCategoryList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("OfferWithCategoryList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("OfferWithCategoryList else");
          print("OfferWithCategoryList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("OfferWithCategoryList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("OfferWithCategoryList  ${AppConstants.noInternetConn}");
      return MainResponse(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getAddress(String customerId) async {
    print("url getAddress $getAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url getAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getAddress ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getAddress else");
          print("getAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getAddress error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("getAddress  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> addAddress(
      AddressRequest addressRequest, String customerId) async {
    print("url addAddress $addAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId ${customerId}");
    print("url addressType ${addressRequest.addressType}");
    print("url setDefault ${addressRequest.setDefault}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url addAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(addAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'first_name': addressRequest.firstName,
          'last_name': addressRequest.lastName,
          // 'email': addressRequest.email,
          'mobile': addressRequest.mobile,
          'address': addressRequest.address,
          // 'locality': addressRequest.locality,
          // 'landmark': addressRequest.landmark,
          'city': addressRequest.city,
          'state': addressRequest.state,
          'pincode': addressRequest.pincode,
          'country': addressRequest.country,
          'set_default': addressRequest.setDefault.toString(),
          'address_type': addressRequest.addressType,
        });

        var decodedData = json.decode(response.body);
        print("addAddress ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("addAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("addAddress else");
          print("addAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("addAddress error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("addAddress  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> submitHelpCenter(
      String textIssue, String customerId) async {
    print("url submitHelpCenter $submitHelpCenterUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId ${customerId}");
    print("url textIssue ${textIssue}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url addAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(submitHelpCenterUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'text_issue': textIssue,
        });

        var decodedData = json.decode(response.body);
        print("submitHelpCenter ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("submitHelpCenter ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("submitHelpCenter else");
          print("submitHelpCenter ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("submitHelpCenter error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("submitHelpCenter  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> editAddress(
      AddressRequest addressRequest, String addressId, String customerId) async {
    print("url editAddress $editAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url addressId ${addressId}");
    print("url customerId ${customerId}");
    print("url addressType ${addressRequest.addressType}");
    print("url setDefault ${addressRequest.setDefault}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url editAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(editAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'address_id': addressId,
          'first_name': addressRequest.firstName,
          'last_name': addressRequest.lastName,
          // 'email': addressRequest.email,
          'mobile': addressRequest.mobile,
          'address': addressRequest.address,
          // 'locality': addressRequest.locality,
          // 'landmark': addressRequest.landmark,
          'city': addressRequest.city,
          'state': addressRequest.state,
          'pincode': addressRequest.pincode,
          'country': addressRequest.country,
          'set_default': addressRequest.setDefault.toString(),
          'address_type': addressRequest.addressType,
        });

        var decodedData = json.decode(response.body);
        print("editAddress ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("editAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("editAddress else");
          print("editAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("editAddress error $e");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("editAddress  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> deleteAddress(
      String customerId, String addressId) async {
    print("url deleteAddress $deleteAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url addressId ${addressId}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url deleteAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(deleteAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'address_id': addressId,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("deleteAddress ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("deleteAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("deleteAddress else");
          print("deleteAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("deleteAddress error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("deleteAddress  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> changeDeliveryAddress(
      String customerId, String addressId) async {
    print("url changeDeliveryAddress $changeDeliveryAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url addressId ${addressId}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url changeDeliveryAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(changeDeliveryAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'address_id': addressId,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("changeDeliveryAddress ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("changeDeliveryAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("changeDeliveryAddress else");
          print("changeDeliveryAddress ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("changeDeliveryAddress error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("changeDeliveryAddress  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }




  @override
  Future<MainResponse?> getCartItems(String customerId) async {
    print("url getCartItems $getCartItemsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId ${customerId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url getCartItems InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(getCartItemsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getCartItems ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getCartItems ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getCartItems else");
          print("getCartItems ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getCartItems error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      print("getCartItems  ${AppConstants.noInternetConn}");
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> updateProductQty(
       String customerId,String productId,String quantity) async {
    print("url updateProductQty $updateProductQtyUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");
    print("url quantity ${quantity}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(updateProductQtyUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'quantity': quantity,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("updateProductQty ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("updateProductQty ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("updateProductQty else");
          print("updateProductQty ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("updateProductQty error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> addProductRatingReviews(
      String productId,String customerId,String customerName,String starRate,String reviewContent,String reviewTitle) async {

    print("url addProductRatingReviews $addProductRatingReviewsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url productId ${productId}");
    print("url customerId $customerId");
    print("url customerName ${customerName}");
    print("url starRate ${starRate}");
    print("url reviewContent ${reviewContent}");
    print("url reviewTitle ${reviewTitle}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(addProductRatingReviewsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'product_id': productId,
          'customer_id': customerId,
          'customer_name': customerName,
          'star_rate': starRate,
          'review_content': reviewContent,
          'review_title': reviewTitle,
        });

        var decodedData = json.decode(response.body);
        print("addProductRatingReviews ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("addProductRatingReviews ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("addProductRatingReviews else");
          print("addProductRatingReviews ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("addProductRatingReviews error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getProductFromVariant(
      String currentAttribute,String selectedAttribute,String variantCode) async {

    print("url getProductFromVariant $getProductFromVariantUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url currentAttribute ${currentAttribute}");
    print("url selectedAttribute $selectedAttribute");
    print("url variantCode ${variantCode}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(getProductFromVariantUrl), body: {
          'secretkey': AppConstants.secretKey,
          'current_attribute': currentAttribute,
          'selected_attribute': selectedAttribute,
          'variant_code': variantCode,
        });

        var decodedData = json.decode(response.body);
        print("getProductFromVariant ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getProductFromVariant ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getProductFromVariant else");
          print("getProductFromVariant ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getProductFromVariant error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> removeFromCart(
      String customerId,String productId) async {
    print("url removeFromCart $removeFromCartUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(removeFromCartUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("removeFromCart ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("removeFromCart ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("removeFromCart else");
          print("removeFromCart ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("removeFromCart error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> emptyCart(
      String customerId) async {
    print("url emptyCart $emptyCartUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(emptyCartUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("emptyCart ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("emptyCart ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("emptyCart else");
          print("emptyCart ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("emptyCart error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> addToCart(
      String customerId,String productId,String quantity) async {
    print("url addToCart $addToCartUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");
    print("url quantity ${quantity}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(addToCartUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'quantity': quantity,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("addToCart ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("updateProductQty ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("addToCart else");
          print("addToCart ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("addToCart error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> addToWishList(
      String customerId,String productId) async {
    print("url addToWishList $addToWishlistUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(addToWishlistUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("addToWishList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("addToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("addToWishList else");
          print("addToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("addToWishList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> moveToWishList(
      String customerId,String productId) async {
    print("url moveToWishList $moveToWishlistUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(moveToWishlistUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("moveToWishList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("moveToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("moveToWishList else");
          print("moveToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("moveToWishList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> removeToWishList(
      String customerId,String productId) async {
    print("url removeToWishList $removeWishlistItemUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productId ${productId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(removeWishlistItemUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("removeToWishList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("removeToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("removeToWishList else");
          print("removeToWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("removeToWishList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> removeRecentSearch(
      String customerId,String searchId) async {
    print("url removeRecentSearch $removeRecentSearchUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url searchId ${searchId}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(removeRecentSearchUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'search_id': searchId,
        });

        var decodedData = json.decode(response.body);
        print("removeRecentSearch ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("removeRecentSearch ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("removeRecentSearch else");
          print("removeRecentSearch ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("removeRecentSearch error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getWishList(
      String selectedCriteria,String customerId) async {
    print("url getWishList $getWishlistItemUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url selectedCriteria $selectedCriteria");
    print("url customerId $customerId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(getWishlistItemUrl), body: {
          'secretkey': AppConstants.secretKey,
          'cat_short_code': selectedCriteria,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("getWishList ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getWishList else");
          print("getWishList ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getWishList error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getFrequentSearch(
      String selectedCriteria,String customerId) async {
    print("url getFrequentSearch $getFrequentSearchUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url selectedCriteria $selectedCriteria");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(getFrequentSearchUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'cat_short_code': selectedCriteria,
        });

        var decodedData = json.decode(response.body);
        print("getFrequentSearch ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getFrequentSearch ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getFrequentSearch else");
          print("getFrequentSearch ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getFrequentSearch error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }
  @override
  Future<MainResponse?> addOrder(
      String customerId,String productID,String paymentType) async {
    print("url addOrder $addOrderUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url paymentType $paymentType");
    print("url productID $productID");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(addOrderUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productID,
          // 'payment_type': paymentType,
        });

        var decodedData = json.decode(response.body);
        print("addOrder ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("addOrder ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("addOrder else");
          print("addOrder ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("addOrder error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<List<CountryAndState>> countries() async {
    print("url countries $getCountryUrl");
    print("url countryAndStateKey ${AppConstants.countryAndStateKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.get(Uri.parse(getCountryUrl), headers: {
          'X-CSCAPI-KEY': AppConstants.countryAndStateKey!,
        });

        // List<CountryAndState> decodedData = json.decode(response.body);
        // print("countries ${response.body}");
        // List<CountryAndState> listCountries;
        //
        // listCountries = decodedData
        //     .map((CountryAndState data) => CountryAndState.fromJson(data.toJson()))
        //     .toList();
        //
        // print("countries toString ${listCountries.toString()}");
        //
        // return listCountries;


        //
        // final body = json.decode(response.body);
        // print("countries ${response.body}");
        // print("json.decode(response.body) ${json.decode(response.body)}");
        // List<CountryAndState> mstdebitur =
        // body.map((dynamic item) => CountryAndState.fromJson(item)).toList();
        // print("countries mstdebitur ${mstdebitur}");

        List<CountryAndState> listCountries;
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print("countries ${parsed.map<CountryAndState>((json) => CountryAndState.fromJson(json)).toList()}");
        listCountries = parsed.map<CountryAndState>((json) => CountryAndState.fromJson(json)).toList();
        print("countries list ${listCountries[0].name}");
        return listCountries;
        // return mstdebitur;
          // return List<CountryAndState?>.fromJson(decodedData);

      } on Exception catch (e) {



        print("countries error ${e}");
        List<CountryAndState> listCountries = [];
        return listCountries;
      }
    } else {
      List<CountryAndState> listCountries = [];
      return listCountries;
    }
  }


  @override
  Future<List<CountryAndState>> states(String countryCode) async {
    print("url states $countryMainUrl/countries/$countryCode/states");
    print("url countryAndStateKey ${AppConstants.countryAndStateKey}");
    print("url countryCode ${countryCode}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.get(Uri.parse("$countryMainUrl/countries/$countryCode/states"), headers: {
          'X-CSCAPI-KEY': AppConstants.countryAndStateKey!,
        });

        // var decodedData = json.decode(response.body);
        //
        //   print("states ${response.body}");
        // List<CountryAndState> listStates;
        // listStates = decodedData
        //     .map((data) => CountryAndState.fromJson(data))
        //     .toList();
        //
        // return listStates;
        print("response.body ${response.body}");
        List<CountryAndState> listStates;
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print("states ${parsed.map<CountryAndState>((json) => CountryAndState.fromJson(json)).toList()}");
        listStates = parsed.map<CountryAndState>((json) => CountryAndState.fromJson(json)).toList();
        // print("states list ${listStates[0].name}");
        return listStates;

      } on Exception catch (e) {
        print("states error ${e}");
        List<CountryAndState> listStates = [];
        return listStates;
      }
    } else {
      List<CountryAndState> listStates = [];
      return listStates;
    }
  }


  @override
  Future<MainResponse?> orderHistory(
      String customerId) async {
    print("url orderHistory $orderHistoryUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(orderHistoryUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
        });

        var decodedData = json.decode(response.body);
        print("orderHistory ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("orderHistory ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("orderHistory else");
          print("orderHistory ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("orderHistory error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> searchInOrder(
      String customerId ,String keyword,String status,String time) async {
    print("url searchInOrder $searchInOrderUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url keyword $keyword");
    print("url status $status");
    print("url time $time");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(searchInOrderUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'keyword': keyword,
          'status': status,
          'time': time,
        });

        var decodedData = json.decode(response.body);
        print("searchInOrder ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("searchInOrder ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("searchInOrder else");
          print("searchInOrder ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("searchInOrder error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }


  @override
  Future<MainResponse?> getOrderByFilter(
      String customerId ,String status, String time) async {
    print("url getOrderByFilter $getOrderByFilterUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url status $status");
    print("url time $time");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(getOrderByFilterUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'status': status,
          'time': time,
        });

        var decodedData = json.decode(response.body);
        print("getOrderByFilter ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getOrderByFilter ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getOrderByFilter else");
          print("getOrderByFilter ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getOrderByFilter error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> orderDetail(
      String orderId,String productId) async {
    print("url orderDetail $orderDetailUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url orderId $orderId");
    print("url productId $productId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(orderDetailUrl), body: {
          'secretkey': AppConstants.secretKey,
          'order_id': orderId,
          'product_id': productId,
        });

        var decodedData = json.decode(response.body);
        print("orderDetail ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("orderDetail ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("orderDetail else");
          print("orderDetail ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("orderDetail error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<MainResponse?> getOrderInvoice(
      String orderId) async {
    print("url getOrderInvoice $getOrderInvoiceUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url orderId $orderId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(getOrderInvoiceUrl), body: {
          'secretkey': AppConstants.secretKey,
          'order_id': orderId,
        });

        var decodedData = json.decode(response.body);
        print("getOrderInvoice ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("getOrderInvoice ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("getOrderInvoice else");
          print("getOrderInvoice ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("getOrderInvoice error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
    }
  }



  @override
  Future<LoginResponse?> register(RegisterRequest registerRequest) async {
    print('register');
    var result = await client.post(getMainUrl('/api/register/'), body: {
      "name": registerRequest.customerName,
      "email": registerRequest.email,
      "password": registerRequest.password
    });
    print('register');
    if (result.statusCode == 200) {
      var jsondata = result.body;
      print('Register');
      return loginResponseFromJson(jsondata);
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponse?> getUserFromToken(String token) async {
    var result = await client.get(getMainUrl('/api/user/profile/'), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('login');
      print(jsonData);
      return loginResponseFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<LoginResponse?> login(LoginRequest login) async {
    var result = await client.post(getMainUrl('/api/login/'),
        body: {'email': login.email, 'password': login.password});

    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('login');
      print(jsonData);
      return loginResponseFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<void> logout(String? token) async {
    print('removing token');
    return;
  }

  @override
  Future<List<Product>?> fetchingProdcut(String? token) async {
    var result = await client.get(getMainUrl('/api/products/'),
        headers: token != null ? header(token) : null);
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('Fetch product called');
      return productFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future getCategories() async {
    List<String> categoryListFromJson(String str) =>
        List<String>.from(json.decode(str).map((x) => x));

    var result = await client.get(getMainUrl('/api/category/'));

    var jsonData = result.body;
    print('Get Category List called');

    if (result.statusCode == 200) {
      return categoryListFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<Product>?> getCategorieProduct(String? categoryName) async {
    var result = await client.post(getMainUrl('/api/category/'),
        body: {"category_name": "$categoryName"});
    if (result.statusCode == 200) {
      var jsonData = result.body;

      print('CategoryProducts call');

      return productFromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  Future<List<Cart>?> getCartList(String? token) async {
    var result = await client.get(getMainUrl('/api/carts/'),
        headers: token != null ? header(token) : null);
    if (result.statusCode == 200) {
      var jsonData = result.body;
      print('getCartList');

      return cartFromJson(jsonData);
    } else {
      return null;
    }
  }

  // @override
  // Future<bool> addToCart(String token, int? id) async {
  //   var result = await client.post(getMainUrl('/api/carts/'), headers: {
  //     "Accept": "application/json",
  //     "Authorization": "Bearer $token"
  //   }, body: {
  //     "id": "$id"
  //   });
  //   if (result.statusCode == 200) {
  //     return true;
  //   }
  //   return false;
  // }

  @override
  Future<bool> deleteCart(String? token, int? id) async {
    var result = await client.post(getMainUrl('/api/deletecart/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> makeFavorite(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/makefavorite/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<ProductComment>?> getComments(String? token, int? id) async {
    var result = await client.get(getMainUrl('/api/comments/$id'),
        headers: token != null ? header(token) : null);
    var jsonData = result.body;
    // print(jsonData);
    if (result.statusCode == 200) {
      return productCommentFromJson(jsonData);
    } else
      return null;
  }

  @override
  Future<bool> dislikeComment(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/dislike/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    print(result);
    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> likeComment(String token, int? id) async {
    var result = await client.post(getMainUrl('/api/like/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id"
    });
    print(result.body);

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> addQuanity(String? token, int? id, int quantity) async {
    print('Add Quantity');
    print('$token, $id, $quantity');
    var result = await client.post(getMainUrl('/api/add-quantity/'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    }, body: {
      "id": "$id",
      "quantity": "$quantity"
    });
    print('Add Quantity');

    if (result.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<LoginResponse?> googleSignIn(String? idToken, String provider) async {
    var result =
        await client.post(getMainUrl('/social_auth/$provider/'), body: {
      "auth_token": idToken,
    });
    print('GoogleSignIn');
    if (result.statusCode == 200) {
      var jsondata = result.body;

      return loginResponseFromJson(jsondata);
    } else {
      return null;
    }
  }

  // @override
  // Future<bool> forgetPassword(String email) async {
  //   print(email);
  //   var result = await client
  //       .patch(getMainUrl('/api/forget-password'), body: {"email": "$email"});
  //
  //   print(result.body);
  //   if (result.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Future<String?> verifyForgetPasswordCode(String email, String otp) async {
    var result = await client.post(getMainUrl('/api/forget-password'),
        body: {"email": "$email", "otp": "$otp"});
    var data = result.body;
    var dd = jsonDecode(data);

    if (result.statusCode == 200) {
      return dd['token'];
    }
    return null;
  }

  @override
  Future<LoginResponse?> createNewPassword(
      String token, String newPassword) async {
    var queryParameters = {
      'q': '{https}',
      'token': '$token',
    };
    var uri = Uri.https(
      'onlinehatiya.herokuapp.com',
      '/api/change-password',
      queryParameters,
    );
    var result = await client.post(uri, body: {"new_password": "$newPassword"});
    print(newPassword);
    print(result.body);
    if (result.statusCode == 200) {
      var jsondata = result.body;
      print(jsondata);
      return loginResponseFromJson(jsondata);
    }
    return null;
  }
}
