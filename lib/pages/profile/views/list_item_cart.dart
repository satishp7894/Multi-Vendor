import 'package:eshoperapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemCart extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final String? subTitle;
  final VoidCallback? onPressed;

  const ListItemCart({this.iconPath, this.title,this.subTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: InkWell(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: TextButton(
            onPressed: (){
              onPressed!();
            },
            child: Row(
              children: [
                Image.asset(iconPath!,fit: BoxFit.fill),
                // Icon(
                //   icon,
                //   size: 25,
                //   color: const Color(0xFFFF7643),
                // ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 16,color: AppColors.appText))
                            // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                      ),
                      Text(
                        subTitle!,
                          style: GoogleFonts.inriaSans(textStyle: TextStyle(fontSize: 12,color: AppColors.appText1))
                        // style:
                        // const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                Image.asset("assets/img/arrow_right.png",fit: BoxFit.fill),
                // const Icon(
                //   Icons.arrow_forward_ios,
                //   color: Color(0xFF898989),
                //   size: 20,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
