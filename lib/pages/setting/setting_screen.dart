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



      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset("assets/img/arrow_left.png",fit: BoxFit.fill,),

          // Icon(
          //   Icons.arrow_back,
          //   color: Style.Colors.appColor,
          //   size: 30,
          // ),
          onPressed: () =>  Get.back(result: "back"),
        ),
        title: Text("${AppConstants.setting}", style: GoogleFonts.inriaSans(textStyle: TextStyle(color:AppColors.appText,fontSize: 20,fontWeight: FontWeight.w700 ))),
      ),
      body:Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Notifications",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 20,color: AppColors.appText))),
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
                height: 25.0,
                width: 50.0,
                activeColor: AppColors.appRed,
                inactiveColor: AppColors.toggleBg,
                toggleSize: 22.0,
                padding: 1.0,
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
          SizedBox(height: 20,),
          Text("Delete Account",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 20,color: AppColors.appText)))
        ],),
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
