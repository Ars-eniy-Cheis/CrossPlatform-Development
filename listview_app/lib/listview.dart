import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElementsListView extends StatelessWidget {
  const ElementsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Element(text: "Бауэр Р.Е.", boxColor: Colors.blue),
            Element(text: "Шванев А.А.", boxColor: Colors.red),
            Element(text: "Калинько А.Е.", boxColor: Colors.orange),
          ],
          
        ),
      ),
    );
  }
}

class Element extends StatelessWidget {
  const Element({
    this.text = "",
    this.boxColor = Colors.black
  });

  final String text;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8.0),
    child: InkWell(
      child: Row(
        children: [
          Container(color: this.boxColor, width: 50, height: 50,),
          SizedBox(width: 20,),
          Text(this.text)
        ],

      ),
      onTap: () {onTapElement(this.text, context);},
    ),
    );
  }
  void onTapElement(String text, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("It's $text"),
        ),
    );
  }
}
