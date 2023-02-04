

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

import '../models/country_and_state.dart';
import '../models/product_filter_oprion_model.dart';

abstract class ApiRepositoryInterface {
  Future<CheckLogin?> registerCustomer(RegisterRequest register);
  Future<CheckLogin?> checkLogin(LoginRequest login);
  Future<UpdateCustomerPassword?> updateCustomerPassword(ChangePasswordRequest changePasswordRequest,String customerId);
  Future<ForgetPassword?> forgetPassword(String email);
  Future<MainResponse?> customerProfile(String customerId);
  Future<CheckLogin?> updateCustomerProfile(RegisterRequest updateRequest,String customerId, String alterNateMobile, String birthDate);
  Future<GetSlider?> getSlider();
  Future<MainResponse?> bestSellerProduct(String chooseType, String customerId);
  Future<MainResponse?> getRecentsearchkeywords(String chooseType, String customerId);
  Future<MainResponse?> chooseColor(String? chooseType );
  Future<MainResponse?> getNewLaunch(String? chooseType);
  Future<MainResponse?> getTrendingBrand(String? chooseType);
  Future<MainResponse?> getOfferWithCategoryList(String? chooseType);
  Future<MainResponse?> getChildCategory(String? chooseType);
  Future<MainResponse?> getProductFilterOption(String? categoryId,String brandId,String chooseType);
  Future<MainResponse?> getProductByAttributeAndCategory(String? id ,String? chooseType,String customerId);
  Future<MainResponse?> getCategory();
  Future<MainResponse?> getBrand();
  Future<MainResponse?> getAllBrand();
  Future<MainResponse?> brandProduct(String brandId,String customerId,String chooseType);
  Future<MainResponse?> productDetails(String productId,String variantCode,String customerId);
  Future<MainResponse?> getSimilarProduct(String productId,String categoryId,String customerId);
  Future<MainResponse?> categoryProduct(String categoryID,String customerId);
  Future<MainResponse?> getCategoryProductWithOffers(String offerId,String categoryID,String customerId);
  Future<MainResponse?> searchBykeywords(String keyword,String customerId,String chooseType);
  Future<MainResponse?> productSortByWithFilter(String categoryId,String shorBy,dynamic flutterOption,String customerId, String gender, String chooseCode
      ,String tag,String mimPrice,String maxPrice);
  Future<MainResponse?> allProducts();
  Future<MainResponse?> newProducts();
  Future<LoginResponse?> getUserFromToken(String token);
  Future<MainResponse?> getCartItems(String customerId);
  Future<MainResponse?> updateProductQty(String customerId,String productId,String quantity);
  Future<MainResponse?> addProductRatingReviews(String productId,String customerId,String customerName,String starRate,String reviewContent,String reviewTitle);
  Future<MainResponse?> getProductFromVariant(String currentAttribute,String selectedAttribute,String variantCode);
  Future<MainResponse?> removeFromCart(String customerId,String productId);
  Future<MainResponse?> emptyCart(String customerId );
  Future<MainResponse?> addToCart(String customerId,String productId,String quantity);
  Future<MainResponse?> addToWishList(String customerId,String productId);
  Future<MainResponse?> moveToWishList(String customerId,String productId);
  Future<MainResponse?> removeToWishList(String customerId,String productId);
  Future<MainResponse?> removeRecentSearch(String customerId,String searchId);
  Future<MainResponse?> getWishList(String selectedCriteria,String customerId);
  Future<MainResponse?> getFrequentSearch(String selectedCriteria,String customerId);
  Future<MainResponse?> addOrder(String customerId,String productID,String paymentType);
  Future<MainResponse?> orderHistory(String customerId );
  Future<MainResponse?> searchInOrder(String customerId ,String keyword,String status,String time);
  Future<MainResponse?> getOrderByFilter(String customerId ,String status, String time);
  Future<MainResponse?> orderDetail(String orderId,String productId);
  Future<MainResponse?> getOrderInvoice(String orderId );

  Future<MainResponse?> getAddress(String customerId);
  Future<MainResponse?> addAddress(AddressRequest addressRequest, String customerId);
  Future<MainResponse?> editAddress(AddressRequest addressRequest, String addressId, String customerId);
  Future<MainResponse?> deleteAddress(String customerId, String addressId);
  Future<MainResponse?> changeDeliveryAddress(String customerId, String addressId);

  Future<List<CountryAndState>> countries( );
  Future<List<CountryAndState>> states(String countryCode );

  Future<LoginResponse?> login(LoginRequest login);
  Future<LoginResponse?> register(RegisterRequest register);

  Future<void> logout(String? token);
  Future<List<Product>?> fetchingProdcut(String? token);

  Future getCategories();
  Future<List<Product>?> getCategorieProduct(String? categoryName);
  Future<List<Cart>?> getCartList(String? token);
  // Future<bool> addToCart(String token, int? id);
  Future<bool> deleteCart(String? token, int? id);
  Future<bool> makeFavorite(String token, int? id);
  Future<List<ProductComment>?> getComments(String? token, int? id);
  Future<bool> likeComment(String token, int? id);
  Future<bool> dislikeComment(String token, int? id);
  Future<bool> addQuanity(String? token, int? id, int quantity);

  Future<LoginResponse?> googleSignIn(String? idToken, String provider);
  // Future<bool> forgetPassword(String email);
  Future<String?> verifyForgetPasswordCode(String email, String otp);
  Future<LoginResponse?> createNewPassword(String token, String newPassword);
}
