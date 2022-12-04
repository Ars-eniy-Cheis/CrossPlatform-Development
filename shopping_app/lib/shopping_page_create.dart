import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/shopping_view.dart';

import 'crud_interface.dart';

class ShoppingPageCreate extends StatefulWidget {
  const ShoppingPageCreate({Key? key}) : super(key: key);

  @override
  State<ShoppingPageCreate> createState() => _ShoppingPageCreateState();
}

class _ShoppingPageCreateState extends State<ShoppingPageCreate> {

  late String name;
  late double cost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создание товара"),
      ),
      body:
      Center(
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                name = text;
              },
            ),
            TextField(
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
                cost = double.parse(text);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  CRUDInterface.createElement(name, cost);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShoppingView(),
                    ),
                  );
                },
                child: Text("Добавить")
            )
          ],
        ),
      ),
    );
  }
}
