import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/models/character.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CharacterDetails extends StatefulWidget {


   final int id=4;
 //  CharacterDetails({required this.id});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {

  Character c= Character();
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading==false
        ? Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.red,
          size: 200,
        ),
      ),
    )
        : Scaffold();
  }
}
