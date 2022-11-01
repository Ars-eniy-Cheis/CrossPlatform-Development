import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatefulWidget {

  const LayoutView({Key? key}) : super(key: key);

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  var showedDigit = 1;

  bool isDivisible(var number, var diviser, var equation){
    return number % diviser == equation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('LayoutView App'),),
        body: SafeArea(child:
          Column(children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(child: isDivisible(showedDigit, 3, 1)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center)),
                  Expanded(child: isDivisible(showedDigit, 3, 2)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center)),
                  Expanded(child: isDivisible(showedDigit, 3, 0)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center))])),
            SizedBox(
              height: 80,
              child: Column(children: [
                Expanded(child: isDivisible(showedDigit, 3, 1)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center)),
                Expanded(child: isDivisible(showedDigit, 3, 2)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center)),
                Expanded(child: isDivisible(showedDigit, 3, 0)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center))])),
            Expanded(child: Column(children:[
              Row(children: [
                Container(child: isDivisible(showedDigit, 3, 1)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center),),
                Container(child: isDivisible(showedDigit, 3, 2)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center),)],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
              Container(child: isDivisible(showedDigit, 3, 0)? Text(showedDigit.toString(), textAlign: TextAlign.center): Text("", textAlign: TextAlign.center),)
            ])),
            SizedBox(width: double.infinity,
              child: ElevatedButton(onPressed: () {setState(() {
                showedDigit += 1;
              });},
                child: Text("Roll"), ))

          ],))
    );
  }
}