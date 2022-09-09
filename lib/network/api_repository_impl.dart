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

class ApiRepositoryImpl extends ApiRepositoryInterface {
  static var client = http.Client();

  static String mainUrl = "http://proactii.com/MultiVendor/api/MultivendorApi";

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
  var deleteAddressUrl = "$mainUrl/deleteAddress";
  var getCategoryUrl = "$mainUrl/getCategory";
  var getSliderUrl = "$mainUrl/getSlider";
  var allProductsUrl = "$mainUrl/allProducts";
  var getBrandUrl = "$mainUrl/getBrand";
  var brandProductUrl = "$mainUrl/brandProduct";
  var productDetailsUrl = "$mainUrl/productDetails";
  var newProductUrl = "$mainUrl/newProduct";
  var bestSellerProductUrl = "$mainUrl/bestSellerProduct";
  var categoryProductUrl = "$mainUrl/categoryProduct";
  var getCartItemsUrl = "$mainUrl/getCartItems";
  var removeFromCartUrl = "$mainUrl/removeFromCart";
  var addToCartUrl = "$mainUrl/addToCart";
  var emptyCartUrl = "$mainUrl/emptyCart";
  var updateProductQtyUrl = "$mainUrl/updateProductQty";
  var addOrderUrl = "$mainUrl/addOrder";
  var orderHistoryUrl = "$mainUrl/orderHistory";
  var orderDetailUrl = "$mainUrl/orderDetail";
  var getOrderInvoiceUrl = "$mainUrl/getOrderInvoice";


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
  Future<RegisterCustomer?> registerCustomer(
      RegisterRequest registerRequest) async {
    print("url registerCustomerUrl $registerCustomerUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerName ${registerRequest.customerName}");
    print("url gender ${registerRequest.gender}");
    print("url email ${registerRequest.email}");
    print("url mobile ${registerRequest.mobile}");
    print("url password ${registerRequest.password}");
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(registerCustomerUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_name': registerRequest.customerName,
          'gender': registerRequest.gender,
          'email': registerRequest.email,
          'mobile': registerRequest.mobile,
          'password': registerRequest.password,
        });

        var decodedData = json.decode(response.body);
        print("registerCustomerUrl ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("registerCustomerUrl ${response.body}");
          return RegisterCustomer.fromJson(decodedData);
        } else {
          print("registerCustomerUrl else");
          print("registerCustomerUrl ${response.body}");
          return RegisterCustomer.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("registerCustomerUrl error ${e}");
        return RegisterCustomer(status: false, message: e.toString());
      }
    } else {
      return RegisterCustomer(
          status: false, message: AppConstants.noInternetConn);
    }
  }

  @override
  Future<CheckLogin?> checkLogin(LoginRequest login) async {
    print("url checkLogin $checkLoginUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url email ${login.email}");
    print("url password ${login.password}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(checkLoginUrl), body: {
          'secretkey': AppConstants.secretKey,
          'mobile_email': login.email,
          'password': login.password,
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
  Future<MainResponse?> updateCustomerProfile(
      RegisterRequest updateRequest, String customerId) async {
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
        });

        var decodedData = json.decode(response.body);
        print("updateCustomerProfile ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("updateCustomerProfile ${response.body}");
          return MainResponse.fromJson(decodedData);
        } else {
          print("updateCustomerProfile else");
          print("updateCustomerProfile ${response.body}");
          return MainResponse.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("updateCustomerProfile error ${e}");
        return MainResponse(status: false, message: e.toString());
      }
    } else {
      return MainResponse(status: false, message: AppConstants.noInternetConn);
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
  Future<MainResponse?> bestSellerProduct() async {
    print("url bestSellerProduct $bestSellerProductUrl");
    print("url secretKey ${AppConstants.secretKey}");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(bestSellerProductUrl), body: {
          'secretkey': AppConstants.secretKey,
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
  Future<MainResponse?> brandProduct(String brandId) async {
    print("url brandProduct $brandProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url brandId ${brandId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url brandProduct InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(brandProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'brand_id': brandId,
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
  Future<MainResponse?> productDetails(String productId) async {
    print("url productDetails $productDetailsUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url productId ${productId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url productDetails InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(productDetailsUrl), body: {
          'secretkey': AppConstants.secretKey,
          'product_id': productId,
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
  Future<CategoryProduct?> categoryProduct(String categoryId) async {
    print("url categoryProduct $categoryProductUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url categoryId ${categoryId}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url categoryProduct InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(categoryProductUrl), body: {
          'secretkey': AppConstants.secretKey,
          'category_id': categoryId,
        });

        var decodedData = json.decode(response.body);
        print("categoryProduct ['status'] ${decodedData['status']}");
        if (decodedData['status'] == true) {
          print("categoryProduct ${response.body}");
          return CategoryProduct.fromJson(decodedData);
        } else {
          print("categoryProduct else");
          print("categoryProduct ${response.body}");
          return CategoryProduct.fromJson(decodedData);
        }
      } on Exception catch (e) {
        print("categoryProduct error ${e}");
        return CategoryProduct(status: false, message: e.toString());
      }
    } else {
      print("categoryProduct  ${AppConstants.noInternetConn}");
      return CategoryProduct(
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

    bool result = await InternetConnectionChecker().hasConnection;
    print("url addAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(addAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'first_name': addressRequest.firstName,
          'last_name': addressRequest.lastName,
          'email': addressRequest.email,
          'mobile': addressRequest.mobile,
          'address': addressRequest.address,
          'locality': addressRequest.locality,
          'landmark': addressRequest.landmark,
          'city': addressRequest.city,
          'state': addressRequest.state,
          'pincode': addressRequest.pincode,
          'country': addressRequest.country,
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
  Future<MainResponse?> editAddress(
      AddressRequest addressRequest, String addressId) async {
    print("url editAddress $editAddressUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url addressId ${addressId}");
    print("url addressType ${addressRequest.addressType}");

    bool result = await InternetConnectionChecker().hasConnection;
    print("url editAddress InternetConnectionChecker ${result}");
    if (result == true) {
      try {
        var response = await http.post(Uri.parse(editAddressUrl), body: {
          'secretkey': AppConstants.secretKey,
          'address_id': addressId,
          'first_name': addressRequest.firstName,
          'last_name': addressRequest.lastName,
          'email': addressRequest.email,
          'mobile': addressRequest.mobile,
          'address': addressRequest.address,
          'locality': addressRequest.locality,
          'landmark': addressRequest.landmark,
          'city': addressRequest.city,
          'state': addressRequest.state,
          'pincode': addressRequest.pincode,
          'country': addressRequest.country,
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
  Future<MainResponse?> addOrder(
      String customerId, String productIds) async {
    print("url addOrder $addOrderUrl");
    print("url secretKey ${AppConstants.secretKey}");
    print("url customerId $customerId");
    print("url productIds $productIds");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(addOrderUrl), body: {
          'secretkey': AppConstants.secretKey,
          'customer_id': customerId,
          'product_id': productIds,
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
  Future<MainResponse?> orderDetail(
      String orderId) async {
    print("url orderDetail $orderDetailUrl ");
    print("url secretKey ${AppConstants.secretKey}");
    print("url orderId $orderId");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var response =
        await http.post(Uri.parse(orderDetailUrl), body: {
          'secretkey': AppConstants.secretKey,
          'order_id': orderId,
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
