import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/providers/theme_data.dart';
import 'screens/home_page.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeColorData().createSharedPrefObject();
  runApp(ChangeNotifierProvider<ThemeColorData>(create: (BuildContext context)=>ThemeColorData(),
         child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeColorData>(context,listen: false).loadThemeToSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeColorData>(context).themeColor,
      home:  HomePage(),
    );
  }
}

