import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const double titleFontSize = 34;
  static const double sidePadding = 16;
  static const double padding14 = 10;
  static const double labelPadding = 17;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 5;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const tile_width = 148.0;
  static const tile_height = 276.0;
}

class AppColors {
  static const appRed = Color(0xFFEE4B4C);
  static const categoryBG1 = Color(0xFFE4D6D2);
  static const categoryBG2 = Color(0xFFCBCBCD);
  static const categoryBG3 = Color(0xFFD6B499);
  static const categoryBG4 = Color(0xFF8E8F91);
  static const categoryBG5 = Color(0xFFF0F0F0);
  static const categoryBG6 = Color(0xFFE4B07E);
  static const categoryBG7 = Color(0xFFEBEBEB);
  static const categoryBG8 = Color(0xFFCBCFD1);
  static const categoryBG9 = Color(0xFF6A6763);
  static const categoryBG10 = Color(0xFF86838D);
  static const categoryText = Color(0xFF454545);

  static const shopBG1 = Color(0xFF7D7A72);


  static const discover1 = Color(0xFFF5B4D8);
  static const discover2 = Color(0xFFF0F1F3);
  static const discover3 = Color(0xFF88847A);
  static const discover4 = Color(0xFF7A7B78);
  static const discover6 = Color(0xFFE3E3E3);


  static const closeButtonText = Color(0xFF666666);
  static const appText = Color(0xFF1D2D3D);
  static const searchTitle = Color(0xFF545454);
  static const categoryDescription = Color(0xFF6C6C6C);
  static const appLightBlue = Color(0xFF477199);
  static const appText1 = Color(0xFF898989);
  static const appGreen = Color(0xFF21BD56);
  static const homeBg = Color(0xFF1E1E1E);
  static const tileLine = Color(0xFFE2E2E2);
  static const filterBottomBorder = Color(0xFFEAEAEA);
  static const brandTopTitle = Color.fromRGBO(138, 138, 138, 0.2);
  static const profileCircleBg = Color.fromRGBO(71, 113, 153, 0.2);
  static const filterBg = Color.fromRGBO(217, 217, 217, 0.2);
  static const selectedItem = Color.fromRGBO(238, 75, 76, 0.1);
  static const savedCardBorder = Color.fromRGBO(238, 75, 76, 0.5);
  static const aboutUsBg = Color.fromRGBO(137, 137, 137, 0.7);
  static const filterLine = Color.fromRGBO(137, 137, 137, 0.5);
  static const ratingValueContainer = Color.fromRGBO(225, 225, 225, 0.5);
  static const productDescription = Color.fromRGBO(0, 0, 0, 0.7);
  static const ratingText =  Color(0xFFF1F1F1);
  static const paymentOptionText =  Color(0xFF434343);
  static const toggleBg = Color(0xFFD9D9D9);
  static const line = Color(0xFF8A8A8A);
  static const off = Color(0xFFE31E24);
  static const appBg = Color(0xFFEAEDED);
  static const appBg1 = Color(0xFF1E1E1E);
  static const budgetBg = Color(0xFFFF9900);
  static const budgetUnderBg = Color(0xFFFFB672);
  static const bestSellingBorder = Color(0xFFD9D9D9);
  static const startBat = Color(0xFFE25D22);
  static const budgetBg1 = Color(0xFFF1E9FF);
  static const budgetBorder = Color(0xFF955EF4);
  static const validationBg = Color.fromRGBO(238, 75, 76, 0.2);
  static const validationBg1 = Color.fromRGBO(137, 137, 137, 0.2);
  static const finestFestiveFashion = Color.fromRGBO(238, 75, 76, 0.3);
  static const appLine = Color(0xFF898989);
  static const red = Color(0xFFDB3022);
  static const hintText = Color(0xFFBFBFBF);
  static const black = Color(0xFF000000);
  static const lightGray = Color(0xFF9B9B9B);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const lightGreyBg = Color(0xFFEEEEEE);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const success = Color(0xFF2AA952);
  static const green = Color(0xFF2AA952);
  static const Color appColor = const Color(0xFFF44336);
  static const Color mainColor = const Color(0xff191826);
  static const Color secondColor = const Color(0xff191826);
  static const Color grey = const Color(0xFFE5E5E5);
  // static const Color background = const Color(0xff191826);
  static const Color BottomNavbackground_ = const Color(0xff191832);
  static const Color titleColor = const Color(0x73000000);
  static const primaryGradient = const LinearGradient(
    colors: const [Color(0xFFf6501c), Color(0xFFff7e00)],
    stops: const [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const shopIndianGradient = const LinearGradient(
    colors: const [Color(0xFFFFFFFF), Color(0xFF030305)],
    // stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class CustomTextStyle {
  static get lowVisial => TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14);
  static get price => TextStyle(color: Colors.redAccent, fontSize: 14);
  static get title => TextStyle(color: Colors.black, fontSize: 16);
  static get headLine =>  TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static get appBarTitle =>  GoogleFonts.inriaSans(
      textStyle: const TextStyle(
          fontSize: 20,
          color: AppColors.appText,
          fontWeight: FontWeight.w700));

  static get label =>  GoogleFonts.inriaSans(
      textStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.searchTitle,
          fontWeight: FontWeight.w700));
  static get label14 =>  GoogleFonts.inriaSans(
      textStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.searchTitle,
          fontWeight: FontWeight.w700));

  static get cardNumber =>  GoogleFonts.inriaSans(
      textStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.black,
          fontWeight: FontWeight.bold));
  static get storeLabel =>  GoogleFonts.inriaSans(
      textStyle: const TextStyle(
          fontSize: 16,
          color: AppColors.black,
          fontWeight: FontWeight.w700));

}

class SajiloTheme {
  static ThemeData of(context) {
    return ThemeData(
        primaryColorLight: AppColors.lightGray,
      
        primarySwatch: Colors.red,
        bottomAppBarColor: AppColors.lightGray,
        backgroundColor: AppColors.background,
        dialogBackgroundColor: AppColors.backgroundLight,
        errorColor: AppColors.red,
        dividerColor: Colors.transparent,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: AppColors.black),
         ));
  }
}

class AppWidget {
  static void snacbar(String title) {
    Get.snackbar(title, '',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        borderRadius: 0,
        backgroundColor: Colors.black.withOpacity(0.8),
        isDismissible: true,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(5));
  }
}
