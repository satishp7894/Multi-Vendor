import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/payment.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/categories.dart';
import '../landing_home/home_controller.dart';

class PaymentController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  List<PaymentModel> paymentList =  <PaymentModel>[];
  Razorpay? _razorpay;
  String? paymentType;
  String? productIdS="";
  final homeController = Get.put(HomeController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find()));
  PaymentController({required this.localRepositoryInterface, required this.apiRepositoryInterface});


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    paymentList.add( PaymentModel(false, 'assets/img/upi.png', 'PhonePe/Google Pay/BHIM UPI'));
    // paymentList.add( PaymentModel(false, 'assets/img/paylater.png', 'EMI/Pay Later'));
    paymentList.add( PaymentModel(false, 'assets/img/cod.png', 'Cash On Delivery'));


    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: ${response.paymentId}');


    homeController.addOrder(paymentType!,productIdS);
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message}');
    homeController.addOrder(paymentType!,productIdS);
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: ${response.walletName}');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_4sP1JemLPLT9dX',
      'amount': 100,
      'name': 'MultiVendor',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      // 'prefill': {'contact': shippingAddressController!.checkLoginData.value.mobile, 'email': shippingAddressController!.checkLoginData.value.email},
      'prefill': {'contact': "1234567899", 'email': "test@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }








}
