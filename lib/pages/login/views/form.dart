import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';

class SignForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? customerName;
  final TextEditingController? gender;
  final TextEditingController? email;
  final TextEditingController? mobile;
  final TextEditingController? password;
  final VoidCallback? logOrRegAction;

  SignForm(
      {this.customerName,
      this.gender,
      this.email,
      this.password,
      this.mobile,
      this.logOrRegAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<LoginController>();

  // void socialLogin(String? idToken, String provider) async {
  //   final result = await controller.googleAuth(idToken, provider);
  //   if (result) {
  //     Get.offAllNamed(SajiloDokanRoutes.landingHome);
  //   } else {
  //     Get.snackbar('Error', 'Incorrect Password');
  //   }
  // }

  // final googlesignIn = GoogleSignIn(
  //   scopes: [
  //     'https://www.googleapis.com/auth/userinfo.email',
  //     'https://www.googleapis.com/auth/userinfo.profile',
  //   ],
  // );
  //
  // Future<void> fblogin() async {
  //   final result = await FacebookAuth.instance.login(permissions: [
  //     'public_profile',
  //     'email',
  //   ]);
  //   if (result.status == LoginStatus.success) {
  //     log(result.accessToken!.token);
  //     socialLogin(result.accessToken!.token, 'facebook');
  //   } else {
  //     return null;
  //   }
  // }

  // Future<void> login() async {
  //   await googlesignIn
  //       .signIn()
  //       .then((result) => result!.authentication)
  //       .then((googleKey) => socialLogin(googleKey.idToken, 'google'))
  //       .catchError((err) => null);
  // }

  Widget buildSignType() {
    String? selectedSalutation;
    final title = controller.isSignIn.value ? 'Welcome,' : 'Create Account';
    final primary = controller.isSignIn.value
        ? 'Sign In To  Continue!'
        : 'Sign Up To Get Started!';

    final btnText = controller.isSignIn.value ? 'Login' : 'Create';
    final secondary =
        controller.isSignIn.value ? 'Need an profile?' : 'Have you profile?';

    final signInOrRegister = controller.isSignIn.value ? 'Register' : 'SignIn';

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
                Text(title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                Text(primary, style: TextStyle(fontSize: 18)),
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
                    if (!controller.isSignIn.value)
                      TextFormField(
                        controller: customerName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          // if (!value.contains('@')) {
                          //   return 'A valid email is required';
                          // } else {
                          //   return null;
                          // }
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
                        controller: email,
                        textInputAction: TextInputAction.next,
                        // autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          if(!regExp.hasMatch(value)) {
                            return "A valid email is required";
                          }
                          else {
                            return null;
                          }
                          // if (!value.contains('@')) {
                          //   return 'A valid email is required';
                          // } else {
                          //   return null;
                          // }
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Email ',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    if (!controller.isSignIn.value)
                    SizedBox(
                      height: 20,
                    ),
                    if (!controller.isSignIn.value)

                    DropdownButtonFormField<String>(

                      decoration: InputDecoration(
                          // labelText: 'Email',
                          hintText: 'Gender ',
                          border: OutlineInputBorder()),
                      value: selectedSalutation,
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
                    if (!controller.isSignIn.value)
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
                    if (!controller.isSignIn.value)
                      SizedBox(
                        height: 20,
                      ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length < 4) {
                            return 'Enter a minimum 4 character';
                          } else {
                            return null;
                          }
                        },
                        controller: password,
                        obscureText: controller.showPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleShowPassword();
                              },
                              icon: controller.showPassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          hintText: 'Password',
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
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
                        logOrRegAction!();
                      } else {
                        // create();
                      }
                    },
                    child: DefaultBTN(
                      btnText: btnText,
                    ));
              }
            }),

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

            Center(child: Text('___________')),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  secondary,
                  //style: GoogleFonts.rubik()
                ),
                InkWell(
                  onTap: () {
                    controller.toggleFormType();
                  },
                  child: Text(signInOrRegister,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return buildSignType();
    });
  }
}
