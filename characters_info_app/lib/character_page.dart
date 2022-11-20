import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'character_model.dart';

class CharacterPage extends StatefulWidget {

  late int characterId;

  CharacterPage({
    this.characterId = 0,
  });

  @override
  State<CharacterPage> createState() => _CharacterPageState(this.characterId);
}

class _CharacterPageState extends State<CharacterPage> {

  late int characterId;

  _CharacterPageState(int characterId){
    this.characterId = characterId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Данные персонажа"),
      ),
      body: FutureBuilder<CharacterModel>(
          future: getCharacterData(this.characterId),
          builder: (
          BuildContext context, AsyncSnapshot<CharacterModel> snapshot) {
            if (snapshot.data != null) {
              CharacterModel? characterModel = snapshot.data;
              return Column(
                children: [
                  Image(image: NetworkImage(characterModel!.img.toString())),
                  Text(characterModel.name.toString())
                ],
              );
            }
            else{
              return Container();
            }
          }
      ),
    );
  }
}

Future<CharacterModel> getCharacterData(int characterId) async{

  final url = Uri.parse('https://www.breakingbadapi.com/api/characters/'+characterId.toString());
  Response response = await get(url);

  if(response.statusCode == 200){
    CharacterModel Character = CharacterModel.fromJson(json.decode(response.body));
    return Character;
  }
  else{
    throw Exception('Не удалось загрузить персонажей');
  }
}