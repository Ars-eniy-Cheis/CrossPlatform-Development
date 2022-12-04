import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/crud_interface.dart';
import 'package:shopping_app/shopping_model.dart';

class ShoppingPage extends StatefulWidget {
  late int shoppingKey;

  ShoppingPage({
    this.shoppingKey = 0,
  });

  @override
  State<ShoppingPage> createState() => _ShoppingPageState(this.shoppingKey);
}

class _ShoppingPageState extends State<ShoppingPage> {

  late int shoppingKey;
  late ShoppingModel shoppingModel;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCost = TextEditingController();

  _ShoppingPageState(int shoppingKey){
    this.shoppingKey = shoppingKey;
  }

  @override
  void initState() {
    super.initState();
    getProduct();
    _controllerName.text = shoppingModel.name;
    _controllerCost.text = shoppingModel.cost.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Данные о товаре"),
      ),
      body:
          Center(
            child: Column(
              children: [
                TextField(
                  controller: _controllerName,
                  onChanged: (text) {
                    CRUDInterface.updateElement(shoppingModel, text, shoppingModel.cost);
                  },
                ),
                TextField(
                  controller: _controllerCost,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                  onChanged: (text) {
                    CRUDInterface.updateElement(shoppingModel, shoppingModel.name, double.parse(text));
                  },
                )
              ],
            ),
      ),
    );
  }

  void getProduct(){
    shoppingModel = CRUDInterface.readElement(shoppingKey)!;
  }
}
