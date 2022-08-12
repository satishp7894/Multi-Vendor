import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
class DefaultBTN extends StatelessWidget {
  DefaultBTN({this.btnText});
  final String? btnText;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Center(
          child: Text(
            btnText!,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}
