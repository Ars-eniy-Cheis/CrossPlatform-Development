import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_app/shopping_model.dart';
import 'package:shopping_app/shopping_view.dart';

late var shopping;

Future<void> main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(ShoppingModelAdapter());
  shopping = await Hive.openBox<ShoppingModel>('shopping_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShoppingView(),
    );
  }
}
