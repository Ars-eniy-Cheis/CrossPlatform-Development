import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:shopping_app/shopping_model.dart';

class CRUDInterface{
  static void createElement(String name, double cost){
    ShoppingModel shoppingModel = ShoppingModel(name, cost, DateTime.now());
    var box = Hive.box<ShoppingModel>('shopping_box');
    box.add(shoppingModel);
  }

  static List<ShoppingModel> readAllElements(){
    final box = Hive.box<ShoppingModel>('shopping_box');
    return box.values.toList();
    //return box.values as List<ShoppingModel>;
  }


  static ShoppingModel? readElement(int key){
    var box = Hive.box<ShoppingModel>('shopping_box');
    return box.getAt(key);
  }

  static void updateElement(ShoppingModel element, String name, double cost){
    element.name = name;
    element.cost = cost;
    element.save();
  }

  static void deleteElement(ShoppingModel element){
    element.delete();
  }
}