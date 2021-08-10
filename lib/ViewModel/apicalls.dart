import 'package:flutter/material.dart';
import 'package:products_task/model/product.dart';
import 'dart:convert';

class Api{
   static Future load_product(BuildContext context) async{
     String products_json = await DefaultAssetBundle.of(context).loadString("jsonData/sample.json");
     var result = jsonDecode(products_json) as List;
     return result;
   }
}