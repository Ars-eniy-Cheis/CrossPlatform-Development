import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:phone_book_app/phone_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneBookView extends StatefulWidget {
  const PhoneBookView({Key? key}) : super(key: key);

  @override
  State<PhoneBookView> createState() => _PhoneBookViewState();
}

class _PhoneBookViewState extends State<PhoneBookView> {
  late List<Contact> contacts;
  late List<Contact> filteredContacts;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Контакты'),),
      body:
      Column(
        children: [
          TextField(
              decoration: InputDecoration(
                  labelText: 'Поиск',
                  prefixIcon: Icon(IconData(0xe3c7, fontFamily: 'MaterialIcons'))
              ),

            onChanged: (String value) {
              setState(() {
                searchContact(value);
              });;
            },
          ),
          Expanded(
                  child: ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (BuildContext context, int index) {

                      Contact contact = filteredContacts[index];

                      return ContactListTile(
                        name: contact.displayName.isNotEmpty ? (contact.displayName).toString(): "",
                        phone: contact.phones.isNotEmpty ? (contact.phones[0]).toString(): "",
                        email: contact.emails.isEmpty ? "": (contact.emails[0]).toString(),
                      );
                    },
                  )
          ),
        ],
      )
    );
  }

  Future<List<Contact>> getContacts() async {
    contacts = await FastContacts.allContacts;
    filteredContacts = contacts;
    return contacts;
  }

  void searchContact(String query){
    if(query.isEmpty){
      filteredContacts = contacts;
    }
    else{
      var suggestions = filteredContacts.where((element) => element.displayName.toLowerCase().contains(query.toLowerCase()));
      filteredContacts = suggestions.toList();
    }
  }
}

class ContactListTile extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? email;

  const ContactListTile({
    this.name = "",
    this.phone = "",
    this.email = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: this.name != null ? Text(this.name.toString()) : Text(""),
        subtitle: Column(
          children: [
            Text(this.phone != null ? this.phone.toString() : ""),
            Text(this.email != null ? this.email.toString() : "")
          ],
        ),
      ),
      onTap: () => _dialogBuilder(context, this.phone.toString())
    );

  }
}

Future<void> _dialogBuilder(BuildContext context, String telephone) {
  return
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return PhoneAlert(
          phoneNumber: telephone,
        );
      },

    );
}

