import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/categories.dart';
import 'package:eshoperapp/models/category.dart';
import 'package:eshoperapp/models/product.dart';
import 'package:eshoperapp/style/theme.dart' as Style;
import 'package:eshoperapp/utils/check_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/app_bar_title.dart';
import 'category_product_controller.dart';
import 'category_product_screen.dart';

class CategoryProductListScreen extends StatefulWidget {
  final Categories? category;

  const CategoryProductListScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryProductListScreen> createState() => _CategoryProductListScreenState();
}

class _CategoryProductListScreenState extends State<CategoryProductListScreen> {
  CategoryProductController? categoryProductController;
  Categories? categories;

  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<int> _fetchedItems = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19
  ];

  List<String> itemsString = [
    "Dresses",
    "Tops & Tunics",
    "Shirts",
    "T-Shirts",
    "Jeans & Jeggings",
    "Bottoms",
    "Skirts",
    "Jumpsuits",
    "Co-ord sets",
    "Jackets, Coats & Hoodies",
    "Kurtis",
    "Sweatshirts",
    "Cardigans",
    "Bras",
    "Panties",
    "Blazer",
    "Shapewear",
    "Stockings",
    "Shrugs",
    "Gowns",
  ];
  List<int> _items = [];

  /// This holds the item count
  int counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    // dynamic argumentData = Get.arguments;
    // categories = argumentData[0]['categoryObj'];

    // dynamic argumentData = Get.arguments;
    categories = widget.category;
    // print("categoryObj categoryId ${categories!.categoryId}");
    // categoryProductController = Get.put(CategoryProductController(
    //     apiRepositoryInterface: Get.find(), categoryId: categories!.categoryId!, localRepositoryInterface: Get.find()));
    // initData(categoryProductController!,categories!);
    _loadItems();
    super.initState();
  }

  Future<void> _loadItems() async {
    for (int item in _fetchedItems) {
      // 1) Wait for one second
      await Future.delayed(Duration(milliseconds: 500));
      // 2) Adding data to actual variable that holds the item.
      _items.add(item);
      // 3) Telling animated list to start animation
      listKey.currentState?.insertItem(_items.length - 1);
    }
  }

  Widget slideIt(BuildContext context, int index, animation) {
    int item = _items[index];
    String itemString = itemsString[index];
    TextStyle? textStyle = Theme.of(context).textTheme.headline4;
    return SlideTransition(
      textDirection: TextDirection.rtl,
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInSine,
      )),
      child: InkWell(
        onTap: (){

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProductScreen(category: Categories(),

              ),
            ),
          );
        },
        child: Container(
          // height: 70.0,

          decoration: BoxDecoration(
            // color: Colors.amber,
            border: Border(
              bottom: BorderSide(
                //                   <--- left side
                width: 1,
                color: AppColors.toggleBg,
              ),

              // style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0,bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$itemString',
                    style: GoogleFonts.inriaSans(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black))),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: AppColors.grey, shape: BoxShape.circle),
                  child:  ClipRRect(borderRadius:
                  BorderRadius.circular(100),child: Image(image: AssetImage("assets/img/pic.png"),fit: BoxFit.contain,)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final CategoryArguments args =
    //     ModalRoute.of(context)!.settings.arguments as CategoryArguments;

    return Scaffold(
      // backgroundColor: Colors.green.withOpacity(0.1),
      // appBar: AppBar(
      //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      //   elevation: 0,
      // ),

      // appBar: AppBar(
      //   elevation: 5,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Image.asset("assets/img/arrow_left.png",fit: BoxFit.fill,height: 20,width: 22,),
      //
      //     // Icon(
      //     //   Icons.arrow_back,
      //     //   color: Style.Colors.appColor,
      //     //   size: 30,
      //     // ),
      //     onPressed: () =>  Get.back(),
      //   ),
      //   // title: Text("${categories!.categoryName!}", style: TextStyle(fontSize: 20,color: Style.Colors.appColor)),
      //   title: Text("WOMEN",
      //       style: GoogleFonts.inriaSans(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: AppColors.appText))),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            AppbarTitleWidget(title: "WOMEN",),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return CheckInternet.checkInternet();
                  // return categoryProductController!.categoryProduct(categories!.categoryId!);
                },
                child: SizedBox(
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: AnimatedList(
                      key: listKey,
                      initialItemCount: _items.length,
                      itemBuilder: (context, index, animation) {
                        return slideIt(context, index, animation);
                      },
                    ),
                  ),
                ),

                // Obx(() {
                //   if (categoryProductController!.isLoadingCategoryProduct.value != true) {
                //     CategoryProduct? categoryProduct = categoryProductController!.categoryProductObj.value;
                //     List<Products>? categoryProductData = [];
                //     if(categoryProduct.productData != null){
                //       categoryProduct.productData!.forEach((v) {
                //         categoryProductData.add( Products.fromJson(v));
                //       });
                //     }
                //
                //     List<Categories>? categoryData = [];
                //     if(categoryProduct.categoryData != null){
                //       categoryProduct.categoryData!.forEach((v) {
                //         categoryData.add( Categories.fromJson(v));
                //       });
                //     }
                //     // mainResponse.data!.map((e) => customerProfileData!.add(UpdateCustomerPasswordData.fromJson(e))).toList();
                //
                //
                //     String? imageUrl = categoryProduct.imageUrl ?? "";
                //     String? message = categoryProduct.message ?? AppConstants.noInternetConn;
                //
                //
                //
                //
                //     if (categoryProductData.isEmpty && categoryData.isEmpty) {
                //       return Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: MediaQuery.of(context).size.height,
                //         child: ListView(
                //           // physics: NeverScrollableScrollPhysics(),
                //           shrinkWrap: true,
                //           children: [
                //             Container(
                //               width: MediaQuery.of(context).size.width,
                //               height: MediaQuery.of(context).size.height-100,
                //               //height: MediaQuery.of(context).size.height,
                //               alignment: Alignment.center,
                //               child: Center(
                //                 child: Text(
                //                   message!,
                //                   style: TextStyle(color: Colors.black45),
                //                 ),
                //               ),
                //             ),
                //
                //           ],
                //         ),
                //       );
                //     }else{
                //
                //       if(categoryProductData.isNotEmpty){
                //         return ListView(
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(5.0),
                //               child: ProductGridviewTile(
                //                 products: categoryProductData,
                //                 imageUrl: imageUrl,
                //                 brandProductPage: true,
                //               ),
                //             ),
                //           ],
                //         );
                //       }else  if(categoryData.isNotEmpty){
                //
                //         return  Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: GridView.builder(
                //               gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //                 // maxCrossAxisExtent: 200,
                //                 // childAspectRatio: 3 / 2,
                //                   crossAxisCount: 3,
                //                   crossAxisSpacing: 0,
                //                   mainAxisSpacing: 0),
                //               itemCount: categoryData.length,
                //               itemBuilder: (BuildContext ctx, index) {
                //                 return Card(
                //                   elevation: 5,
                //                   child: InkWell(
                //                     onTap: () {
                //                       print("onTap");
                //                       // Get.toNamed(Routes.categoryProduct, arguments: [
                //                       //   {"categoryObj": categoryData[index]}
                //                       // ], preventDuplicates: false);
                //                       Navigator.pushReplacement(
                //                         context,
                //                         MaterialPageRoute(
                //                           builder: (context) => CategoryProductScreen(
                //                             category: categoryData[index],
                //                           ),
                //                         ),
                //
                //                       );
                //                       // controller.loadCategoryProducts(
                //                       //     getCategoryData[index].title);
                //                       // navigator!.pushNamed(Routes.categoryProduct,
                //                       //     arguments: CategoryArguments(
                //                       //         categoryName: getCategoryData[index].categoryName,
                //                       //         product: controller.categoryProducts,
                //                       //         category: getCategoryData[index].children));
                //                     },
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(10.0),
                //                       child: Stack(
                //                         children: [
                //                           categoryData[index].categoryImage == ""
                //                               ? Padding(
                //                             padding: const EdgeInsets.only(
                //                                 bottom: 10.0),
                //                             child: Container(
                //                                 height: 200,
                //                                 width: 200,
                //                                 decoration: BoxDecoration(
                //                                   //  border: Border.all(color: Colors.white,width: 2)
                //                                   borderRadius:
                //                                   BorderRadius.circular(15),
                //                                   // color: Colors.grey,
                //                                 ),
                //                                 child: Image.asset(
                //                                   "assets/img/placeholder.jpg",
                //                                   fit: BoxFit.fill,
                //                                 )),
                //                           )
                //                               : Padding(
                //                             padding: const EdgeInsets.only(
                //                                 bottom: 10.0),
                //                             child: Container(
                //                                 height: 200,
                //                                 width: 200,
                //                                 decoration: BoxDecoration(
                //                                   //  border: Border.all(color: Colors.white,width: 2)
                //                                   borderRadius:
                //                                   BorderRadius.circular(15),
                //                                   // color: Colors.grey,
                //                                 ),
                //                                 child: Image.network(
                //                                   imageUrl +
                //                                       categoryData[index]
                //                                           .categoryImage
                //                                           .toString(),
                //                                   fit: BoxFit.contain,
                //                                 )),
                //                           ),
                //                           Padding(
                //                             padding:
                //                             const EdgeInsets.only(bottom: 10.0),
                //                             child: Container(
                //                               height: 200,
                //                               width: 200,
                //                               decoration: BoxDecoration(
                //                                 // color: Colors.black26,
                //                                 //  border: Border.all(color: Colors.white,width: 2)
                //                                 borderRadius: BorderRadius.circular(15),
                //                               ),
                //                             ),
                //                           ),
                //                           Container(
                //                             alignment: Alignment.bottomCenter,
                //                             child: Container(
                //                                 decoration: BoxDecoration(
                //                                   color: Colors.red,
                //                                   // border: Border.all(color: Colors.white,width: 2)
                //                                   // borderRadius: BorderRadius.circular(15)
                //                                 ),
                //                                 child: Padding(
                //                                   padding: const EdgeInsets.all(3.0),
                //                                   child: Text(
                //                                     categoryData[index]
                //                                         .categoryName
                //                                         .toString(),
                //                                     maxLines: 1,
                //                                     textAlign: TextAlign.center,
                //                                     overflow: TextOverflow.ellipsis,
                //                                     style: TextStyle(
                //                                         color: Colors.white,
                //                                         fontWeight: FontWeight.w500,
                //                                         fontSize: 14),
                //                                   ),
                //                                 )),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                 );
                //               }),
                //         );
                //
                //         return Text("kfjdsklfdsf");
                //         // return Padding(
                //         //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                //         //   child: ProductGridviewTile(
                //         //     products: categoryData,
                //         //     imageUrl: imageUrl,
                //         //     brandProductPage: true,
                //         //   ),
                //         // );
                //       }else{
                //         return Container();
                //   }
                //
                //
                //
                //     }
                //
                //   } else {
                //     return  Container(
                //         // height: 200,
                //         child: Center(child: CircularProgressIndicator(color: Style.Colors.appColor)));
                //
                //   }
                // }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initData(CategoryProductController categoryProductController,
      Categories categories) async {
    print("categories.categoryId! ${categories.categoryId!}");
    await Future.delayed(const Duration(microseconds: 0), () {
      categoryProductController.categoryProduct(categories.categoryId!);
    });
  }
}

class CategoryArguments {
  final String? categoryName;
  final List<Product>? product;
  List<Category>? category;

  CategoryArguments({this.categoryName, this.product, this.category});
}
