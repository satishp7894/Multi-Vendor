import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DefaultBTN extends StatelessWidget {
  DefaultBTN({this.btnText});
  final String? btnText;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            color: AppColors.appRed
            // gradient: LinearGradient(
            //     colors: [Colors.redAccent, Colors.orange],
            //     begin: Alignment.topLeft,
            //     end: Alignment.bottomRight)
        ),
        child: Center(
          child: Text(
            btnText!.toUpperCase(),
            style: GoogleFonts.inriaSans(
              textStyle: const TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
