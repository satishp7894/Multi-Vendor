import 'package:eshoperapp/bindings/main_binding.dart';
import 'package:eshoperapp/pages/brand_product/brand_product_screen.dart';
import 'package:eshoperapp/pages/cart/cart_binding.dart';
import 'package:eshoperapp/pages/cart/cart_screen.dart';
import 'package:eshoperapp/pages/category/categories_binding.dart';
import 'package:eshoperapp/pages/category_product/filter_screen.dart';
import 'package:eshoperapp/pages/check_out/check_out_binding.dart';
import 'package:eshoperapp/pages/check_out/check_out_screen.dart';
import 'package:eshoperapp/pages/choose_your_store/choose_your_store_screen.dart';
import 'package:eshoperapp/pages/coupons/coupons_screen.dart';

// import 'package:eshoperapp/pages/details/product_details_binding.dart';
// import 'package:eshoperapp/pages/details/product_details_screen.dart';
import 'package:eshoperapp/pages/landing_home/home_binding.dart';
import 'package:eshoperapp/pages/landing_home/landing_home.dart';

// import 'package:eshoperapp/pages/landing_home/home_binding.dart';
// import 'package:eshoperapp/pages/landing_home/landing_home.dart';
import 'package:eshoperapp/pages/login/login_binding.dart';
import 'package:eshoperapp/pages/login/login_screen.dart';
import 'package:eshoperapp/pages/myorder/my_order_screen.dart';
import 'package:eshoperapp/pages/myorder/myorder_binding.dart';
import 'package:eshoperapp/pages/myorder/order_details_screen.dart';
import 'package:eshoperapp/pages/on_boarding/on_boarding1.dart';
import 'package:eshoperapp/pages/otp/otp_screen.dart';
import 'package:eshoperapp/pages/payment/payment_screen.dart';
import 'package:eshoperapp/pages/profile/change_password_screen.dart';
import 'package:eshoperapp/pages/profile/edit_profile_screen.dart';
import 'package:eshoperapp/pages/profile/forget_password_screen.dart';
import 'package:eshoperapp/pages/profile/help_center_screen.dart';
import 'package:eshoperapp/pages/register/register_binding.dart';
import 'package:eshoperapp/pages/saved_card/add_cards_screen.dart';
import 'package:eshoperapp/pages/search/search_screen.dart';
import 'package:eshoperapp/pages/setting/setting_screen.dart';
import 'package:eshoperapp/pages/shipping_address/add_shipping_address_screen.dart';
import 'package:eshoperapp/pages/shipping_address/shipping_address_screen.dart';
import 'package:eshoperapp/pages/splash/splash_binding.dart';
import 'package:eshoperapp/pages/splash/splash_screen.dart';
import 'package:eshoperapp/pages/wishlist/wishlist_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/categories.dart';
import '../pages/category_product/categoty_product_list_screen.dart';
import '../pages/notofication/notification_screen.dart';
import '../pages/on_boarding/on_boarding2.dart';
import '../pages/on_boarding/on_boarding3.dart';
import '../pages/otp/otp_screen1.dart';
import '../pages/register/register_screen.dart';
import '../pages/saved_card/saved_card_screen.dart';
import '../pages/setting/setting_binding.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String landingHome = '/landingHome';
  static const String productDetails = '/productDetails';
  static const String cart = '/cart';
  static const String myOrder = '/myOrder';
  static const String changePassword = '/changePassword';
  static const String forgetPassword = '/forgetPassword';
  static const String editProfile = '/editProfile';
  static const String brandProduct = '/brandProduct';
  static const String myOrderDetails = '/myOrderDetails';
  static const String checkOut = '/checkOut';
  static const String shippingAddress = '/shippingAddress';
  static const String addShippingAddress = '/addShippingAddress';
  static const String imageScreen = '/imageScreen';
  static const String checkAccount = '/checkAccount';
  static const String sendCodeScreen = '/sendCodeScreen';
  static const String createNewPassword = '/createNewPassword';
  static const String setting = '/setting';
  static const String onBoarding1 = '/onBoarding1';
  static const String onBoarding2 = '/onBoarding2';
  static const String onBoarding3 = '/onBoarding3';
  static const String otpScreen = '/otpScreen';
  static const String otpScreen1 = '/otpScreen1';


  static const String savedCard = '/savedCard';
  static const String addCards = '/addCards';
  static const String helpCenter = '/helpCenter';
  static const String coupons = '/coupons';
  static const String searchScreen = '/searchScreen';
  static const String wishList = '/wishList';
  static const String notification = '/notification';
  static const String payment = '/payment';
  static const String chooseYourStoreScreen = '/chooseYourStoreScreen';
  static const String filterScreen = '/filterScreen';
  static const String categoryProductList = '/categoryProductList';
}

class Pages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.otpScreen,
        page: () => OTPScreen(),),
    GetPage(
      name: Routes.otpScreen1,
      page: () => const OTPScreen1(),),
    GetPage(
        name: Routes.onBoarding1,
        page: () => const OnBoarding1(),
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 2000)),
        transitionDuration: const Duration(milliseconds: 2000)),
    GetPage(
        name: Routes.categoryProductList,
        page: () => const CategoryProductListScreen(),
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 1000)),
        transitionDuration: const Duration(milliseconds: 200)),
    GetPage(
      name: Routes.onBoarding2,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
      page: () => const OnBoarding2(),
      // binding: OnBoarding2Binding()
    ),
    GetPage(
      name: Routes.onBoarding3,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 1000),
      page: () => const OnBoarding3(),
      // binding: OnBoarding2Binding()
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 2000),
      bindings: [
        HomeBinding(),MainBinding(),
        LoginBinding()
      ],
    ),

    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 2000),
      bindings: [
        RegisterBinding(),
        MainBinding(),
      ],
    ),
    GetPage(
      name: Routes.setting,
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 200),
      page: () => SettingsScreen(),
      bindings: [SettingBinding()],
    ),
    GetPage(
        name: Routes.landingHome,
        page: () => const LandingHome(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        bindings: [
          HomeBinding(),
          MainBinding(),
          CategoriesBinding(),
        ]),
    GetPage(
      name: Routes.shippingAddress,
      page: () => const ShippingAddressScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.searchScreen,
      page: () => const SearchScreen(),
        transition: Transition.downToUp,
        // transitionDuration: const Duration(milliseconds: 800),
        transitionDuration: const Duration(milliseconds: 200),
        bindings: [MainBinding()]
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.chooseYourStoreScreen,
      page: () => const ChooseYourStoreScreen(),
      bindings: [ HomeBinding(),MainBinding()]
    ),
    // GetPage(
    //   name: Routes.filterScreen,
    //   page: () => const FilterScreen(),
    //   // bindings: [ShippingAddressBinding(), MainBinding()]
    // ),
    GetPage(
      name: Routes.payment,
      page: () => const PaymentScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.wishList,
      page: () => const WishListScreen(),
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 800),
        transitionDuration: const Duration(milliseconds: 200),
      bindings: [MainBinding()]
    ),
    GetPage(
      name: Routes.addCards,
      page: () => const AddCardsScreen(),
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 200),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.savedCard,
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 200),
      page: () => const SavedCardScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.helpCenter,
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 200),
      page: () => const HelpCenterScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.coupons,
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 200),
      page: () => const CouponsScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.addShippingAddress,
      page: () => const AddShippingAddressScreen(),
      // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationScreen(),
      transition: Transition.rightToLeft,
      // transitionDuration: const Duration(milliseconds: 800),
        transitionDuration: const Duration(milliseconds: 200),
      bindings: [MainBinding()]
    ),
    GetPage(
      name: Routes.brandProduct,
      page: () => const BrandProductScreen(),
      // bindings: [BrandProductBinding(), MainBinding()]
    ),
    GetPage(
        name: Routes.cart,
        page: () => CartScreen(0, true),
        bindings: [MainBinding(), CartBinding()]),
    // GetPage(
    //     name: Routes.categoryProduct,
    //     page: () => const CategoryProductScreen(),
    //     // bindings: [MainBinding(), CategoriesBinding(), HomeBinding()]
    // ),
    GetPage(
        name: Routes.myOrder,
        page: () => const MyOrderScreen(),
        transition: Transition.rightToLeft,
        // transitionDuration: const Duration(milliseconds: 800),
        transitionDuration: const Duration(milliseconds: 200),
        bindings: [MainBinding(), MyOrderBinding()]),
    GetPage(
        name: Routes.myOrderDetails,
        page: () => const OrderDetaisScreen(),
        bindings: [MainBinding(), MyOrderBinding()]),
    GetPage(
        name: Routes.checkOut,
        page: () => const CheckOutScreen(),
        bindings: [MainBinding(), CheckOutBinding()]),
    GetPage(
        name: Routes.changePassword,
        page: () => ChangePasswordScreen(),
        bindings: [MainBinding()]),
    GetPage(
        name: Routes.forgetPassword,
        page: () => const ForgetPasswordScreen(),
        bindings: [
          MainBinding(),
          HomeBinding(),
        ]),
    GetPage(
        name: Routes.editProfile,
        page: () => const EditProfileScreen(),
        bindings: [
          MainBinding(),
          HomeBinding(),
        ]),
    //  yasle garda suru maa Yo controller  initiaze hunxa
    // GetPage(name: SajiloDokanRoutes.home, page: () => Home()),
    // GetPage(
    //     name: SajiloDokanRoutes.login,
    //     page: () => LoginScreen(),
    //     bindings: [LoginBinding(), MainBinding()],
    //     binding: LoginBinding()),
    // GetPage(
    //     name: SajiloDokanRoutes.landingHome,
    //     page: () => LandingHome(),
    //     binding: HomeBinding(),
    //     bindings: [
    //       MainBinding(),
    //       HomeBinding(),
    //       CategoriesBinding(),
    //       CartBinding()
    //     ]),
    // GetPage(
    //     name: SajiloDokanRoutes.productDetails,
    //     page: () => ProductDetailsScreen(),
    //     binding: ProductDetailsBinding(),
    //     bindings: [ProductDetailsBinding(), MainBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.cart,
    //     page: () => CartScreen(0),
    //     bindings: [MainBinding(), CartBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.categoryProduct,
    //     page: () => CategoryProducts(),
    //     bindings: [MainBinding(), CategoriesBinding(), HomeBinding()]),
    //
    // GetPage(
    //     name: SajiloDokanRoutes.imageScreen,
    //     page: () => ImageScreen(),
    //     bindings: [
    //       ProductDetailsBinding(),
    //     ]),
    // GetPage(
    //     name: SajiloDokanRoutes.checkAccount,
    //     page: () => CheckAccountScreen(),
    //     bindings: [MainBinding(), ForgotPasswordBinding()]),
    // GetPage(
    //     name: SajiloDokanRoutes.sendCodeScreen, page: () => SendCodeScreen()),
    // GetPage(
    //     name: SajiloDokanRoutes.createNewPassword,
    //     page: () => CreateNewPassword())
  ];
}
