import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class BlockHeader extends StatelessWidget {
  final double? width;
  final String? title;
  final String? linkText;
  final VoidCallback? onLinkTap;
  const BlockHeader({this.width, this.title, this.linkText, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        child: Row(
          children: [
            Text(
              title!,
              style:
            TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
            ),
            Spacer(),
            InkWell(
                onTap: onLinkTap,
                child: Text(
                  linkText!,
                  style:TextStyle(color: Colors.green),
                ))
          ],
        ),
      ),
    );
  }
}
