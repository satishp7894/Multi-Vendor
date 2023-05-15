import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
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

import '../../utils/snackbar_dialog.dart';
import '../../widgets/app_bar_title.dart';

class WriteToUsScreen extends StatefulWidget {
  const WriteToUsScreen({Key? key}) : super(key: key);

  @override
  State<WriteToUsScreen> createState() => _WriteToUsScreenState();
}

class _WriteToUsScreenState extends State<WriteToUsScreen> {

  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
  }

  void submit() async {

    MainResponse? mainResponse = await controller.submitHelpCenter();
    if (mainResponse.status!) {
      SnackBarDialog.showSnackbar('Success', mainResponse.message!);
      controller.textIssueTextController!.clear();
      Get.back();
    } else {
      SnackBarDialog.showSnackbar('Error', mainResponse.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        controller.textIssueTextController!.clear();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body:SafeArea(
          child: Column(
            children: [
              AppbarTitleWidget(title: "Help Center",flag: false,),
              Padding(
                padding: const EdgeInsets.only(top: 24.0,bottom: 24,left: 16,right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("YOUR QUERY",
                        style: GoogleFonts.inriaSans(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black))),
                    SizedBox(height: 16,),
                    TextFormField(
                      // autofillHints: [AutofillHints.email],
                      maxLines: 7,
                      textAlign: TextAlign.start,

                      textAlignVertical: TextAlignVertical.top,
                      textInputAction: TextInputAction.newline,

                      controller: controller.textIssueTextController,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     setState(() {
                      //       nameBool = true;
                      //     });
                      //     return 'This field is required';
                      //   }
                      //   setState(() {
                      //     nameBool = false;
                      //   });
                      // },
                      style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                      cursorColor: AppColors.appText1,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                              color: AppColors.appText1
                          ),
                          contentPadding: EdgeInsets.only(top:35,left: 15),
                          hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                          hintText: 'Explain Your Issues*',
                          labelText: 'Explain Your Issues*',
                          enabledBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                          focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
                      ),
                    ),
                    SizedBox(height: 24,),
                    Center(
                      child: InkWell(
                        child: Container(
                          height: 45,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.appRed, width: 1),
                            color: AppColors.appRed,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    10.0) //                 <--- border radius here
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: GoogleFonts.salsa(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              // style: const TextStyle(
                              //     fontSize: 23,
                              //     fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if(controller.textIssueTextController!.text.isNotEmpty){
                            submit();
                          }else{
                            SnackBarDialog.showSnackbar('Error', "Please Enter Your Issues");
                          }

                        },
                      ),
                    ),

                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
