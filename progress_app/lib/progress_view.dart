import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  const ProgressView({Key? key}) : super(key: key);

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final TextEditingController _controller = TextEditingController();
  double progress = 0.0;
  String text = "";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress View App'),),
      body: SafeArea(child:
        Column(children: [
          TextField(controller: _controller,),
          LinearProgressIndicator(value: progress,),
          Container(child: text == ""? Text("Здесь будет отображен текст, который вы ввели"): Text(text),),
          CheckboxListTile(
            value: isChecked,
            onChanged: (bool? value) { setState(() {
              changeToggleValue();
            });; },
              title: Text("Вы уверены?")),
          ElevatedButton(onPressed: () { setState(() {
            setProgress();
          }); }, child: Text("Progress"),) ],),),
    );
  }

  void changeToggleValue(){
    isChecked = !isChecked;
  }

  void setProgress(){
    if(_controller.text != "" && isChecked == true && progress < 1){
      progress += 0.1;
      text = _controller.text;
    }
    else if(isChecked == true){
      progress = 0;
    }

  }
}
