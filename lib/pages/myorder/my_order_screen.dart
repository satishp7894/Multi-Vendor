import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/order_history.dart';
import 'package:eshoperapp/pages/myorder/view/my_order_list_tile.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'myorder_controller.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {

  final myOrderController = Get.find<MyOrderController>();
  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
      leading: true,
      title: null,
      body:

      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // physics: const NeverScrollableScrollPhysics(),
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios,size: 25,)),
                  Icon(Icons.search,size: 30,)
                ],),
              SizedBox(height: 12,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("My Orders",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 8,),

            RefreshIndicator(
                onRefresh: () async {
                  CheckInternet.checkInternet();
                  await myOrderController.loadUser();
                },
                child: Obx(() {
                  if (myOrderController.isLoadingGetOrderHistory.value != true) {
                    MainResponse? mainResponse = myOrderController.getOrderHistoryObj.value;
                    List<OrderHistory>? getOrderHistoryData = [];
                    if(mainResponse.data != null){
                      mainResponse.data!.forEach((v) {
                        getOrderHistoryData.add( OrderHistory.fromJson(v));
                      });
                    }
                    // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


                    String? imageUrl = mainResponse.imageUrl ?? "";
                    String? message = mainResponse.message ?? AppConstants.noInternetConn;
                    if (getOrderHistoryData.isEmpty) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height-160,
                        child: ListView(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height-260,
                              //height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  message!,
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ),
                            ),

                          ],
                        ),
                      );
                    }else{

                      return   Container(
                        height: MediaQuery.of(context).size.height-160,
                        child: ListView(
                          children: [

                            ...List.generate(getOrderHistoryData.length, (index) => MyOrderTile(orderHistory: getOrderHistoryData[index],index: index,imageUrl: imageUrl,))
                          ],
                        ),
                      );

                    }

                  } else {
                    return  Container(
                        height: MediaQuery.of(context).size.height-160,
                        child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

                  }
                }),
              ),

            ],
          ),
        ),
      ),


      searchOnTab: () {},
    );
  }
}
