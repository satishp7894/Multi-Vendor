import 'package:flutter/material.dart';

class ListItemCart extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onPressed;

  const ListItemCart({this.icon, this.title, this.onPressed});

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
                Icon(
                  icon,
                  size: 25,
                  color: const Color(0xFFFF7643),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    title!,
                    style:
                        const TextStyle(color: Color(0xFFFF7643), fontSize: 18),
                  ),
                ),
                // Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFFF7643),
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
