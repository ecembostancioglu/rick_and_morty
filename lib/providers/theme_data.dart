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
  scaffoldBackgroundColor:HexColor('#5b6266'),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: HexColor('#36A5B2')),
  primaryColor: HexColor('#263238'),
  cardTheme: CardTheme(
      color: HexColor('#37474f'),
      elevation: 4),
  appBarTheme: AppBarTheme(
    elevation: 2,
    color: HexColor('#33424a'),
),);

ThemeData lightMode=ThemeData(
  backgroundColor: HexColor('#316759'),
  scaffoldBackgroundColor:HexColor('#b0e6a3'),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: HexColor('#36A5B2')),
  primaryColor:HexColor('#316759'),
  cardTheme: CardTheme(
      color: HexColor('#daffd1'),
      elevation: 4),
  appBarTheme: AppBarTheme(
    elevation: 2,
    color: HexColor('#316759'),
  ),
);

