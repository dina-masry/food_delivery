import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

extension ContextExtension on BuildContext{
   void showSnackBar({required String message }){
    ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content:Text(message),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.mainColor,

        )
    );
  }

}