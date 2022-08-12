import 'package:eshoperapp/pages/myorder/view/my_order_list_tile.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SajiloDokanScaffold(
      leading: true,
      title: null,
      body: SafeArea(
        child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  ...List.generate(10, (index) => MyOrderTile())
                ],
              ),
            ),
          ),
        ],
    ),
        ),
      ),
      searchOnTab: () {},
    );
  }
}
