import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_costants.dart';

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
     groupValue = shippingAddressController!.index.toInt();
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
                                    groupValue = int.parse(value!.toString());
                                  });
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setInt(AppConstants.prefAddressId!, int.parse(value.toString()));
                                  print("value value value $value");
                                  Get.back(result: value);


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
                                print("shippingAddressList![index].addressType! ${widget.shippingAddressList![index].addressId!}");
                                MainResponse? mainResponse  = await shippingAddressController!.deleteAddress(widget.shippingAddressList![index].addressId!);
                                if(mainResponse != null){
                                  if (mainResponse.status!) {

                                    // Get.back(result: "back");
                                    shippingAddressController!.getAddress(shippingAddressController!.customerId.value);
                                    Get.snackbar('Success', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
                                    // Get.offAllNamed(Routes.landingHome);

                                  } else {
                                    Get.snackbar('Error', mainResponse.message!,duration: const Duration(seconds: 8), snackPosition: SnackPosition.BOTTOM,);
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
}
