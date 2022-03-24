import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/character.dart';


class CharacterDetails extends StatefulWidget {
   final int id;
   final String img;
    CharacterDetails({required this.id,required this.img});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {


  Character c= Character();
  bool loading=false;


  void getChar() async{
    Response res=await http.get(Uri.parse('https://rickandmortyapi.com/api/character/${widget.id}'));
    var data=await jsonDecode(res.body);

    setState(() {
      c.name=data[0]['name'];
      c.img=data[0]['img'];
      loading=true;
    });
  }

@override
  void initState() {
    super.initState();
    getChar();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Center(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('${widget.id}',style: TextStyle(fontSize: 30)),
              Image.network('${widget.img}'),
          ],
        ),
           ),
    );

  }
}

