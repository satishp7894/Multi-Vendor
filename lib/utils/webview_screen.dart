import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../config/theme.dart';
import '../widgets/app_bar_title.dart';

class WebViewScreen extends StatefulWidget {

  final String title;
  final String webUrl;
  const WebViewScreen({Key? key, required this.title, required this.webUrl}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  bool? isFlag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ratingText,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "COUPONS",
      //     style: GoogleFonts.inriaSans(
      //         textStyle: const TextStyle(
      //             fontSize: 20,
      //             color: AppColors.appText,
      //             fontWeight: FontWeight.w700)),
      //   ),
      //   elevation: 1,
      // ),

      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: widget.title,flag: false,),
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height-88,
                child: WebViewPlus(
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    controller.loadUrl(widget.webUrl);
                  },
                  onProgress: (i){
                    print("object $i");
                    if(i == 100){
                      setState(() {
                        isFlag = false;
                      });
                    }
                  },
                ),
              ),
              isFlag! ? Container(
                  height: MediaQuery.of(context).size.height-88,
                  child: Center( child: CircularProgressIndicator(),))
                  : Container(),
            ],)


          ],
        ),
      ),
    );

  // return  WebviewScaffold(
  //     url: "https://fgglass.com/privacy-policy",
  //     appBar: new AppBar(
  //       title: new Text("${widget.title}"),
  //     ),
  //   );
  }
}
