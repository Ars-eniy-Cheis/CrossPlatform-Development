import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class WebView extends StatelessWidget {

  var logger = Logger();
  //var http = Uri.http(authority)

  WebView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    getViaHttp();
                  },
                  child: Text("Network get via http")
              ),
              ElevatedButton(
                  onPressed: () {
                    getViaDio();
                  },
                  child: Text("Network get via dio")
              )
            ],
          ),
      ),
    );
  }

  void getViaHttp() {
    var response = http.get(Uri.parse("http://jsonplaceholder.typicode.com/posts"));
    response.then((message){
      if(message.statusCode == 200){
        logger.i(message.body);
      }
      else{
        throw Exception("Невозможно получить посты");
      }
    });
  }

  void getViaDio(){
    Dio dio = Dio();
    var response = dio.get("http://jsonplaceholder.typicode.com/posts");
    response.then((message){
      if(message.statusCode == 200){
        logger.i(message.data);
      }
      else{
        throw Exception("Невозможно получить посты");
      }
    });
  }
}

