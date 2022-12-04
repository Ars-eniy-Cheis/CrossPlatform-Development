import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_app/shopping_model.dart';
import 'package:shopping_app/shopping_page.dart';
import 'package:shopping_app/shopping_page_create.dart';

import 'crud_interface.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({Key? key}) : super(key: key);

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  Box<ShoppingModel> shoppingBox = Hive.box<ShoppingModel>('shopping_box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShoppingPageCreate(),
              ),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      appBar: AppBar(
        title: Text("Магазин"),
      ),
      body: ValueListenableBuilder(
        valueListenable: shoppingBox.listenable(),
        builder: (context, Box<ShoppingModel> box, _) {
          var shoppingList = CRUDInterface.readAllElements();
          //
          return ListView.builder(
            itemCount: shoppingList.length,
            itemBuilder: (context, index) {
              ShoppingModel? res = box.getAt(index);
              return ShoppingTile(
                  shoppingKey: index,
                  name: res?.name,
                  cost: res?.cost,
                  createdDate: res?.createdDate);
            },
          );
        },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    var box = Hive.box<ShoppingModel>('shopping_box');
    await box.compact();
    await box.close();
  }
}

class ShoppingTile extends StatelessWidget {

  late String name;
  late double cost;
  late DateTime createdDate;
  late int shoppingKey;

  ShoppingTile({
    this.name = "",
    this.cost = 0.0,
    required this.createdDate,
    required this.shoppingKey
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(this.name),
        subtitle: Text(this.cost.toString() + " руб."),
        leading: Text(this.createdDate.day.toString() + "." + this.createdDate.month.toString() + "." + this.createdDate.year.toString()),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShoppingPage(shoppingKey: this.shoppingKey),
          ),
        );
      },
      onLongPress: (){
        ShoppingModel? element = CRUDInterface.readElement(shoppingKey);
        log(element.toString());
        CRUDInterface.deleteElement(element!);
      },
    );
  }
}
