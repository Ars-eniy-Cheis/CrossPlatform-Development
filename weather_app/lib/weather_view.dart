import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:translator/translator.dart';
import 'package:weather_app/weather_model.dart';
import 'package:easy_localization/easy_localization.dart';

//HTTP request:

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> with WidgetsBindingObserver {
  late var weatherDescTranslation;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state.name == "resumed"){
      log(state.toString());
      build(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("Погода"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getWeather(),
          builder: (
              BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
            if (snapshot.data != null) {
              WeatherModel? weatherModel = snapshot.data;
              var pressure = weatherModel!.main!.pressure;
              pressure = pressure! * 3 / 4;
              return Center(
                child: Column(
                  children: [
                    Text(weatherModel!.name.toString() + ", " + weatherModel.sys!.country.toString(),
                      style: TextStyle(
                          height: 3,
                          fontSize: 28,
                          fontFamily: 'Raleway',
                          color: Colors.white70,
                      ),
                    ),
                    Image(image: NetworkImage('http://openweathermap.org/img/wn/' + weatherModel.weather!.first.icon.toString() + '@4x.png')),
                    Text(weatherDescTranslation.toString(),
                      style: TextStyle(
                        height: 2,
                        fontSize: 22,
                        fontFamily: 'Raleway',
                        color: Colors.white70,
                      ),),
                    Text(weatherModel.main!.temp!.round().toString() + " °C",
                      style: TextStyle(
                        height: 2,
                        fontSize: 22,
                        fontFamily: 'Raleway',
                        color: Colors.white70,
                      ),
                    ),
                    Text(pressure.round().toString()+ " мм.рт.ст",
                      style: TextStyle(
                        height: 2,
                        fontSize: 22,
                        fontFamily: 'Raleway',
                        color: Colors.white70,
                      ),),
                  ],
                ),
              );
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<WeatherModel> getWeather() async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=55.3333&lon=86.0833&appid=bf59f6cb20b49d9248c8fabd9022a087&units=metric');
    Response response = await get(url);
    if(response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      final translator = GoogleTranslator();
      final weatherModel = WeatherModel.fromJson(data);
      weatherDescTranslation = await translator.translate(weatherModel.weather!.first.description.toString(), from: 'en', to: 'ru');
      return weatherModel;
    }
    else{
      throw Exception('Не удалось загрузить погоду');
    }
  }
}


