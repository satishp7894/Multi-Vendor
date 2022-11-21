import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshoperapp/config/theme.dart';
import 'package:eshoperapp/models/get_slider.dart';
import 'package:eshoperapp/package/carousel.dart';
import 'package:flutter/material.dart';

// import 'package:sajilo_dokan/package/carousel.dart';
class SajiloCarousel extends StatelessWidget {
  final List<GetSliderData>? sliderList;
  final String? imageUrl;

  const SajiloCarousel({required this.sliderList, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.red,
        child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              // enlargeCenterPage: false,
              enlargeCenterPage: true,
              height: 200.0,
              viewportFraction: 1.0,
            ),
            items: getExpenseSliders(sliderList!, imageUrl!, context)));
  }

  getExpenseSliders(List<GetSliderData> sliderList, String imagePathe, BuildContext context) {
    return sliderList
        .map(
          (sliderObj) => GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailNews(
          //           article: sliderList,
          //         )));
        },
        child: Container(
          padding: EdgeInsets.only(
              left: 0.0, right: 0.0, top: 2.0, bottom: 2.0),
          child: Stack(
            children: <Widget>[
              sliderObj.sliderImage! == null
                  ? Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    // shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/img/placeholder.jpg")

                      //       image: article.img == null
                      //   ? AssetImage("assets/img/placeholder.jpg")
                      // : NetworkImage(article.img)
                    ),
                  ))
                  : Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    // shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:  NetworkImage(
                            imagePathe + sliderObj.sliderImage!)



                      //       image: article.img == null
                      //   ? AssetImage("assets/img/placeholder.jpg")
                      // : NetworkImage(article.img)
                    ),
                  )),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
              //     gradient: LinearGradient(
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter,
              //         stops: [
              //           0.1,
              //           0.9
              //         ],
              //         colors: [
              //           Colors.black.withOpacity(0.9),
              //           Colors.white.withOpacity(0.0)
              //         ]),
              //   ),
              // ),
              // Positioned(
              //     bottom: 8.0,
              //     child: Container(
              //       padding: EdgeInsets.only(left: 8.0, right: 8.0),
              //       // width: 250.0,
              //       width: MediaQuery.of(context).size.width,
              //       child: Text(
              //         sliderObj.sliderTitle!,
              //         style: TextStyle(
              //             // height: 1.5,
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 12.0),
              //       ),
              //     )),
              // Positioned(
              //     bottom: 10.0,
              //     left: 10.0,
              //     child: Text(
              //       "sliderObj",
              //       style: TextStyle(color: Colors.white54, fontSize: 9.0),
              //     )),
              // Positioned(
              //     bottom: 10.0,
              //     right: 10.0,
              //     child: Text("timeUntil",
              //       // timeUntil(DateTime.parse(sliderObj.sliderId!)),
              //       style: TextStyle(color: Colors.white54, fontSize: 9.0),
              //     )),
            ],
          ),
        ),
      ),
    )
        .toList();
  }
}
