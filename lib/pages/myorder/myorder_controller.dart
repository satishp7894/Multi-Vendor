import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/repository/api_repository.dart';
import 'package:eshoperapp/repository/local_repository.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:get/get.dart';

import '../../models/categories.dart';

class MyOrderController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  var productList = <Product>[].obs;
  RxBool isLoading = true.obs;

  RxInt groupValueStatus = 0.obs;
  RxInt groupValueTime = 0.obs;

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


  List<String> statusList = ["All","On the Way","Delivered","Cancelled","Returned"];

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

  orderDetail(String orderId) async {
    try {
      isLoadingOrderDetail(true);
      await apiRepositoryInterface.orderDetail(orderId).then((value) {
        orderDetailObj(value);
      });
    } finally {
      isLoadingOrderDetail(false);
      // refreshTotal();
    }
  }

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
