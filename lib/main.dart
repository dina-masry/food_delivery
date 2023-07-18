import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/screens/food/recommended_food_details.dart';
import 'package:food_delivery/screens/home_page/main_home_page.dart';
import 'package:food_delivery/screens/food/popular_food_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(411.4,852.6),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/home',
            routes:{
              '/home':(context)=>const Home(),
              //'/popular_food_details':(context)=>PopularFoodDetails(0),
              //'/recommended_food_details':(context)=>RecommendedFoodDetails(),

            }

        );
      },
    );
  }
}

