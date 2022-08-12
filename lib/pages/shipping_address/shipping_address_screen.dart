import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/pages/shipping_address/views/address_list_tile.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;


class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final shippingAddressController = Get.put(ShippingAddressController(
      apiRepositoryInterface: Get.find(), editMode: false, shippingAddress: ShippingAddress(),localRepositoryInterface: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.withOpacity(0.1),
      // appBar: AppBar(
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      //   elevation: 0,
      // ),

      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Style.Colors.appColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        title: Text("${AppConstants.shippingAddress}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
      ),
      body:RefreshIndicator(
        onRefresh: () {
          CheckInternet.checkInternet();
          // profileController.customerProfile();
          return shippingAddressController.getUser();
        },
        child: Obx(() {
          if (shippingAddressController.isLoadingGetAddress.value != true) {
            MainResponse? mainResponse = shippingAddressController.getAddressObj.value;
            List<ShippingAddress>? shippingAddressData = [];
            if(mainResponse.data != null){
              mainResponse.data!.forEach((v) {
                shippingAddressData.add( ShippingAddress.fromJson(v));
              });
            }
            // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();


            String? imageUrl = mainResponse.imageUrl ?? "";
            String? message = mainResponse.message ?? AppConstants.noInternetConn;
            if (shippingAddressData.isEmpty) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height-100,
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
             return ListView(
               // shrinkWrap: true,
               children: [
                 SingleChildScrollView(child: AddressListTile(shippingAddressList: shippingAddressData)),
               ],
             );
            }

          } else {
            return  Container(
              // height: 200,
                child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));

          }
        }),
      ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
          child: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.add),
              backgroundColor:Style.Colors.appColor,
              onPressed: () async {
                final result =  await
                Get.toNamed(Routes.addShippingAddress,arguments: [
                  {"editMode": false},
                  {"addressObj": ShippingAddress()}
                ]);
                print("Shipping Address Screen  $result");
                if(result != null){
                  shippingAddressController.getAddress(shippingAddressController.customerId.value);
                }
              }
          ),
        )


    );
  }
}
