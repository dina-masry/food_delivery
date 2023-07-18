import 'package:food_delivery/api/api_response.dart';
import 'package:food_delivery/api/popular_api_controller.dart';
import 'package:food_delivery/models/popular_food_model.dart';
import 'package:get/get.dart';

class ProductsGetXController extends GetxController{
   final PopularApiController popularApiController;
  ProductsGetXController({required this.popularApiController});
  List<dynamic> _popularProductList = [];
  int count =0;
  List<dynamic> get popularProductsList => _popularProductList;

  Future<void> getPopularProductsList()async{
    Response response = (await popularApiController.getListOfProducts()) as Response;
    if(response.statusCode ==200){
      _popularProductList=[];
      //_popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    }
  }


}