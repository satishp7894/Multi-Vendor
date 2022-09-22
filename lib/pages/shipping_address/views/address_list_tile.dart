import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_costants.dart';
import '../../../utils/snackbar_dialog.dart';

class AddressListTile extends StatefulWidget {
  final List<ShippingAddress>? shippingAddressList;
  final bool? isBool;



   AddressListTile({this.shippingAddressList, this.isBool});

  @override
  State<AddressListTile> createState() => _AddressListTileState();
}

class _AddressListTileState extends State<AddressListTile> {

  ShippingAddressController? shippingAddressController;
  int? groupValue;


  @override
  void initState() {
     shippingAddressController = Get.find<ShippingAddressController>();
     // shippingAddressController!.getAddressId();
     print("shippingAddressController!.index.toInt() ${shippingAddressController!.index.toInt()}");

     widget.shippingAddressList!.forEach((element) {


     });

     int index = 0;
     widget.shippingAddressList!.map((e){


       print("eeeeeeeee $index ============= ${e.setDefault}");
       {
         index = index + 1;
         if(e.setDefault == "1"){
           // int idx = e;
           // groupValue = shippingAddressController!.index.toInt();
           print("index index ${index-1}");
           groupValue = index-1;
         }else{

         }
       }
     }


     ).toList();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      //shippingAddressList![index].address! != "" ? shippingAddressList![index].address! + " ," : ""  +  shippingAddressList![index].city! != "" ? shippingAddressList![index].city! + ", ":"" + shippingAddressList![index].state! +  shippingAddressList![index].pincode!,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          ...List.generate(
              widget.shippingAddressList!.isEmpty ? 0 : widget.shippingAddressList!.length,
              (index) {

                String address = widget.shippingAddressList![index].address != "" ? widget.shippingAddressList![index].address! + ", " : "";
                String city = widget.shippingAddressList![index].city! != "" ? widget.shippingAddressList![index].city! + ", " : "";
                // String state = shippingAddressList![index].state! != "" ? shippingAddressList![index].state! + ", " : "";
                // String pincode = shippingAddressList![index].pincode! != "" ? shippingAddressList![index].pincode! + ", " : "";
                String fullAddress = address+city+widget.shippingAddressList![index].state!+" - "+widget.shippingAddressList![index].pincode!;
                return InkWell(
                  onTap: () async {
                    if(widget.isBool! == true){
                      print("Shipping Address Screen  ${widget.isBool!}");
                    }else{
                      // onChanged!(index);
                      print(widget.shippingAddressList![index].firstName);
                      // shippingAddressController!.dispose();
                      final result =  await
                      Get.toNamed(Routes.addShippingAddress,arguments: [
                        {"editMode": true},
                        {"addressObj": widget.shippingAddressList![index]}
                      ], );

                      print("Shipping Address Screen  $result");
                      if(result != null){
                        shippingAddressController!.getAddress(shippingAddressController!.customerId.value);
                      }
                    }

                  },
                  child:

                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.isBool! == true ?
                              Radio(
                                value: index,
                                groupValue: groupValue,
                                onChanged: (value) async {
                                  setState(() {
                                    changeDeliveryAddress(widget.shippingAddressList![index].addressId!,int.parse(value!.toString()));
                                  });
                                  print("value value value $value");
                                  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  // sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                  // print("value value value $value");
                                  // Get.back(result: value);


                                },
                              ):Container(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.shippingAddressList![index].firstName! + " "+ widget.shippingAddressList![index].lastName!,
                                            style: TextStyle(

                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              border: Border.all(
                                                  width: 0.5
                                                  ,color: Colors.grey
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0) //                 <--- border radius here
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                widget.shippingAddressList![index].addressType!,
                                                style: TextStyle(

                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Image.asset(
                                          //   'assets/images/default.png',
                                          //   height: 90,
                                          // ),
                                        ],
                                      ),


                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: MediaQuery.of(context).size.width-85,
                                    child: Text(

                                      fullAddress,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(
                                    widget.shippingAddressList![index].mobile!,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          widget.isBool! == true ?
                          Container():InkWell(
                            onTap: () async {

                              AlertDialogs.showAlertDialog("Delete?", "Are you "
                                  " you want to delete from this Address?", () async {
                                // Get.back();
                                print("shippingAddressList![index].addressType! ${widget.shippingAddressList![index].addressId!}");
                                MainResponse? mainResponse  = await shippingAddressController!.deleteAddress(widget.shippingAddressList![index].addressId!);
                                // Get.back();
                                Navigator.pop(context);
                                if(mainResponse != null){
                                  if (mainResponse.status!) {

                                    // Get.back(result: "back");
                                    shippingAddressController!.getAddress(shippingAddressController!.customerId.value);
                                    SnackBarDialog.showSnackbar('Success',mainResponse.message!);
                                    // Get.offAllNamed(Routes.landingHome);

                                  } else {
                                    SnackBarDialog.showSnackbar('Error',mainResponse.message!);
                                  }
                                }else{
                                  print("elseeeeee");
                                }
                              });
                              // shippingAddressController

                            },
                            child: Container(
                              // width: 100,
                              child: Icon(Icons.close,color: Colors.red,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }



          )
        ],
      ),
    );
  }
  void changeDeliveryAddress(String addressId, int value) async {
    // MainResponse? mainResponse = await controller.addAddress("4");
    // if (mainResponse.status! == true) {
    //   // Get.offAllNamed(Routes.login);
    //   Get.back(result: "back");
    //   SnackBarDialog.showSnackbar('Success',mainResponse.message!);
    // } else {
    //   SnackBarDialog.showSnackbar('Error',mainResponse.message!);
    // }

    MainResponse? mainResponse  = await shippingAddressController!.changeDeliveryAddress(addressId);
    if(mainResponse != null){
      if (mainResponse.status!) {
        groupValue = value;
        Get.back(result: value);
        SnackBarDialog.showSnackbar('Success',mainResponse.message!);
        // Get.offAllNamed(Routes.landingHome);

      } else {
        SnackBarDialog.showSnackbar('Error',mainResponse.message!);
      }
    }else{
      print("elseeeeee");
    }

  }
}
