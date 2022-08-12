
import 'package:eshoperapp/models/customer.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/pages/profile/views/edit_form.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ProfileController? profileController;
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
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EditForm(
                    name: profileController!.nameTexcontroller,
                    gender: profileController!.genderTexcontroller,
                    mobile: profileController!.mobileTextController,
                    email: profileController!.emailTextController,
                    // password: profileController!.passwordTextController,
                    submit:submit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void submit() async {
    MainResponse? mainResponse  = await profileController!.updateCustomerProfile();
    if (mainResponse.status!) {
      Get.back(result: "back");
     Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
      // Get.offAllNamed(Routes.landingHome);

    } else {
      Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
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