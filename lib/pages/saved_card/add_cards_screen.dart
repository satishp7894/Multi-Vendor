import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import '../../widgets/app_bar_title.dart';

class AddCardsScreen extends StatefulWidget {
  const AddCardsScreen({Key? key}) : super(key: key);

  @override
  State<AddCardsScreen> createState() => _AddCardsScreenState();
}

class _AddCardsScreenState extends State<AddCardsScreen> {

 String? expiryMonthValue;
 String? expiryYearValue;
 String? checkboxValue = "";
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBg,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: Image.asset(
      //     'assets/img/arrow_left.png',
      //     color: AppColors.appText,
      //   ),
      //   title: Text(
      //     "SAVED CARDS",
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
            AppbarTitleWidget(title: "SAVED CARDS",flag: false,),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17.0,top: 11,right: 17,bottom: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add New Credit/Debit Card",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inriaSans(

                                textStyle: const TextStyle(

                                    fontSize: 16,
                                    color: AppColors.appText,
                                    fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                }
                                // if (value.length < 4) {
                                //   return 'Enter a minimum 4 character';
                                // } else {
                                //   return null;
                                // }
                              },
                              onChanged: (text){
                                setState(() {
                                  print("text  ${text}");
                                });
                              },
                              // controller: widget.newPassword,
                              // obscureText: controller.showNewPassword.value,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: AppColors.appRed,fontSize: 12
                                ),
                                hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
                                // suffixIcon: IconButton(
                                //     onPressed: () {
                                //       controller.toggleShowNewPassword();
                                //     },
                                //     icon: controller.showNewPassword.value
                                //         ? Icon(Icons.visibility_off)
                                //         : Icon(Icons.visibility)),

                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.appText1),
                                  //  when the TextFormField in focused
                                ) ,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.appText1),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.appText1),
                                  //  when the TextFormField in focused
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color:AppColors.appText1),
                                  //  when the TextFormField in focused
                                ),
                                hintText: 'Card Number *',
                                labelText: 'Card Number *',
                                // border: OutlineInputBorder(),

                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                }
                                // if (value.length < 4) {
                                //   return 'Enter a minimum 4 character';
                                // } else {
                                //   return null;
                                // }
                              },
                              onChanged: (text){
                                setState(() {
                                  print("text  ${text}");
                                });
                              },
                              // controller: widget.newPassword,
                              // obscureText: controller.showNewPassword.value,

                              decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //     onPressed: () {
                                //       controller.toggleShowNewPassword();
                                //     },
                                //     icon: controller.showNewPassword.value
                                //         ? Icon(Icons.visibility_off)
                                //         : Icon(Icons.visibility)),
                                hintText: 'Card Name *',
                                labelText: 'Card Name *',
                                // border: OutlineInputBorder(),
                              ),


                            ),
                          ),
                          SizedBox(height: 10,),
                          // FormField<String>(
                          //   validator: (value) {
                          //     if (checkboxValue!.isEmpty) {
                          //       return 'You need to accept terms';
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //
                          //   builder: (state) {
                          //   return Column(
                          //     children: [
                          //       Stack(
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.all(2.0),
                          //             child: Container(
                          //
                          //               // color: Colors.green,
                          //               decoration: BoxDecoration(
                          //                 color: AppColors.appText1,
                          //                 borderRadius: BorderRadius.circular(10),
                          //               ),
                          //               height: 60,
                          //
                          //
                          //             ),
                          //           ),
                          //           Container(
                          //
                          //             decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //
                          //             height: 60,
                          //
                          //             child: TextFormField(
                          //               onChanged: (text){
                          //                 setState(() {
                          //                   checkboxValue = text;
                          //                 });
                          //               },
                          //               decoration: InputDecoration(
                          //
                          //                 border: InputBorder.none,
                          //
                          //                 hintText: 'Card Number *',
                          //                 labelText: 'Card Number *',
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Text(
                          //         state.errorText ?? '',
                          //         style: TextStyle(
                          //           color: Theme.of(context).errorColor,
                          //         ),
                          //       )
                          //     ],
                          //   );
                          //   },
                          // ),
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(

                                  child: DropdownButtonFormField<String>(

                                    decoration: InputDecoration(
                                      // labelText: 'Email',
                                        hintText: 'Expiry Month',
                                        // border: OutlineInputBorder()
                                    ),
                                    value: expiryMonthValue,
                                    // hint: Text(
                                    //   'Salutation',
                                    // ),
                                    onChanged: (salutation){
                                      expiryMonthValue = salutation!;
                                      print("salutation $salutation");
                                    },
                                    // onChanged: (salutation) =>
                                    //     setState(() => selectedSalutation = salutation),
                                    validator: (value) => value == null ? 'This field is required' : null,
                                    items:
                                    ['JAN', 'FEB' , 'MARCH' , 'APRIL' , 'MAY'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  width: 150,
                                ),
                                SizedBox(
                                  child: DropdownButtonFormField<String>(

                                    decoration: InputDecoration(
                                      // labelText: 'Email',
                                        hintText: 'Expiry Year',
                                        // border: OutlineInputBorder()

                                    ),
                                    value: expiryYearValue,
                                    // hint: Text(
                                    //   'Salutation',
                                    // ),
                                    onChanged: (salutation){
                                      expiryYearValue = salutation!;
                                      print("salutation $salutation");
                                    },
                                    // onChanged: (salutation) =>
                                    //     setState(() => selectedSalutation = salutation),
                                    validator: (value) => value == null ? 'This field is required' : null,
                                    items:
                                    ['2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030'].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                  width: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,

            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 20.0,right: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.appRed,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        top: 8.0,
                      ),
                      child: Text(
                        "SAVE",
                        style: GoogleFonts.inriaSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        // style: const TextStyle(
                        //     fontSize: 23,
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                 print("_formKey true");
                } else {
                  print("_formKey false");
                  // create();
                }
                // openCheckout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
