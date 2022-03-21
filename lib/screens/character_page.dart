import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/character.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {

  List<Character> characterList=<Character>[];
  void getCharacters() async {
  Response response= await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
  //print(response.body);

    Map<String,dynamic> map=await jsonDecode(response.body);
    List<dynamic> data=map['results'];
   // print(data['results'][0]['name']);
    print(data[0]['name']);

 setState(() {
   for(var i=0;i<data.length;i++){
     Character char=Character();
     char.id=data[i]['id'];
     char.name=data[i]['name'];
     char.img=data[i]['image'];

     characterList.add(char);
   }
 });
  }
  @override
  void initState() {
    getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).backgroundColor,
              Theme.of(context).scaffoldBackgroundColor],
            tileMode: TileMode.mirror,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                childAspectRatio: 1.8/2,
                mainAxisSpacing: 40,
              ) ,
              itemCount: characterList.length,
              itemBuilder: (context,index){
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20)
                    )
                  ),
                  child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade500,
                          borderRadius: BorderRadius.vertical(
                              bottom:Radius.circular(20),
                              top:Radius.circular(20) )),
                          height: MediaQuery.of(context).size.height*0.08,
                          width:MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                (characterList[index].name.toString()),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.shadowsIntoLight(fontSize: 20,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.red,
                                  blurRadius:5,
                                )]),
                            ),
                          ),),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                       radius: 72,
                      backgroundImage:
                      NetworkImage(characterList[index].img.toString())),
                        ),
                  ]),
                );
              }),
        ),
      ),
    );
  }
}
