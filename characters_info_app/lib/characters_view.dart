import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'character_model.dart';
import 'character_page.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:Text("Персонажи")),
      body: FutureBuilder<List<CharacterModel>>(
        future: getCharacters(),
        builder: (
            BuildContext context, AsyncSnapshot<List<CharacterModel>> snapshot) {
            if(snapshot.data != null){

              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){
                  CharacterModel? character = snapshot.data?[index];
                  return CharacterTile(
                    characterId: character?.charId,
                    nickName: character?.nickname,
                    imageUrl: character?.img,
                  );
                },
              );
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },),
    );
  }

  Future<List<CharacterModel>> getCharacters() async {
    List<CharacterModel> CharList =<CharacterModel>[];

    final url = Uri.parse('https://www.breakingbadapi.com/api/characters/');
    Response response = await get(url);

    if(response.statusCode == 200){
      List<dynamic> values=<dynamic>[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            CharList.add(CharacterModel.fromJson(map));
            debugPrint('Id-------${map['id']}');
          }
        }
      }
      return CharList;
    }
    else{
      throw Exception('Не удалось загрузить персонажей');
    }
  }
}

class CharacterTile extends StatelessWidget {

  final int? characterId;
  final String? imageUrl;
  final String? nickName;

  const CharacterTile({
    this.characterId = 0,
    this.imageUrl = "",
    this.nickName = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(nickName!),
        leading: Image(
          fit: BoxFit.fill,
          height: 50,
          width: 50,
          image: NetworkImage(imageUrl!),),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CharacterPage(characterId: this.characterId!.toInt()),
          ),
        );
      },
    );

  }

}
