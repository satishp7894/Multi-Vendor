import 'package:eshoperapp/bindings/main_binding.dart';
import 'package:eshoperapp/pages/brand_product/brand_product_screen.dart';
import 'package:eshoperapp/pages/cart/cart_binding.dart';
import 'package:eshoperapp/pages/cart/cart_screen.dart';
import 'package:eshoperapp/pages/category/categories_binding.dart';
import 'package:eshoperapp/pages/category/category_products.dart';
import 'package:eshoperapp/pages/category_product/category_product_screen.dart';
import 'package:eshoperapp/pages/check_out/check_out_binding.dart';
import 'package:eshoperapp/pages/check_out/check_out_screen.dart';
import 'package:eshoperapp/pages/details/prodcut_details_screen.dart';
import 'package:eshoperapp/pages/details/product_details_binding.dart';

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
import 'package:eshoperapp/pages/profile/change_password_screen.dart';
import 'package:eshoperapp/pages/profile/edit_profile_screen.dart';
import 'package:eshoperapp/pages/profile/forget_password_screen.dart';
import 'package:eshoperapp/pages/profile/profile_binding.dart';
import 'package:eshoperapp/pages/shipping_address/add_shipping_address_screen.dart';
import 'package:eshoperapp/pages/shipping_address/shipping_address_screen.dart';
import 'package:eshoperapp/pages/shipping_address/shipping_address_binding.dart';
import 'package:eshoperapp/pages/splash/splash_binding.dart';
import 'package:eshoperapp/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
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
}

class Pages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      bindings: [LoginBinding(), MainBinding()],
    ),
    GetPage(
        name: Routes.landingHome,
        page: () => const LandingHome(),
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
        name: Routes.addShippingAddress,
        page: () =>  const AddShippingAddressScreen(),
        // bindings: [ShippingAddressBinding(), MainBinding()]
    ),
    GetPage(
        name: Routes.brandProduct,
        page: () => const BrandProductScreen(),
        // bindings: [BrandProductBinding(), MainBinding()]
    ),
    GetPage(
        name: Routes.cart,
        page: () => CartScreen(0,true),
        bindings: [MainBinding(), CartBinding()]),
    // GetPage(
    //     name: Routes.categoryProduct,
    //     page: () => const CategoryProductScreen(),
    //     // bindings: [MainBinding(), CategoriesBinding(), HomeBinding()]
    // ),
    GetPage(
        name: Routes.myOrder,
        page: () => const MyOrderScreen(),
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
        bindings: [MainBinding(),HomeBinding(),]),
    GetPage(
        name: Routes.editProfile,
        page: () =>  const EditProfileScreen(),
        bindings: [MainBinding(),HomeBinding(),]),
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
