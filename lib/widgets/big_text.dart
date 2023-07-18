import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class BigText extends StatelessWidget {
   Color? color;
  final String text ;
  double size;
  TextOverflow overflow;
   BigText({Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text ,
      overflow: overflow,
      maxLines: 1,
      style:GoogleFonts.roboto(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size
      ),


    );
  }
}
