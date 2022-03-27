import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeColorData with ChangeNotifier{
  static SharedPreferences? _sharedPrefObject;
  bool _isLightMode=true;

  bool get isLightMode=>_isLightMode;

  ThemeData get themeColor{
    return _isLightMode ? lightMode : darkMode;
  }

  void setLightMode(){
    _isLightMode=!_isLightMode;
    saveThemeToSharedPref(_isLightMode);
    notifyListeners();
  }

  Future <void> createSharedPrefObject() async {
    _sharedPrefObject=await SharedPreferences.getInstance();
  }

 void saveThemeToSharedPref(bool value){
    _sharedPrefObject!.setBool('themeData', value);
 }

  void loadThemeToSharedPref(){
    //await createSharedPrefObject();
    _isLightMode=_sharedPrefObject!.getBool('themeData') ?? true;
  }

}
ThemeData darkMode=ThemeData(
  backgroundColor: HexColor('#405059'),
  scaffoldBackgroundColor:HexColor('#6e767a'),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: HexColor('#36A5B2')),
  primaryColor: HexColor('#263238'),
  cardTheme: CardTheme(
      color:Colors.transparent ,
   elevation: 0),
  appBarTheme: AppBarTheme(
    elevation: 2,
    color: HexColor('#33424a'),
),);

ThemeData lightMode=ThemeData(
  backgroundColor: HexColor('#316759'),
  scaffoldBackgroundColor:HexColor('#a6d99a'),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: HexColor('#36A5B2')),
  primaryColor:HexColor('#316759'),
  cardTheme: CardTheme(
      color:Colors.transparent ,
      elevation: 0),
  appBarTheme: AppBarTheme(
    elevation: 2,
    color: HexColor('#316759'),
  ),
);

