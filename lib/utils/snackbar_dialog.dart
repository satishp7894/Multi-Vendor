import 'package:get/get.dart';

class SnackBarDialog {
  static showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
