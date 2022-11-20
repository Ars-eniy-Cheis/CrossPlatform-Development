import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneAlert extends StatelessWidget {
  final String? phoneNumber;

  const PhoneAlert({
    this.phoneNumber = ""
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Выберите действие'),
      content: Row(
        children: [
          ElevatedButton(onPressed: ()  async{
            String telephoneUrl = "tel:" + this.phoneNumber.toString();
            if (await canLaunchUrl(Uri.parse(telephoneUrl))) {
              await launchUrl(Uri.parse(telephoneUrl));
            } else {
              throw "Error occured trying to call that number.";
            }
          }, child: Text("Позвонить")),
          ElevatedButton(onPressed: ()  async{
            String InternetUrl = "https://yandex.ru/search/?text="+this.phoneNumber.toString();
            await launchUrl(Uri.parse(InternetUrl));
          }, child: Text("Кто это?"))
        ],
      ),
    );
  }

}
