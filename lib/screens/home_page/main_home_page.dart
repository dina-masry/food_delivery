import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/screens/home_page/home_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h,top:45.h),
            padding: EdgeInsets.only(left: 15.w,right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Palestine",color:AppColors.mainColor,),
                    Row(
                        children: [
                          SmallText(text: "Gaza",color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ]),
                  ],
                ),
                Center(
                  child: Container(
                    height: 45.h,
                      width: 45.w,
                      child: Icon(Icons.search ,color: Colors.white,),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
          Expanded(
              child: SingleChildScrollView(
                  child: HomePageBody())),
      ]),
    );
  }
}
