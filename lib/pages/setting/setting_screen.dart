import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/pages/shipping_address/views/address_list_tile.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/app_bar_title.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool? isBool;
  bool isSwitched = false;
  var textValue = 'Switch is OFF';


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ratingText,


      // appBar: AppBar(
      //   elevation: 5,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Image.asset("assets/img/arrow_left.png",fit: BoxFit.fill,height: 20,width: 22,),
      //
      //     // Icon(
      //     //   Icons.arrow_back,
      //     //   color: Style.Colors.appColor,
      //     //   size: 30,
      //     // ),
      //     onPressed: () =>  Get.back(),
      //   ),
      //   title: Text("${AppConstants.setting}", style: GoogleFonts.inriaSans(textStyle: TextStyle(color:AppColors.appText,fontSize: 20,fontWeight: FontWeight.w700 ))),
      // ),
      body:SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: AppConstants.setting,flag: false,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                Container(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notifications",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black))),
                        // Switch(
                        //   onChanged: toggleSwitch,
                        //   value: isSwitched,
                        //   activeColor: Colors.white,
                        //   activeTrackColor: AppColors.appRed,
                        //   inactiveThumbColor: Colors.white,
                        //   inactiveTrackColor: Colors.grey,
                        // )

                        FlutterSwitch(
                          value: isSwitched,
                          height: 24.0,
                          width: 48.0,
                          activeColor: AppColors.appRed,
                          inactiveColor: AppColors.toggleBg,
                          toggleSize: 17.0,
                          padding: 3.0,
                          borderRadius: 20.0,
                          onToggle: (val) {
                            setState(() {
                              isSwitched = val;
                            });
                          },
                        ),
                        // Container(
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //     "Value: $isSwitched",
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                      color: AppColors.white,child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Delete Account",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black))),
                      ))
              ],),
            ),
          ],
        ),
      ),



    );
  }
  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
}
