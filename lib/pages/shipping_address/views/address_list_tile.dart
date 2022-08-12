import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/shipping_address.dart';
import 'package:eshoperapp/pages/shipping_address/shippig_address_controller.dart';
import 'package:eshoperapp/routes/navigation.dart';
import 'package:eshoperapp/utils/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressListTile extends StatelessWidget {

  final shippingAddressController = Get.find<ShippingAddressController>();
  // final ValueChanged<int>? onChanged;
  final List<ShippingAddress>? shippingAddressList;

   AddressListTile({this.shippingAddressList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      //shippingAddressList![index].address! != "" ? shippingAddressList![index].address! + " ," : ""  +  shippingAddressList![index].city! != "" ? shippingAddressList![index].city! + ", ":"" + shippingAddressList![index].state! +  shippingAddressList![index].pincode!,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          ...List.generate(
              shippingAddressList!.isEmpty ? 0 : shippingAddressList!.length,
              (index) {
                String address = shippingAddressList![index].address != "" ? shippingAddressList![index].address! + ", " : "";
                String city = shippingAddressList![index].city! != "" ? shippingAddressList![index].city! + ", " : "";
                // String state = shippingAddressList![index].state! != "" ? shippingAddressList![index].state! + ", " : "";
                // String pincode = shippingAddressList![index].pincode! != "" ? shippingAddressList![index].pincode! + ", " : "";
                String fullAddress = address+city+shippingAddressList![index].state!+" - "+shippingAddressList![index].pincode!;
                return InkWell(
                  onTap: () async {
                    // onChanged!(index);
                    print(shippingAddressList![index].firstName);
                    final result =  await
                    Get.toNamed(Routes.addShippingAddress,arguments: [
                      {"editMode": true},
                      {"addressObj": shippingAddressList![index]}
                    ]);

                    print("Shipping Address Screen  $result");
                    if(result != null){
                      shippingAddressController.getAddress(shippingAddressController.customerId.value);
                    }
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                                    shippingAddressList![index].firstName! + " "+ shippingAddressList![index].lastName!,
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
                                        shippingAddressList![index].addressType!,
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
                              InkWell(
                                onTap: () async {

                                  AlertDialogs.showAlertDialog("Delete?", "Are you sure you want to delete from this Address?", () async {
                                    print("shippingAddressList![index].addressType! ${shippingAddressList![index].addressId!}");
                                    MainResponse? mainResponse  = await shippingAddressController.deleteAddress(shippingAddressList![index].addressId!);
                                    if(mainResponse != null){
                                      if (mainResponse.status!) {

                                        // Get.back(result: "back");
                                        shippingAddressController.getAddress(shippingAddressController.customerId.value);
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
                              )
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text(

                            fullAddress,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            shippingAddressList![index].mobile!,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
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
