import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_costants.dart';

class CheckOutController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  var productList = <Product>[].obs;
  RxBool isLoading = true.obs;

  // RxInt index = 0.obs;

  RxBool isLoadingGetOrderHistory = false.obs;
  var getOrderHistoryObj = MainResponse().obs;

  RxBool isLoadingOrderDetail = false.obs;
  var orderDetailObj = MainResponse().obs;

  CheckOutController({required this.localRepositoryInterface, required this.apiRepositoryInterface});


  @override
  void onInit() {
    // TODO: implement onInit
    // getAddressId();
    super.onInit();
    // fetchProduct();
    // loadUser();
  }

  // getAddressId() async {
  //   await SharedPreferences.getInstance().then((value) {
  //     final addressId = value.getInt(AppConstants.prefAddressId!);
  //     print("addressId CheckOutController ${addressId}");
  //     if(addressId != null){
  //       index(addressId);
  //     }else{
  //       index(0);
  //     }
  //   });
  //
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //
  //
  //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // sharedPreferences.setString(AppConstants.prefCustomerId!, checkLoginData!.customerId!);
  // }


  loadUser() async {

    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          getOrderHistory(value.customerId!);
        }else{
          getOrderHistory("");
        }
      });
    } on Exception {
      //isLoadingCustomerProfile(false);

      return MainResponse();
    }
    // localRepositoryInterface.getUser().then((value) => user(value!));
  }

  getOrderHistory(String customerId) async {
    try {
      isLoadingGetOrderHistory(true);
      await apiRepositoryInterface.orderHistory(customerId).then((value) {
        getOrderHistoryObj(value);
      });
    } finally {
      isLoadingGetOrderHistory(false);
      // refreshTotal();
    }
  }

  // orderDetail(String orderId) async {
  //   try {
  //     isLoadingOrderDetail(true);
  //     await apiRepositoryInterface.orderDetail(orderId).then((value) {
  //       orderDetailObj(value);
  //     });
  //   } finally {
  //     isLoadingOrderDetail(false);
  //     // refreshTotal();
  //   }
  // }

  // void fetchProduct() async {
  //   final token = await localRepositoryInterface.getToken();
  //   isLoading(false);
  //   try {
  //     var products = await apiRepositoryInterface.fetchingProdcut(token);
  //     if (products != null) {
  //       productList(products);
  //     }
  //   } finally {
  //     isLoading(true);
  //   }
  // }





}
