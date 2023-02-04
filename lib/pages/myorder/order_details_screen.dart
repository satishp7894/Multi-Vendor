import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:eshoperapp/constants/app_costants.dart';
import 'package:eshoperapp/models/main_response.dart';
import 'package:eshoperapp/models/order_detail.dart';
import 'package:eshoperapp/models/order_history.dart';
import 'package:eshoperapp/package/product_rating.dart';
import 'package:eshoperapp/pages/myorder/myorder_controller.dart';
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:eshoperapp/widgets/scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/theme.dart';
import '../../models/order_details_model.dart';
import '../../models/order_histrory_model.dart';
import '../../models/products.dart';
import '../../widgets/app_bar_title.dart';
import '../../widgets/default_btn.dart';
import '../details/prodcut_details_screen.dart';

class OrderDetaisScreen extends StatefulWidget {
  const OrderDetaisScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetaisScreen> createState() => _OrderDetaisScreenState();
}

class _OrderDetaisScreenState extends State<OrderDetaisScreen> with TickerProviderStateMixin {
  MyOrderController? myOrderController;
  OrderHistoryModel? orderHistory;
  bool downloading = false;
  bool downloadingComplete = true;
  var progress = "";
  late AnimationController controller;

  Directory? downloadsDirectory;



  @override
  void initState() {
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(milliseconds: 600);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(milliseconds: 600);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    orderHistory = Get.arguments;
    print("orderId ${orderHistory!.orderId}");
    myOrderController = Get.find<MyOrderController>();
    myOrderController!.orderDetail(orderHistory!.orderId!,orderHistory!.productId!);
    initDownloadsDirectoryState();
    super.initState();
  }

  Future<void> initDownloadsDirectoryState() async {
    // Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      downloadsDirectory = (await DownloadsPathProvider.downloadsDirectory)!;
    } on PlatformException {
      print('Could not get the downloads directory');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _downloadsDirectory = downloadsDirectory;
    // });
  }

  Future<File> _downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      // final dir = (await getApplicationDocumentsDirectory()).path;
      String dir = "";
      if (Platform.isAndroid) {
        dir = "/sdcard/download";
      }
      // else {
      //   dirloc = (await getApplicationDocumentsDirectory()).path;
      // }
      File file = new File('${dir}/$filename.pdf');
      await file.writeAsBytes(bytes);
      print('downloaded file path = ${file.path}');
      return file;
    } catch (error) {
      print('pdf downloading error = $error');
      return File('');
    }
  }

  Future<void> downloadFile(String url, String filename) async {
    Dio dio = Dio();
    // bool checkPermission1 =
    // await SimplePermissions.checkPermission(permission1);
    // // print(checkPermission1);
    // if (checkPermission1 == false) {
    //   await SimplePermissions.requestPermission(permission1);
    //   checkPermission1 = await SimplePermissions.checkPermission(permission1);
    // }
    // if (checkPermission1 == true) {


      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      }
      // else {
      //   dirloc = (await getApplicationDocumentsDirectory()).path;
      // }

      // var randid = random.nextInt(10000);


      try {
        // FileUtils.mkdir([dirloc]);
        await dio.download(url, dirloc + filename.toString() + ".pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
              setState(() {
                downloading = true;
                progress =
                    ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
                print("progress =====${progress}");


              });

            });

      } catch (e) {
        print(e);
      }

      setState(() {
        // downloading = false;
        downloadingComplete = false;
        progress = "Download Completed.";
        print("Download Completed.");
        print("${dirloc + filename.toString() + ".pdf"}");
        // path = dirloc + randid.toString() + ".jpg";
      });
    // } else {
    //   setState(() {
    //     progress = "Permission Denied!";
    //     _onPressed = () {
    //       downloadFile();
    //     };
    //   });
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ratingText,
      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: "ORDER DETAILS",flag: false,),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 16,),


                  Obx(() {

                    if (myOrderController!.isLoadingOrderDetail.value == true) {
                      MainResponse? mainResponse = myOrderController!.orderDetailObj.value;
                      List<OrderDetailsModel>? orderDetailsData = [];
                      if(mainResponse.data != null){
                        for (var v in mainResponse.data!) {
                          orderDetailsData.add( OrderDetailsModel.fromJson(v));
                        }

                      }
                      String? imageUrl = mainResponse.imageUrl ?? "";
                      String? invoiceUrl = mainResponse.invoiceUrl ?? "";
                      String? message = mainResponse.message ?? AppConstants.noInternetConn;
                      if (orderDetailsData.isEmpty) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height-200,
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
                        return Column(children: [
                          Container(
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Order ID - ${orderDetailsData[0].orderNumber}",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.orderDetailTitle,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                   color: AppColors.tileLine,
                                ),
                                InkWell(

                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(

                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [

                                                Text(
                                                  "${orderDetailsData[0].brandName}",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          color: AppColors.black,
                                                          fontWeight: FontWeight.w700)),
                                                ),
                                                Container(
                                                  width: 250,
                                                  child: Text(
                                                    orderDetailsData[0].productName!,
                                                    maxLines: 1,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.w300)),
                                                  ),
                                                ),
                                                Column(

                                                  children:orderDetailsData[0].elementsAttributes!.map((attributesObj) {
                                                  return Text(
                                                    "${attributesObj.element} : ${attributesObj.value} ",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: const TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.w300)),
                                                  );
                                                }).toList(),
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                )
                                                // Text(
                                                //   "Colour : Green ",
                                                //   style: GoogleFonts.inriaSans(
                                                //       textStyle: const TextStyle(
                                                //           fontSize: 14,
                                                //           color: AppColors.black,
                                                //           fontWeight: FontWeight.w300)),
                                                // ),
                                                // Text(
                                                //   "Size : M",
                                                //   style: GoogleFonts.inriaSans(
                                                //       textStyle: const TextStyle(
                                                //           fontSize: 14,
                                                //           color: AppColors.black,
                                                //           fontWeight: FontWeight.w300)),
                                                // ),

                                                // Text(
                                                //   "Size: 38",
                                                //   style: GoogleFonts.inriaSans(
                                                //       textStyle: const TextStyle(
                                                //           fontSize: 14,
                                                //           color: AppColors.appText1,
                                                //           fontWeight: FontWeight.w300)),
                                                // ),
                                              ],),
                                            Container(
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(2)),child: Image.network(imageUrl+orderDetailsData[0].productId!+"/"+orderDetailsData[0].coverImg!, fit: BoxFit.cover,height: 85,width: 85,)),
                                              // color: Colors.red,
                                            ),
                                          ],
                                        ),

                                        Text(
                                          "₹ ${orderDetailsData[0].totalAmt}",
                                          style: GoogleFonts.inriaSans(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w700)),
                                        ),

                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  ProductDetailsScreen(
                                              products: Products(productId: orderDetailsData[0].productId,productName: orderDetailsData[0].productName,variantCode: orderDetailsData[0].variantCode!),
                                              // article: articles[index],
                                            )));
                                  },
                                ),

                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: AppColors.tileLine,
                          ),
                          InkWell(

                            child: Container(
                              color: AppColors.white,

                              child: Padding(
                                padding: const EdgeInsets.only(top: 26.0,bottom: 24.0),
                                child: Column(children: [

                                  RatingBar(
                                    initialRating: double.parse(orderDetailsData[0].starRate!),
                                    // minRating: 1,
                                    ignoreGestures: true,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 28,
                                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    ratingWidget: RatingWidget(
                                      full: const Icon(
                                        Icons.star,
                                        color: AppColors.startBat,
                                        size: 18,
                                      ),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: AppColors.startBat,
                                        size: 18,
                                      ),
                                      empty: const Icon(
                                        Icons.star_outline,
                                        color: AppColors.startBat,
                                        size: 18,
                                      ),
                                    ),
                                    // itemBuilder: (context, _) =>
                                    //     Icon(
                                    //   Icons.star_border_rounded,
                                    //   color: AppColors.appRed,
                                    //   size: 10,
                                    // ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text("Write a review",
                                      style: GoogleFonts.inriaSans(
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: AppColors.appRed))),
                                ],),
                              ),
                              width: MediaQuery.of(context).size.width,
                            ),
                            onTap: (){

                              TextEditingController writeReviewController = TextEditingController();
                              TextEditingController titleReviewController = TextEditingController();
                              int rate = 0;

                              print("orderDetailsData[0].reviewFlag! =====================>  ${orderDetailsData[0].reviewFlag!}");

                              if(orderDetailsData[0].reviewFlag! == false){
                                showModalBottomSheet(
                                  context: context,
                                  isDismissible:false,
                                  isScrollControlled: true,
                                  transitionAnimationController: controller,
                                  builder: (BuildContext context) {

                                    return  Padding(
                                      padding: MediaQuery.of(context).viewInsets,
                                      child: Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [


                                                    Text("Review",
                                                        style: GoogleFonts.inriaSans(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700,
                                                                color: AppColors.black))),
                                                    InkWell(
                                                        onTap: (){
                                                          // mobile!.clear();
                                                          Get.back();
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Image.asset("assets/img/close.png",fit: BoxFit.fill,height: 15,width: 15,),
                                                        ))
                                                  ],
                                                ),
                                                SizedBox(height: 24,),

                                                Center(
                                                  child: RatingBar(
                                                    initialRating: 5,
                                                    // minRating: 1,
                                                    ignoreGestures: false,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemSize: 30,
                                                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                    ratingWidget: RatingWidget(
                                                      full: const Icon(
                                                        Icons.star,
                                                        color: AppColors.startBat,
                                                        size: 18,
                                                      ),
                                                      half: const Icon(
                                                        Icons.star_half,
                                                        color: AppColors.startBat,
                                                        size: 18,
                                                      ),
                                                      empty: const Icon(
                                                        Icons.star_outline,
                                                        color: AppColors.startBat,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    // itemBuilder: (context, _) =>
                                                    //     Icon(
                                                    //   Icons.star_border_rounded,
                                                    //   color: AppColors.appRed,
                                                    //   size: 10,
                                                    // ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating.toString());
                                                      rate = rating.toInt();
                                                      print("rating.toStringAsFixed(1) ${rating.toStringAsFixed(1)}" );

                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),

                                                Text("Write a title",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                            color: AppColors.black))),
                                                SizedBox(height: 2,),

                                                Container(
                                                  child: TextFormField(
                                                    // focusNode: myFocusNode,
                                                    textAlign: TextAlign.start,
                                                    // keyboardType: TextInputType.phone,
                                                    textInputAction: TextInputAction.next,

                                                    controller: titleReviewController,
                                                    // obscureText: controller.showPassword.value,
                                                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black)),
                                                    cursorColor: AppColors.appText1,
                                                    decoration: InputDecoration(
                                                      labelStyle : GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),
                                                      // labelStyle: TextStyle(
                                                      //     color: myFocusNode.hasFocus ? Colors.purple : AppColors.appText1
                                                      // ),
                                                      contentPadding: EdgeInsets.all(16),
                                                      // suffixIcon: IconButton(
                                                      //     onPressed: () {
                                                      //       controller.toggleShowPassword();
                                                      //     },
                                                      //     icon: controller.showPassword.value
                                                      //         ? Icon(Icons.visibility_off)
                                                      //         : Icon(Icons.visibility)),

                                                      hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),


                                                      hintText: 'Type here',
                                                      // labelText: 'Mobile Number*',
                                                      enabledBorder:OutlineInputBorder(
                                                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                                        borderRadius: BorderRadius.circular(2.0),

                                                      ),
                                                      focusedBorder:OutlineInputBorder(
                                                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                                        borderRadius: BorderRadius.circular(2.0),
                                                      ),
                                                      // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))

                                                      // border: OutlineInputBorder(),

                                                    ),
                                                  ),
                                                ),

                                                SizedBox(height: 24,),

                                                Text("Write a review",
                                                    style: GoogleFonts.inriaSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                            color: AppColors.black))),
                                                SizedBox(height: 2,),
                                                Container(
                                                  child: TextFormField(
                                                    // focusNode: myFocusNode,
                                                    textAlign: TextAlign.start,
                                                    maxLines: 5,
                                                    // keyboardType: TextInputType.phone,
                                                    // textInputAction: TextInputAction.done,

                                                    controller: writeReviewController,
                                                    // obscureText: controller.showPassword.value,
                                                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.black)),
                                                    cursorColor: AppColors.appText1,
                                                    decoration: InputDecoration(
                                                      labelStyle : GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),
                                                      // labelStyle: TextStyle(
                                                      //     color: myFocusNode.hasFocus ? Colors.purple : AppColors.appText1
                                                      // ),
                                                      contentPadding: EdgeInsets.all(16),
                                                      // suffixIcon: IconButton(
                                                      //     onPressed: () {
                                                      //       controller.toggleShowPassword();
                                                      //     },
                                                      //     icon: controller.showPassword.value
                                                      //         ? Icon(Icons.visibility_off)
                                                      //         : Icon(Icons.visibility)),

                                                      hintStyle: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12)),


                                                      hintText: 'Type here',
                                                      // labelText: 'Mobile Number*',
                                                      enabledBorder:OutlineInputBorder(
                                                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                                        borderRadius: BorderRadius.circular(2.0),

                                                      ),
                                                      focusedBorder:OutlineInputBorder(
                                                        borderSide: const BorderSide(color: AppColors.appText1, width: 1.0),
                                                        borderRadius: BorderRadius.circular(2.0),
                                                      ),
                                                      // labelStyle:  GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 15))

                                                      // border: OutlineInputBorder(),

                                                    ),
                                                  ),
                                                ),

                                                SizedBox(height: 24,),
                                                InkWell(
                                                    onTap: () {
                                                      FocusManager.instance.primaryFocus?.unfocus();

                                                      print("orderId ${orderHistory!.orderId!.toString()}");
                                                      print("productId ${orderDetailsData[0].productId.toString()}");
                                                      print("customerId ${myOrderController!.customerId}");
                                                      print("customerName ${myOrderController!.customerName}");
                                                      print("rating ${rate.toString()}");
                                                      print("titleReviewController ${titleReviewController.text}");
                                                      print("writeReviewController ${writeReviewController.text}");


                                                      myOrderController!.addProductRatingReviews(
                                                          orderHistory!.orderId!.toString(),
                                                          orderDetailsData[0].productId.toString(),
                                                          myOrderController!.customerId,
                                                          myOrderController!.customerName,
                                                          rate.toString(),
                                                          titleReviewController.text,
                                                          writeReviewController.text);

                                                    },
                                                    child: DefaultBTN(
                                                      btnText: "SUBMIT",
                                                    )),


                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                  },
                                );
                              }


                            },
                          ),
                          SizedBox(height: 16,),
                          InkWell(

                            child: Container(
                              color: AppColors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0,bottom: 16,left: 16,right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                  Text(
                                    "Download Invoice",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                    // Image.asset("assets/img/Download_Invoice.png", fit: BoxFit.fill,height: 18,width: 16,),
                                    Row(
                                      children: [
                                        downloading ?downloadingComplete?
                                        Text('Downloading File: inProgress',style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400)),):Text('Download Completed',style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.green,
                                                fontWeight: FontWeight.w400)),):Container(),
                                        SizedBox(width: 15,),
                                        Image.asset("assets/img/Download_Invoice.png", fit: BoxFit.fill,height: 18,width: 16,),
                                      ],
                                    ),

                                ],),
                              ),
                            ),
                            onTap: ()  async {
                              setState(() {
                                downloading = true;
                                downloadingComplete = true;
                              });



                              print("invoiceUrl   ====================> $invoiceUrl");

                             // downloadFile(invoiceUrl,"${orderDetailsData[0].orderNumber}-${orderDetailsData[0].productId}");
                              DateTime now =  DateTime.now();
                              final directory = await getExternalStorageDirectory();



                              print("directory ===================> ${downloadsDirectory!.path}");





                              print("===================>  ${orderDetailsData[0].orderNumber}-${now.microsecondsSinceEpoch}.pdf");


                              final taskId = await FlutterDownloader.enqueue(
                                url: invoiceUrl,
                                headers: {}, // optional: header send with url (auth token etc)
                                savedDir:  downloadsDirectory!.path,
                                fileName: "${orderDetailsData[0].orderNumber}-${now.microsecondsSinceEpoch}.pdf",
                                showNotification: true, // show download progress in status bar (for Android)
                                openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                              );

                              // setState(() {
                              //   downloading = true;
                              // });

                              print("taskId ======>$taskId");
                              setState(() {
                                downloadingComplete = false;
                              });


                            },
                          ),
                          SizedBox(height: 16,),
                          Container(
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Shipping Details",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.orderDetailTitle,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: AppColors.tileLine,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Text(
                                        "${orderDetailsData[0].deliveryAddress![0].name}",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        "${orderDetailsData[0].deliveryAddress![0].address}",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Text(
                                        "${orderDetailsData[0].deliveryAddress![0].city} - ${orderDetailsData[0].deliveryAddress![0].pincode}",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      Text(
                                        "${orderDetailsData[0].deliveryAddress![0].state}",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      // SizedBox(height: 16,),

                                      Text(
                                        "Mobile : ${orderDetailsData[0].deliveryAddress![0].mobile}",
                                        style: GoogleFonts.inriaSans(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w300)),
                                      ),

                                      // Text(
                                      //   "Size: 38",
                                      //   style: GoogleFonts.inriaSans(
                                      //       textStyle: const TextStyle(
                                      //           fontSize: 14,
                                      //           color: AppColors.appText1,
                                      //           fontWeight: FontWeight.w300)),
                                      // ),
                                    ],),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
                          Container(
                            color: AppColors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "Price Details",
                                    style: GoogleFonts.inriaSans(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.orderDetailTitle,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: AppColors.tileLine,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total MRP",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                          Text("₹ ${orderDetailsData[0].mrpPrice}",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Discount on MRP",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                          Text("-₹ ${orderDetailsData[0].discountAmt}",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.appGreen))),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Coupon Discount",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.black))),
                                          Text("Apply Coupon",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.appRed))),
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Convenience Fee",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.black))),
                                              Text(" Know More",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.appRed))),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("₹99",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          decoration:
                                                          TextDecoration
                                                              .combine([
                                                            TextDecoration
                                                                .lineThrough
                                                          ]),
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          color: AppColors
                                                              .black))),
                                              SizedBox(width: 5.0,),
                                              Text("FREE",
                                                  style: GoogleFonts.inriaSans(
                                                      textStyle: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: AppColors.appRed))),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8,),

                                      SizedBox(height: 8,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Amount",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.black))),
                                          Text("₹ ${orderDetailsData[0].totalAmt}",
                                              style: GoogleFonts.inriaSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.black))),
                                        ],
                                      ),


                                    ],),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 16,),

                        ],);
                      }

                    } else {
                      return  Container(
                        height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator(color: AppColors.appColor)));

                    }
                  }),










                  // Padding(
                  //   padding: const EdgeInsets.only(right: 14.0,left: 14.0),
                  //   child: Row(children: [
                  //     Stack(
                  //       children: [
                  //         Image.asset("assets/img/box.png", fit: BoxFit.fill,height: 40,width: 40,),
                  //         Positioned(
                  //             bottom: 5,
                  //             right: 0,
                  //             child: Image.asset("assets/img/delivered.png", fit: BoxFit.fill,height: 12,width: 12,)),
                  //       ],
                  //     ),
                  //     SizedBox(width: 8,),
                  //     Column(
                  //
                  //       crossAxisAlignment:CrossAxisAlignment.start,children: [
                  //       Text(
                  //         "Delivered",
                  //         style: GoogleFonts.inriaSans(
                  //             textStyle: const TextStyle(
                  //                 fontSize: 16,
                  //                 color: AppColors.appGreen,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //       SizedBox(width: 5,),
                  //       Text(
                  //         "Expected on 1 Oct 2022",
                  //         style: GoogleFonts.inriaSans(
                  //             textStyle: const TextStyle(
                  //                 fontSize: 16,
                  //                 color: AppColors.appText1,
                  //                 fontWeight: FontWeight.w700)),
                  //       ),
                  //     ],)
                  //   ],),
                  // ),
                  // SizedBox(height: 20,),
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14.0,right: 14.0),
                  //   child: Column(children: myOrderController.list1.map((e) =>  Padding(
                  //     padding: const EdgeInsets.only(bottom: 20),
                  //     child: Column(
                  //
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Image.asset("assets/img/product4.png", fit: BoxFit.fill,height: 100,width: 100,),
                  //                 SizedBox(width: 8,),
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Roadster",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 18,
                  //                               color: AppColors.black,
                  //                               fontWeight: FontWeight.w700)),
                  //                     ),
                  //                     Text(
                  //                       "Men Green Casual Shirt",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 16,
                  //                               color: AppColors.appText1,
                  //                               fontWeight: FontWeight.w300)),
                  //                     ),
                  //                     Text(
                  //                       "Size: 38",
                  //                       style: GoogleFonts.inriaSans(
                  //                           textStyle: const TextStyle(
                  //                               fontSize: 16,
                  //                               color: AppColors.appText1,
                  //                               fontWeight: FontWeight.w300)),
                  //                     ),
                  //                   ],)
                  //               ],
                  //             ),
                  //             Image.asset("assets/img/arrow_right.png"),
                  //           ],),
                  //         SizedBox(height: 8,),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               height: 10,width: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.appText1,),
                  //             ),
                  //             SizedBox(width: 5,),
                  //             Text(
                  //               "Arrived at Surat on Tue, 27 Oct 2022 at 12:30 A.M.",
                  //               style: GoogleFonts.inriaSans(
                  //                   textStyle: const TextStyle(
                  //                       fontSize: 14,
                  //                       color: AppColors.appText1,
                  //                       fontWeight: FontWeight.w700)),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),).toList(),),
                  // )


                ],
              ),
            ),
          ],
        ),
      ),
    );



    // return SajiloDokanScaffold(
    //   leading: true,
    //   title: null,
    //   body:
    //
    //   SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Column(
    //         // physics: const NeverScrollableScrollPhysics(),
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                   onTap: (){
    //                     Get.back();
    //                   },
    //                   child: Icon(Icons.arrow_back_ios,size: 25,)),
    //               Icon(Icons.search,size: 30,)
    //             ],),
    //           SizedBox(height: 12,),
    //           const Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Text("My Orders",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    //           ),
    //           SizedBox(height: 8,),
    //
    //         RefreshIndicator(
    //             onRefresh: () async {
    //               CheckInternet.checkInternet();
    //               await myOrderController.loadUser();
    //             },
    //             child: Obx(() {
    //               if (myOrderController.isLoadingGetOrderHistory.value != true) {
    //                 MainResponse? mainResponse = myOrderController.getOrderHistoryObj.value;
    //                 List<OrderHistory>? getOrderHistoryData = [];
    //                 if(mainResponse.data != null){
    //                   mainResponse.data!.forEach((v) {
    //                     getOrderHistoryData.add( OrderHistory.fromJson(v));
    //                   });
    //                 }
    //                 // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
    //
    //
    //                 String? imageUrl = mainResponse.imageUrl ?? "";
    //                 String? message = mainResponse.message ?? AppConstants.noInternetConn;
    //                 if (getOrderHistoryData.isEmpty) {
    //                   return Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: ListView(
    //                       // physics: NeverScrollableScrollPhysics(),
    //                       shrinkWrap: true,
    //                       children: [
    //                         Container(
    //                           width: MediaQuery.of(context).size.width,
    //                           height: MediaQuery.of(context).size.height-260,
    //                           //height: MediaQuery.of(context).size.height,
    //                           alignment: Alignment.center,
    //                           child: Center(
    //                             child: Text(
    //                               message!,
    //                               style: TextStyle(color: Colors.black45),
    //                             ),
    //                           ),
    //                         ),
    //
    //                       ],
    //                     ),
    //                   );
    //                 }else{
    //
    //                   return   Container(
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: ListView(
    //                       children: [
    //
    //                         ...List.generate(getOrderHistoryData.length, (index) => MyOrderTile(orderHistory: getOrderHistoryData[index],index: index,imageUrl: imageUrl,))
    //                       ],
    //                     ),
    //                   );
    //
    //                 }
    //
    //               } else {
    //                 return  Container(
    //                     height: MediaQuery.of(context).size.height-160,
    //                     child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
    //
    //               }
    //             }),
    //           ),
    //
    //         ],
    //       ),
    //     ),
    //   ),
    //
    //
    //   searchOnTab: () {},
    // );
  }



  // @override
  // Widget build(BuildContext context) {
  //   // final list = myOrderController!.productList
  //   //     .where((i) => i.price! <= 5000)
  //   //     .toList();
  //   return SajiloDokanScaffold(
  //     leading: true,
  //     title: null,
  //     body:
  //
  //
  //
  //
  //     SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: Column(
  //
  //           children: [
  //             //  SizedBox(
  //             //   height: 8,
  //             // ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 InkWell(
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     child: Icon(
  //                       Icons.arrow_back_ios,
  //                       size: 22,
  //                     )),
  //                 const Text(
  //                   "Order Details",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  //                 ),
  //                 Icon(
  //                   Icons.search,
  //                   size: 25,
  //                 )
  //               ],
  //             ),
  //              SizedBox(
  //               height: 8,
  //             ),
  //
  //             RefreshIndicator(
  //               onRefresh: () async {
  //                 CheckInternet.checkInternet();
  //                 await myOrderController!.orderDetail(orderHistory!.orderId!);
  //               },
  //               child: Obx(() {
  //                 if (myOrderController!.isLoadingOrderDetail.value != true) {
  //                   MainResponse? mainResponse = myOrderController!.orderDetailObj.value;
  //                   List<OrderDetail>? getOrderDetailData = [];
  //                   if(mainResponse.data != null){
  //                     mainResponse.data!.forEach((v) {
  //                       getOrderDetailData.add( OrderDetail.fromJson(v));
  //                     });
  //                   }
  //                   // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
  //
  //
  //                   String? imageUrl = mainResponse.imageUrl ?? "";
  //                   String? message = mainResponse.message ?? AppConstants.noInternetConn;
  //                   if (getOrderDetailData.isEmpty) {
  //                     return Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       height: MediaQuery.of(context).size.height-100,
  //                       child: ListView(
  //                         // physics: NeverScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         children: [
  //                           Container(
  //                             width: MediaQuery.of(context).size.width,
  //                             height: MediaQuery.of(context).size.height-100,
  //                             //height: MediaQuery.of(context).size.height,
  //                             alignment: Alignment.center,
  //                             child: Center(
  //                               child: Text(
  //                                 message!,
  //                                 style: TextStyle(color: Colors.black45),
  //                               ),
  //                             ),
  //                           ),
  //
  //                         ],
  //                       ),
  //                     );
  //                   }else{
  //
  //                     return
  //
  //                       Container(
  //                         height: MediaQuery.of(context).size.height-100,
  //                         child: ListView(
  //                           // mainAxisAlignment: MainAxisAlignment.start,
  //                           // crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             SizedBox(
  //                               height: 12,
  //                             ),
  //                             Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   rowWidget("Order No : ", orderHistory!.orderNumber, Colors.grey,
  //                                       Colors.black, FontWeight.w400, FontWeight.bold),
  //                                   rowWidget(orderHistory!.orderDate!, "", Colors.grey, Colors.grey,
  //                                       FontWeight.w400, FontWeight.w400),
  //                                 ]),
  //                             SizedBox(
  //                               height: 10.0,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 rowWidget("Tracking No : ", "IWJKD001SS", Colors.grey,
  //                                     Colors.black, FontWeight.w400, FontWeight.bold),
  //                                 Text(
  //                                   "Delivered",
  //                                   style: TextStyle(color: Colors.red),
  //                                 )
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 10.0,
  //                             ),
  //                             Text("${getOrderDetailData.length} items",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
  //                             SizedBox(
  //                               height: 10.0,
  //                             ),
  //                             // myOrderController.isLoading.value != false
  //                             //     ?
  //                             Column(
  //                               children: getOrderDetailData.map((element) {
  //                                 double mrp = double.parse(element.mrpPrice!) * double.parse(element.quantity!);
  //                                 return Padding(
  //                                   padding: const EdgeInsets.only(bottom: 8.0),
  //                                   child: Column(
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Container(
  //                                             height: 120,
  //                                             width: 120,
  //                                             child: ClipRRect(
  //                                               borderRadius: BorderRadius.circular(10.0),
  //                                               child: Center(
  //                                                 child: Image.network(
  //                                                   imageUrl + element.productId! +"/"+
  //                                                       element.coverImg!,
  //                                                   height: 120,
  //                                                   width: 120,
  //                                                   fit: BoxFit.contain,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 10,),
  //                                           Flexible(
  //                                             child: Column(
  //                                               crossAxisAlignment: CrossAxisAlignment.start,
  //                                               children: [
  //                                                 Text(
  //                                                   element.productName!,
  //                                                   maxLines: 2,
  //                                                   // style: GoogleFonts.ptSans(),
  //                                                   overflow: TextOverflow.ellipsis,
  //                                                 ),
  //                                                 SizedBox(
  //                                                   height: 5,
  //                                                 ),
  //                                                 // Row(
  //                                                 //   children: [
  //                                                 //     ProductRating(
  //                                                 //       rating: element.avaragereview,
  //                                                 //       isReadOnly: true,
  //                                                 //       size: 15,
  //                                                 //       filledIconData: Icons.star,
  //                                                 //       borderColor: Colors.red,
  //                                                 //       color: Colors.red,
  //                                                 //       halfFilledIconData: Icons.star_half,
  //                                                 //       defaultIconData: Icons.star_border,
  //                                                 //       starCount: 5,
  //                                                 //       allowHalfRating: true,
  //                                                 //     )
  //                                                 //     // Text(
  //                                                 //     //   ' ' +
  //                                                 //     //       element.avaragereview.toString(),
  //                                                 //     //   style: TextStyle(color: Colors.red),
  //                                                 //     // )
  //                                                 //   ],
  //                                                 // ),
  //                                                 // SizedBox(
  //                                                 //   height: 5,
  //                                                 // ),
  //                                                 // Text(
  //                                                 //   'Rs ' + double.parse(element.netPrice!).toStringAsFixed(2),
  //                                                 //   style: TextStyle(color: Colors.redAccent),
  //                                                 // )
  //
  //                                                 Row(
  //                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                                   children: [
  //                                                     Row(
  //                                                       crossAxisAlignment: CrossAxisAlignment.end,
  //                                                       children: [
  //                                                         Column(
  //                                                           crossAxisAlignment: CrossAxisAlignment.start,
  //                                                           children: [
  //                                                             Text(
  //                                                               '\u{20B9} ' + "${mrp.toStringAsFixed(0)}",
  //                                                               style:  TextStyle(
  //                                                                   decoration: TextDecoration.combine(
  //                                                                       [ TextDecoration.lineThrough]),
  //                                                                   fontSize: 16,
  //                                                                   fontWeight: FontWeight.bold,
  //                                                                   color: Colors.grey),
  //                                                             ),
  //                                                             Text(
  //                                                               '\u{20B9} ' + "${double.parse(element.totalAmt!).toStringAsFixed(0)}",
  //                                                               style: const TextStyle(
  //                                                                   fontSize: 16,
  //                                                                   fontWeight: FontWeight.bold,
  //                                                                   color: Colors.black),
  //                                                             ),
  //                                                           ],
  //                                                         ),
  //                                                         SizedBox(width: 10,),
  //                                                         Text(
  //                                                           '\u{20B9} ' + element.discount.toString() + " % off",
  //                                                           style: const TextStyle(
  //                                                               fontSize: 14,
  //                                                               fontWeight: FontWeight.bold,
  //                                                               color: Colors.redAccent),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                     Text('Qty:${element.quantity}')
  //                                                   ],
  //                                                 )
  //                                               ],
  //                                             ),
  //                                           )
  //                                         ],
  //                                       ),
  //                                       SizedBox(
  //                                         height: 8.0,
  //                                       ),
  //                                       Container(color: Colors.red,height: 0.2,)
  //                                     ],
  //                                   ),
  //                                 );
  //                               }).toList(),
  //                             ),
  //                             //     :
  //                             //
  //                             //
  //                             // CircularProgressIndicator(),
  //                             const Text("Order information",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
  //
  //                             orderInfoRowWidget("Shipping Address", "3 NewBridge Count, CA 97454, United States", Colors.grey,
  //                                 Colors.black, FontWeight.w400, FontWeight.w400),
  //                             orderInfoRowWidget("Payment method", "**** **** **** 3974", Colors.grey,
  //                                 Colors.black, FontWeight.w400, FontWeight.w400),
  //                             orderInfoRowWidget("Delivery method", 'FedEx, 3 day, 15\$', Colors.grey,
  //                                 Colors.black, FontWeight.w400, FontWeight.w400),
  //                             orderInfoRowWidget("Discount", "10%, Personal promo code", Colors.grey,
  //                                 Colors.black, FontWeight.w400, FontWeight.w400),
  //                             orderInfoRowWidget("Total Amount", "210\$", Colors.grey,
  //                                 Colors.black, FontWeight.w400, FontWeight.w400),
  //
  //                           ],
  //                         ),
  //                       );
  //
  //                   }
  //
  //                 } else {
  //                   return  Container(
  //                       height: MediaQuery.of(context).size.height-160,
  //                       child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
  //
  //                 }
  //               }),
  //             ),
  //
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //     searchOnTab: () {},
  //   );
  // }
  //
  // rowWidget(String title, des, Color color1, color2, FontWeight fontWeight1,
  //     fontWeight2) {
  //   return Row(
  //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         title,
  //         style:
  //             TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
  //       ),
  //       Text(
  //         des,
  //         style:
  //             TextStyle(fontSize: 16, color: color2, fontWeight: fontWeight2,),
  //       )
  //     ],
  //   );
  // }
  //
  // orderInfoRowWidget(String title, des, Color color1, color2, FontWeight fontWeight1,
  //     fontWeight2) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           width: 150,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 title,
  //                 style:
  //                 TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
  //               ),
  //               Text(
  //                 ": ",
  //                 style:
  //                 TextStyle(fontSize: 16, color: color1, fontWeight: fontWeight1),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             des,
  //             softWrap: true,
  //             style:
  //             TextStyle(fontSize: 16, color: color2, fontWeight: fontWeight2,),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
