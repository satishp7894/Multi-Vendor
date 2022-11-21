
import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/profile/views/edit_form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../utils/snackbar_dialog.dart';
import 'profile_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController? profileController;
  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  bool? nameBool= false;

  bool? genderBool= false;

  bool? emailBool= false;

  bool? mobileBool= false;

  bool? birthdayBool= false;

  bool? locationBool= false;

  bool? numberBool= false;

  bool? hintBool= false;

  String genderValue= "Female";

  DateTime selectedDate = DateTime.now();
  String? date = "";

  @override
  void initState() {
    Customer customer = Get.arguments;
    // TODO: implement initState
    profileController = Get.put(ProfileController(
        apiRepositoryInterface: Get.find(), customer: customer, localRepositoryInterface: Get.find()));
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
    // print("customer ${customer.customerName}");
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   elevation: 1,
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
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.white,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppSizes.sidePadding,right: AppSizes.sidePadding,top: 26,bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(child: Image.asset('assets/img/arrow_left.png',fit: BoxFit.fill,height: 15,width: 18,),onTap: (){
                                Get.back();
                              },),
                              SizedBox(width: 16,),
                              Text('',
                                  style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.appText))),
                            ],
                          ),

                        ],
                      ),
                    ),
                    // Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
                  ],),
                ),
                Container(height: 0.5,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  buildSignType(context)
                  // EditForm(
                  //   name: profileController!.nameTexcontroller,
                  //   gender: profileController!.genderTexcontroller,
                  //   mobile: profileController!.mobileTextController,
                  //   email: profileController!.emailTextController,
                  //   birthday: profileController!.birthdateTexcontroller,
                  //   location: profileController!.locationTextController,
                  //   number: profileController!.numberTexcontroller,
                  //   hint: profileController!.hintTextController,
                  //
                  //   // password: profileController!.passwordTextController,
                  //   submit:submit,
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(

            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(

                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColors.ratingText,

              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 16.0,right: 16.0),
                  child: Container(
                    height: 36,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.appRed,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                          top: 8.0,
                        ),
                        child: Text(
                          "SAVE DETAILS",
                          style: GoogleFonts.inriaSans(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    submit();
                  } else {
                    // create();
                  }


                },
              )
            ],),
          ),
        ],
      ),
    );
  }

  Widget buildSignType(BuildContext context) {

    return

      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: profileController!.mobileTextController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                // autofillHints: [AutofillHints.email],
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      mobileBool = true;
                    });
                    return 'This field is required';
                  }
                  if (value.length < 10) {
                    setState(() {
                      mobileBool = true;
                    });
                    return 'Enter a minimum 10 number';
                  } else if (value.length > 10) {
                    setState(() {
                      mobileBool = true;
                    });
                    return 'Enter a maximum 10 number';
                  }

                  setState(() {
                    mobileBool = false;
                  });

                },
                // autofillHints: [AutofillHints.num],
                // decoration: const InputDecoration(
                //     labelText: 'Mobile Number*',
                //     hintText: 'Mobile Number*',
                //     border: OutlineInputBorder()),

                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:25,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14)),
                    hintText: 'Mobile Number*',
                    labelText: 'Mobile Number*',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(1.0),
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0)
                    ),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0), borderSide: const BorderSide(color: AppColors.appText1, width: 1.0))
                ),
              ),
              mobileBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 16,
              ),
              TextFormField(
                // autofillHints: [AutofillHints.email],
                textInputAction: TextInputAction.next,
                controller: profileController!.nameTexcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      nameBool = true;
                    });
                    return 'This field is required';
                  }
                  setState(() {
                    nameBool = false;
                  });
                },
                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:25,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                    hintText: 'Full Name',
                    labelText: 'Full Name',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                ),
              ),
              nameBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: profileController!.emailTextController,
                // autofillHints: [AutofillHints.email],
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      emailBool = true;
                    });
                    return 'This field is required';
                  }
                  if (!value.contains('@')) {
                    setState(() {
                      emailBool = true;
                    });
                    return 'A valid email is required';
                  }
                  setState(() {
                    emailBool = false;
                  });
                },
                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:25,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                    hintText: 'Email',
                    labelText: 'Email',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                ),
              ),
              emailBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 16,
              ),
              // DropdownButtonFormField<String>(
              //
              //   decoration: InputDecoration(
              //     // labelText: 'Email',
              //       hintText: 'Gender ',
              //       border: OutlineInputBorder()),
              //   value: widget.gender!.text,
              //   // hint: Text(
              //   //   'Salutation',
              //   // ),
              //   onChanged: (salutation){
              //     widget.gender!.text = salutation!;
              //     print("salutation $salutation");
              //   },
              //   // onChanged: (salutation) =>
              //   //     setState(() => selectedSalutation = salutation),
              //   validator: (value) => value == null ? 'This field is required' : null,
              //   items:
              //   ['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),



              Container(
                height: 45,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  borderRadius: const BorderRadius.all(
                      const Radius.circular(2)
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors.appText1,
                    // style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            genderValue = "Female";
                          });
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(

                            border: Border(
                              right: BorderSide(width: 1,color: AppColors.appText1),

                              // style: BorderStyle.solid,
                            ),
                          ),
                          child: Container(
                            // color: Colors.green,
                            child: Center(
                              child: Row(

                                children: [
                                  genderValue == "Female" ?
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.asset("assets/img/Selected_Shape.png",fit: BoxFit.fill,height: 10,width: 14,),
                                  ):Container(),
                                  Text("Female", style: GoogleFonts.inriaSans(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.black)))
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            genderValue = "Male";
                          });
                        },
                        child: Container(
                          // decoration: BoxDecoration(
                          //   // color: AppColors.white,
                          //   borderRadius: const BorderRadius.all(
                          //       const Radius.circular(10)
                          //   ),
                          //   border: Border.all(
                          //     width: 1,
                          //     color: AppColors.bestSellingBorder,
                          //     // style: BorderStyle.solid,
                          //   ),
                          // ),
                          height: 45,
                          child: Row(children: [
                            genderValue == "Male" ?
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset("assets/img/Selected_Shape.png",fit: BoxFit.fill,height: 10,width: 14,),
                            ):Container(),

                            Text("Male", style: GoogleFonts.inriaSans(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.black)))
                          ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                readOnly: true,
                onTap: (){
                  _selectDate(context);
                },
                textInputAction: TextInputAction.next,
                controller: profileController!.birthdateTexcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      birthdayBool = true;
                    });
                    return 'This field is required';
                  }

                  setState(() {
                    birthdayBool = false;
                  });

                },
                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    suffixIcon: InkWell(child: Image.asset("assets/img/Calendar.png"),
                      onTap: (){
                        _selectDate(context);
                      },),
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:25,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                    hintText: 'Birthday',
                    labelText: 'Birthday',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                ),
              ),
              birthdayBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 15,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: profileController!.locationTextController,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      locationBool = true;
                    });
                    return 'This field is required';
                  }
                  setState(() {
                    locationBool = false;
                  });

                },

                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:0,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                    hintText: 'Location',
                    labelText: 'Location',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                ),
              ),
              locationBool == false ?
              const SizedBox(
                height: 47,
              ):const SizedBox(
                height: 32,
              ),

              Text(
                "Alternative mobile number details",
                style: GoogleFonts.inriaSans(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: TextFormField(
                  // focusNode: myFocusNode,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      setState(() {
                        numberBool = false;
                      });
                      return null;
                    }
                    if (value.length < 10) {
                      setState(() {
                        numberBool = true;
                      });
                      return 'Enter a minimum 10 number';
                    } else if (value.length > 10) {
                      setState(() {
                        numberBool = true;
                      });
                      return 'Enter a maximum 10 number';
                    }

                    setState(() {
                      numberBool = false;
                    });
                  },
                  controller: profileController!.numberTexcontroller,
                  // obscureText: controller.showPassword.value,
                  style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                  cursorColor: AppColors.appText1,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: AppColors.appText1,fontSize: 12
                      ),
                      contentPadding: EdgeInsets.only(top:25,left: 15),
                      // suffixIcon: IconButton(
                      //     onPressed: () {
                      //       controller.toggleShowPassword();
                      //     },
                      //     icon: controller.showPassword.value
                      //         ? Icon(Icons.visibility_off)
                      //         : Icon(Icons.visibility)),
                      prefixIcon: Container(
                        width: 51,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Text("    +91 ",style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),),
                            ),
                            Container(
                              width: 1,
                              height: 25,
                              color: AppColors.appText1,
                            ),
                          ],
                        ),
                      ),
                      hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),

                      hintText: 'Mobile Number*',
                      labelText: 'Mobile Number*',
                      enabledBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),

                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                      focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                    // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))

                    // border: OutlineInputBorder(),

                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "This will help recobver your account if needed",
                  style: GoogleFonts.inriaSans(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w300)),
                ),
              ),
              numberBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: profileController!.hintTextController,
                validator: (value) {
                  // if (value!.isEmpty) {
                  //   setState(() {
                  //     hintBool = true;
                  //   });
                  //   return 'This field is required';
                  // }
                  // setState(() {
                  //   hintBool = false;
                  // });

                },
                autofillHints: [AutofillHints.name],

                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.appText1,fontSize: 12
                    ),
                    contentPadding: EdgeInsets.only(top:25,left: 15),
                    hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                    hintText: 'Hint name',
                    labelText: 'Hint name',
                    enabledBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),
                      borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),)
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Add a name that helps you identify alternate number",
                  style: GoogleFonts.inriaSans(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w300)),
                ),
              ),
              hintBool == false ?
              const SizedBox(
                height: 20,
              ):const SizedBox(
                height: 16,
              ),
              InkWell(
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("CHANGE PASSWORD", style: GoogleFonts.inriaSans(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold)),)),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.appText1, width: 1),
                    // color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(
                        2.0) //                 <--- border radius here
                    ),
                  ),
                ),
                onTap: (){
                  Get.toNamed(
                    Routes.changePassword,
                  );
                },
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Obx(() {
              //   if (profileController!.isLoading.value) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else {
              //     return InkWell(
              //         onTap: () {
              //           print("genderValue ${genderValue}");
              //           FocusManager.instance.primaryFocus?.unfocus();
              //           if (_formKey.currentState!.validate()) {
              //             widget.submit!();
              //           } else {
              //             // create();
              //           }
              //         },
              //         child: DefaultBTN(
              //           btnText: "Submit",
              //         ));
              //   }
              // }),

            ],
          ),
        ),
      );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2099, 8),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        date = formatter.format(picked);
        // if(widget.birthday != null){
        profileController!.birthdateTexcontroller!.text = date!;
        // }
        selectedDate = picked;
        // homeController.getEPaper(date!, false);
        print("selectedDate $date");
      });
    }
  }
  void submit() async {
    MainResponse? mainResponse  = await profileController!.updateCustomerProfile();
    if (mainResponse.status!) {
      Get.back(result: "back");
     SnackBarDialog.showSnackbar('Success',mainResponse.message!);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }
  }
}



// class EditProfileScreen extends GetWidget<ProfileController> {
//    EditProfileScreen({Key? key}) : super(key: key);
//
//   Customer customer = Get.arguments;
//   // print(argumentData[0]['bool']);
//
//
//   void submit() async {
//     final result = await controller.submit();
//     if (result) {
//       Get.offAllNamed(Routes.landingHome);
//     } else {
//       Get.snackbar('Error', 'Incorrect Password');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("customer ${customer.customerName}");
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           alignment: Alignment.center,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   EditForm(
//                     name: controller.emailTextController,
//                     email: controller.emailTextController,
//                     password: controller.passwordTextController,
//                     submit:submit,
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }