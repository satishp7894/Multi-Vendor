import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:intl/intl.dart';

import '../profile_controller.dart';


class EditForm extends StatefulWidget {
  final TextEditingController? name;
  final TextEditingController? gender;
  final TextEditingController? email;
  final TextEditingController? mobile;
  final TextEditingController? birthday;
  final TextEditingController? location;
  final TextEditingController? number;
  final TextEditingController? hint;


  final VoidCallback? submit;

  EditForm({this.name, this.gender, this.email,this.mobile,this.birthday,this.location,this.number,this.hint, this.submit});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

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

  // String? selectedSalutation;
  final controller = Get.find<ProfileController>();


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
          widget.birthday!.text = date!;
        // }
        selectedDate = picked;
        // homeController.getEPaper(date!, false);
        print("selectedDate $date");
      });
    }
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
              controller: widget.mobile,
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

              style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
              cursorColor: AppColors.appText1,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: AppColors.appText1
                ),
                contentPadding: EdgeInsets.only(top:35,left: 15),
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

                ),
                focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
                controller: widget.name,
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
                      color: AppColors.appText1
                  ),
                  contentPadding: EdgeInsets.only(top:35,left: 15),
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
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
              controller: widget.email,
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
                    color: AppColors.appText1
                ),
                contentPadding: EdgeInsets.only(top:35,left: 15),
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
                  errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                  focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
              controller: widget.birthday,
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
                    color: AppColors.appText1
                ),
                contentPadding: EdgeInsets.only(top:35,left: 15),
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
                  errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                  focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
              controller: widget.location,
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
                    color: AppColors.appText1
                ),
                contentPadding: EdgeInsets.only(top:35,left: 15),
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
                  errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                  focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
                controller: widget.number,
                // obscureText: controller.showPassword.value,
                style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15)),
                cursorColor: AppColors.appText1,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: AppColors.appText1
                  ),
                  contentPadding: EdgeInsets.only(top:35,left: 15),
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
                    errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                    focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
              controller: widget.hint,
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
                    color: AppColors.appText1
                ),
                contentPadding: EdgeInsets.only(top:35,left: 15),
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
                  errorBorder: OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0),),
                  focusedErrorBorder :OutlineInputBorder(  borderRadius: BorderRadius.circular(2.0))
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
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                  child: Center(child: Text("CHANGE PASSWORD", style: GoogleFonts.inriaSans(
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: AppColors.appText,
                          fontWeight: FontWeight.w700)),)),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appText1, width: 1),
                  // color: Colors.grey[100],
                  borderRadius: const BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                ),
              ),
              onTap: (){
                Get.toNamed(
                  Routes.changePassword,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return InkWell(
                    onTap: () {
                      print("genderValue ${genderValue}");
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        widget.submit!();
                      } else {
                        // create();
                      }
                    },
                    child: DefaultBTN(
                      btnText: "Submit",
                    ));
              }
            }),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSignType(context);
  }
}
