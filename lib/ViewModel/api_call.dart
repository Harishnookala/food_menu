import 'package:flutter/material.dart';
import 'package:products_task/model/product.dart';
import 'dart:convert';

class Request{
   static Future<List<Product>> load_product(BuildContext context) async{
     String json_data = await DefaultAssetBundle.of(context).loadString("jsonData/sample.json");
     final jsonResult = json.decode(json_data) as List;
     List<Product> result =
     jsonResult.map((i) => Product.fromJson(i)).toList();
     return result;
   }
}