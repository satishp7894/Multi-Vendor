import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemCart extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final String? subTitle;
  final bool? last;
  final VoidCallback? onPressed;

  const ListItemCart({this.iconPath, this.title,this.subTitle,this
  .last= true,this.onPressed});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Container(
    //       color: AppColors.white,
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 15, right: 15, top: 15,bottom: 15),
    //         child: InkWell(
    //           onTap: onPressed,
    //           child: ClipRRect(
    //             borderRadius: BorderRadius.circular(20),
    //             child: TextButton(
    //               onPressed: (){
    //                 onPressed!();
    //               },
    //               child:
    //               Row(
    //                 children: [
    //                   Image.asset(iconPath!,fit: BoxFit.fill,height: 20,width: 30,),
    //                   // Icon(
    //                   //   icon,
    //                   //   size: 25,
    //                   //   color: const Color(0xFFFF7643),
    //                   // ),
    //                   const SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           title!,
    //                           style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.appText))
    //                               // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
    //                         ),
    //                         Text(
    //                           subTitle!,
    //                             style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 10,color: AppColors.appText1))
    //                           // style:
    //                           // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   // Spacer(),
    //                   Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
    //                   // const Icon(
    //                   //   Icons.arrow_forward_ios,
    //                   //   color: Color(0xFF898989),
    //                   //   size: 20,
    //                   // )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //    // SizedBox(height: 15,),
    //     last == true ?
    //     Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,):Container()
    //   ],
    // );

    return  Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0),
            child: Center(
              child: InkWell(
                onTap: onPressed,
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(

                      children: [
                        Image.asset(iconPath!,fit: BoxFit.fill,height: 20,width: 30,),
                        // Icon(
                        //   icon,
                        //   size: 25,
                        //   color: const Color(0xFFFF7643),
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: Container(
                            // color: Colors.amberAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    title!,
                                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 14,color: AppColors.appText))
                                  // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                                ),
                                Text(
                                    subTitle!,
                                    style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 10,color: AppColors.appText1))
                                  // style:
                                  // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Spacer(),

                        // const Icon(
                        //   Icons.arrow_forward_ios,
                        //   color: Color(0xFF898989),
                        //   size: 20,
                        // )
                      ],
                    ),
                    Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill,height: 12,width: 8,),
                  ],
                ),
              ),
            ),
          ),
        ),
            last == true ?
            Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.tileLine,):Container()
      ],
    );
  }
}
