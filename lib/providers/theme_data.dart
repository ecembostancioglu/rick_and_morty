import 'package:flutter/material.dart';
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
  primarySwatch: Colors.blueGrey,
  cardColor: Colors.blueGrey.shade700,

);

ThemeData lightMode=ThemeData(
  primarySwatch: Colors.cyan,
  cardColor: Colors.blueGrey.shade200,
);

