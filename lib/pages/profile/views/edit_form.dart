import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile_controller.dart';


class EditForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? name;
  final TextEditingController? gender;
  final TextEditingController? email;
  final TextEditingController? mobile;
  final VoidCallback? submit;

  EditForm({this.name, this.gender, this.email,this.mobile, this.submit});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;
  // String? selectedSalutation;

  final controller = Get.find<ProfileController>();


  Widget buildSignType() {

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultLogo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Profile",
                //     style:
                //         const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                // const SizedBox(
                //   height: 5,
                // ),
                // Text("primary", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                // Positioned(
                //   child: Container(
                //     child: Obx(() {
                //       if (controller.isLoading.value) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else {
                //         return const SizedBox.shrink();
                //       }
                //     }),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }

                        },
                        autofillHints: [AutofillHints.name],
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Full Name ',
                            border: OutlineInputBorder()),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: email,
                        autofillHints: [AutofillHints.email],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          if (!value.contains('@')) {
                            return 'A valid email is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email ',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(

                      decoration: InputDecoration(
                        // labelText: 'Email',
                          hintText: 'Gender ',
                          border: OutlineInputBorder()),
                      value: gender!.text,
                      // hint: Text(
                      //   'Salutation',
                      // ),
                      onChanged: (salutation){
                        gender!.text = salutation!;
                        print("salutation $salutation");
                      },
                      // onChanged: (salutation) =>
                      //     setState(() => selectedSalutation = salutation),
                      validator: (value) => value == null ? 'This field is required' : null,
                      items:
                      ['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                      TextFormField(
                        controller: mobile,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length < 10) {
                            return 'Enter a minimum 10 number';
                          } else if (value.length > 10) {
                            return 'Enter a maximum 10 number';
                          }
                          {
                            return null;
                          }
                        },
                        // autofillHints: [AutofillHints.num],
                        decoration: const InputDecoration(
                            labelText: 'Mobile',
                            hintText: 'Mobile ',
                            border: OutlineInputBorder()),
                      ),


                    // if (controller.isSignIn.value)
                    //   InkWell(
                    //     onTap: () {
                    //       //   navigator!.pushNamed(SajiloDokanRoutes.checkAccount);
                    //     },
                    //     child: const Text(
                    //       'Forget Password ?',
                    //       //   style: GoogleFonts.blinker(),
                    //     ),
                    //   ),
                  ],
                )
              ],
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
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        submit!();
                      } else {
                        // create();
                      }
                    },
                    child: DefaultBTN(
                      btnText: "Submit",
                    ));
              }
            }),

            // InkWell(
            //     onTap: () {
            //       if (_formKey.currentState!.validate()) {
            //         submit!();
            //       } else {
            //        // create();
            //       }
            //     },
            //     child: DefaultBTN(
            //       btnText: "Submit",
            //     )),
            SizedBox(
              height: 10,
            ),

            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       SocialButton(
            //         imageName: 'assets/images/search.png',
            //         socialMedia: 'Google',
            //         color: Colors.redAccent,
            //         onPressed: login,
            //       ),
            //       SizedBox(
            //         width: 30,
            //       ),
            //       SocialButton(
            //         imageName: 'assets/images/facebook.png',
            //         socialMedia: 'Facebook',
            //         color: Colors.blue,
            //         onPressed: fblogin,
            //       )
            //     ],
            //   ),
            // ),

            // Center(child: Text('___________')),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "secondary",
            //       //style: GoogleFonts.rubik()
            //     ),
            //     InkWell(
            //       onTap: () {
            //        // controller.toggleFormType();
            //       },
            //       child: Text("signInOrRegister",
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 50,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSignType();
  }
}
