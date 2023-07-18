import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_food_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  Map<int , CartModel> _items={};
  Map<int ,CartModel> get items =>_items;
  void addItems(Products product , int quantity){
    if(_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
        );
      }
      );
    }else {
      _items.putIfAbsent(product.id!, () => CartModel(
      id: product.id,
      name: product.name,
      price: product.price,
      img: product.img,
      quantity: quantity,
      isExist: true,
      time: DateTime.now().toString(),
    ));
    }
  }
   int getQuantity(Products product){
    var quantity=0;
      if(_items.containsKey(product.id!)){
        _items.forEach((key, value) {
          if(key==product.id!) {
            quantity = value.quantity!;
          }
        });

      }
    return quantity;

   }


  

}