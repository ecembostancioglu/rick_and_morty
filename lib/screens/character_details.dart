import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/character.dart';


class CharacterDetails extends StatefulWidget {
   final int id;
   final String img;
   final String name;
   final String status;
   final String species;
   final String gender;
    CharacterDetails({required this.id,
      required this.img,
      required this.status,
      required this.name,
      required this.species,
      required this.gender});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {


  Character c= Character(status:'', id:1 ,species: '', img: '', gender: '', name: '');
  bool loading=false;


  void getChar() async{
    Response res=await http.get(Uri.parse('https://rickandmortyapi.com/api/character/${widget.id}'));
    var data=await jsonDecode(res.body);

    setState(() {
      c.name=data[0]['name'];
      c.img=data[0]['img'];
      c.status=data[0]['status'];
      c.gender=data[0]['gender'];
      c.species=data[0]['species'];
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
           body: SafeArea(
             child: Center(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                      child: Column(
                      children: [
                       Container(
                           child: Image.network('${widget.img}')),
                    ],
                  )),
                  Expanded(flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text('Name: ${widget.name}',
                                style: TextStyle(fontSize: 30)),
                            Divider(height: 12),
                            Text('Gender: ${widget.gender}',
                                style: TextStyle(fontSize: 30)),
                            Divider(height: 12),
                            Text('Species: ${widget.species}',
                                style: TextStyle(fontSize: 30)),
                            Divider(height: 12),
                            Text('Status: ${widget.status}',
                                style: TextStyle(fontSize: 30)),
                          ],
                        ),


                      ],
                    ), ),


          ],
        ),
             ),
           ),
    );

  }
}

