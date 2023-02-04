import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:get/get.dart';

import '../../models/categories.dart';
import '../../utils/snackbar_dialog.dart';

class MyOrderController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  var productList = <Product>[].obs;
  RxBool isLoading = true.obs;

  String customerId = "";
  String customerName = "";

  RxString groupValueStatus = "All".obs;
  RxString groupValueTime = "Anytime".obs;
  RxString searchKeyword = "".obs;

  RxString timeValue = "Anytime".obs;
  RxString statusValue = "All".obs;

  RxBool isLoadingGetOrderHistory = false.obs;
  var getOrderHistoryObj = MainResponse().obs;

  RxBool isLoadingOrderDetail = false.obs;
  var orderDetailObj = MainResponse().obs;

  List<Categories> list = [
    Categories(categoryName: "Komal Pandey",categoryImage: "assets/mode/mode1.png"),
    Categories(categoryName: "Thatbohogirl",categoryImage: "assets/mode/mode2.png"),
    Categories(categoryName: "Aashna Shroff",categoryImage: "assets/mode/mode2.png"),
    Categories(categoryName: "shauryasanadhya",categoryImage: "assets/mode/mode4.png"),

  ];

  List<Categories> list1 = [
    Categories(categoryName: "Komal Pandey",categoryImage: "assets/mode/mode1.png"),
    Categories(categoryName: "Thatbohogirl",categoryImage: "assets/mode/mode2.png"),
    Categories(categoryName: "Aashna Shroff",categoryImage: "assets/mode/mode2.png"),

  ];


  List<String> statusList = ["All","Processing","Delivered","Returned"];

  List<String> timeList = ["Anytime","Last 30 days","Last 6 months","Last year"];

  MyOrderController({required this.localRepositoryInterface, required this.apiRepositoryInterface});


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fetchProduct();
    loadUser();
  }


  loadUser() async {

    try {
      await localRepositoryInterface.getUser().then((value) {
        print("getUser customerId ${value!.customerId}");
        if (value.customerId != null) {
          customerId = value.customerId!;
          customerName = value.customerName!;
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
      isLoadingGetOrderHistory(false);
      await apiRepositoryInterface.orderHistory(customerId).then((value) {
        getOrderHistoryObj(value);
      });
    } finally {
      isLoadingGetOrderHistory(true);
      // refreshTotal();
    }
  }

  searchInOrder(String customerId,keyword,status,time) async {
    try {
      isLoadingGetOrderHistory(false);
      await apiRepositoryInterface.searchInOrder(customerId,keyword,status,time).then((value) {
        getOrderHistoryObj(value);
      });
    } finally {
      isLoadingGetOrderHistory(true);
      // refreshTotal();
    }
  }

  // getOrderByFilter(String customerId,status,time) async {
  //   try {
  //     isLoadingGetOrderHistory(false);
  //     await apiRepositoryInterface.getOrderByFilter(customerId,status,time).then((value) {
  //       getOrderHistoryObj(value);
  //     });
  //   } finally {
  //     isLoadingGetOrderHistory(true);
  //     // refreshTotal();
  //   }
  // }

  orderDetail(String orderId,productId) async {
    try {
      isLoadingOrderDetail(false);
      await apiRepositoryInterface.orderDetail(orderId,productId).then((value) {
        orderDetailObj(value);
      });
    } finally {
      isLoadingOrderDetail(true);
      // refreshTotal();
    }
  }

  void addProductRatingReviews(String orderId, productId, customerId, customerName, starRate, reviewContent, reviewTitle) async {
    MainResponse? mainResponse  = await apiRepositoryInterface.addProductRatingReviews(productId, customerId,customerName,starRate,reviewContent,reviewTitle);
    if (mainResponse!.status!) {
      orderDetail(orderId,productId);
      Get.back();
      SnackBarDialog.showSnackbar('Success',mainResponse.message!);
    } else {
      SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    }
  }
}
