import 'package:flutter/material.dart';
import 'package:products_task/model/product.dart';

class Api{
   static Future<Product> load_product(BuildContext context) async{
     String products_json = await DefaultAssetBundle.of(context).loadString("jsonData/sample.json");
   }
}