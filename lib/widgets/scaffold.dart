import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              elevation: 5,
              backgroundColor: Colors.white,
              title: Text(
                title!,
                style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.w500),
              ),
              leading: leading != false ?InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back,color: Colors.red,size: 35)):null,
              actions: [
                InkWell(
                  onTap: (){
                    searchOnTab!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFFFC7663),
                      size: 35,

                    ),
                  ),
                )
              ],
            )
          : appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
