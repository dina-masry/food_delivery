import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconsAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor ;
  const IconsAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Row(
        children: [
          Icon(icon , color: iconColor,),
          SizedBox(width: 5.w,),
          SmallText(text:text,)
        ],
      ),
    );
  }
}
