import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/pages/profile/profile_controller.dart';
import 'package:eshoperapp/widgets/default_btn.dart';
import 'package:eshoperapp/widgets/default_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChangePassForm extends StatelessWidget {
  void create() async {
    Get.snackbar('Error', 'Correct your email!');
  }

  final TextEditingController? currentPassword;
  final TextEditingController? newPassword;
  final TextEditingController? confirmPassword;
  final VoidCallback? submitAction;

  ChangePassForm(
      {this.currentPassword,
      this.newPassword,
      this.confirmPassword,
      this.submitAction});

  final _formKey = GlobalKey<FormState>();

  final bool remember = false;

  final controller = Get.find<ProfileController>();

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
    // final title = controller.isSignIn.value ? 'Welcome,' : 'Create Account';
    // final primary = controller.isSignIn.value
    //     ? 'Sign In To  Continue!'
    //     : 'Sign Up To Get Started!';
    //
    // final btnText = controller.isSignIn.value ? 'Login' : 'Create';
    // final secondary =
    //     controller.isSignIn.value ? 'Need an profile?' : 'Have you profile?';
    //
    // final signInOrRegister = controller.isSignIn.value ? 'Register' : 'SignIn';

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           DefaultLogo(),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(title,
            //         style: const TextStyle(
            //             fontSize: 24, fontWeight: FontWeight.bold)),
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     Text(primary, style: TextStyle(fontSize: 18)),
            //   ],
            // ),
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
                        controller: currentPassword,
                        obscureText: controller.showCurrentPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleShowCurrentPassword();
                              },
                              icon: controller.showCurrentPassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          hintText: 'Current Password',
                          labelText: 'Current Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
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
                        controller: newPassword,
                        obscureText: controller.showNewPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleShowNewPassword();
                              },
                              icon: controller.showNewPassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          hintText: 'New Password',
                          labelText: 'New Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
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
                        controller: confirmPassword,
                        obscureText: controller.showConfirmPassword.value,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.toggleShowConfirmPassword();
                              },
                              icon: controller.showConfirmPassword.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
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
                        submitAction!();
                      } else {
                        // create();
                      }
                    },
                    child: DefaultBTN(
                      btnText: "Submit",
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       secondary,
            //       //style: GoogleFonts.rubik()
            //     ),
            //     InkWell(
            //       onTap: () {
            //         controller.toggleFormType();
            //       },
            //       child: Text(signInOrRegister,
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //     )
            //   ],
            // ),
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
