import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SajiloDokanScaffold extends StatelessWidget {
  final Color? background;
  final String? title;
  final bool? leading;
  final VoidCallback? searchOnTab;

  final Widget body;
  final AppBar? appBar;
  final int? bottomMenuIndex;
  final Widget? bottomNavigationBar;
  const SajiloDokanScaffold(
      {this.background,
      this.appBar,
        required this.leading,
        required this.searchOnTab,
      required this.title,
      required this.body,
      this.bottomMenuIndex,
      this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: title != null
          ? AppBar(
              // centerTitle: true,
              elevation: 1,
              backgroundColor: Colors.white,
              title: Text(
                title!,
                style: GoogleFonts.inriaSans(textStyle: TextStyle(color:AppColors.appText,fontSize: 20,fontWeight: FontWeight.w700 )),
              ),
              leading: leading != false ?InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,color: Colors.red,size: 35)):null,
              // actions: [
              //   InkWell(
              //     onTap: (){
              //       searchOnTab!();
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Icon(
              //         Icons.search,
              //         color: Color(0xFFFC7663),
              //         size: 35,
              //
              //       ),
              //     ),
              //   )
              // ],
            )
          : appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
