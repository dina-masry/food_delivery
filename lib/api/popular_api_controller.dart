import 'dart:convert';
import '../models/popular_food_model.dart';
import 'api_settings.dart';
import 'package:http/http.dart'as http;

class PopularApiController{

  Future<List<Products>> getListOfProducts()async{
    Uri uri = Uri.parse(ApiSettings.popularUri);
    var response = await http.get(uri);
    if(response.statusCode ==200){
      var jsonResponse = jsonDecode(response.body);
      var products= jsonResponse['products'] as List;
      return products.map((jsonObject) => Products.fromJson(jsonObject)).toList();
    }
    return [];



  }
}