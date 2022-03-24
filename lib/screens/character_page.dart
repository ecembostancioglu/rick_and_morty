import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rick_and_morty/models/page_status.dart';
import 'package:rick_and_morty/screens/character_details.dart';
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



 setState(() {
   for(var i=0;i<data.length;i++){
     Character char=Character();
     char.id=data[i]['id'];
     char.name=data[i]['name'];
     char.img=data[i]['image'];
     char.status=data[i]['status'];
     char.gender=data[i]['gender'];
     char.species=data[i]['species'];

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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>
                        CharacterDetails(
                          id: characterList[index].id!,
                          img: characterList[index].img!,)));
                  },
                  child: Card(
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
                            color: HexColor('#3bd1c0'),
                            borderRadius: BorderRadius.vertical(
                                bottom:Radius.circular(20),
                                top:Radius.circular(20) )),
                            height: MediaQuery.of(context).size.height*0.08,
                            width:MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  (characterList[index].name.toString()),maxLines: 1,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.shadowsIntoLight(fontSize: 22,
                                fontWeight: FontWeight.w500,

                                shadows: [
                                  Shadow(
                                    blurRadius:3,
                                  )]),
                              ),
                            ),),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                         radius: 70,
                        backgroundImage:
                        NetworkImage(characterList[index].img.toString())),
                          ),
                    ]),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
