import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class _SnackbarView extends State<SnackbarView> {

  var logger = Logger();
  final myController = TextEditingController();
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {showSnackbar(context);},
                child: const Text('OK'),
                  )),
                  TextField(
                      controller: myController
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {printDefaultLog();},
                    child: const Text('Обычное логирование'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {printLoggerLog();},
                    child: const Text('Логирование Logger'),
                  ),
                  Text('Калинько Арсений Евгеньевич', style: !isExpanded ? TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.red) :
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.green)),
                  ElevatedButton(
                  style:  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {setState(changeExpandedState);},
                  child: !isExpanded ? const Text('Увеличть'): const Text('Уменьшить'),
                  ),
                ]);
  }

  void showSnackbar(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Кнопка ОК нажата'),
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  void printDefaultLog(){
    debugPrint(myController.text);
  }

  void printLoggerLog(){
    logger.v(myController.text);
  }

  void changeExpandedState(){
    isExpanded = !isExpanded;
    logger.v(isExpanded);
  }

}

class SnackbarView extends StatefulWidget {
  @override
  _SnackbarView createState() => _SnackbarView();

}