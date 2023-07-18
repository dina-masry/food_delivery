import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/colors.dart';
import 'big_text.dart';
import 'icons_and_text_widgets.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text),
        SizedBox(height: 15.h,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star , color: AppColors.mainColor,size: 15,)),
            ),
            SizedBox(width: 10.w,),
            SmallText(text: "4.5"),
            SizedBox(width: 10.w,),
            SmallText(text: "1287"),
            SizedBox(width: 10.w,),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: 15.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconsAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
            IconsAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
            IconsAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2)

          ],
        )
      ],
    );
  }
}
