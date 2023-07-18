import 'package:flutter/material.dart';
import 'package:food_delivery/get/cart_controller.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_food_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../extensions/extension.dart';

class PopularProductsGet extends GetxController{
 static PopularProductsGet get to => Get.find<PopularProductsGet>();
  int count =0;
  int _inCartItems =0;
  int get inCartItems => _inCartItems+count;
  late CartController _cart;
  void increment(){
    if(count <20){
      count+=1;
      update();

    }else{
      count =20;
      update();
    }
  }
  void decrement(){
    if(count >0){
      count-=1;
      update();
    }else{
      count=0;
      update();

    }
  }
  void initProduct(Products product,CartController cart){
    count=0;
    _inCartItems=0;
    _cart = cart;
    if(_cart.items.containsKey(product.id!)){
      _inCartItems = _cart.getQuantity(product);
      print("exist");
    }else{
      _inCartItems=0;
      print("not exist");
    }

  }
  void addItems(Products product){
    if(count>0) {
      _cart.addItems(product, count);
      count=0;
      _cart.items.forEach((key, value) {
        print('id is '+value.id.toString()+"the quantity is"+value.quantity.toString());
      });
    }else {
      Get.snackbar('Item Count', 'You should at least add one item',
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
    }

  }

}