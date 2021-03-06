import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/characters_display.dart';
import 'package:ssbu_info/styles/textstyles.dart';

void main() {
  // Over here we would wrap the Application with the
  // ChangeNotifierProvider widget, or a MultiProvider widget
  runApp(ChangeNotifierProvider(
    create: (context) => CharacterNotifier(),
    child: App(),
  ));
}

class App extends StatefulWidget {
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  int bottomNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<CharacterNotifier>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          // #23D6F4
          // #21C4E0
          // #11A3BC
            backgroundColor: Color(0xFF11A3BC),
            appBar: new AppBar(
              title: Center(child: new Text("SSBU Characters")),
            ),
            body: CharactersDisplay()),
        theme: new ThemeData(
            accentColor: Colors.amber,
            backgroundColor: Colors.black,
            appBarTheme: new AppBarTheme(
                // #F7D710
                // #EBCC0F
                // #DDC00F
                color: Color(0xFFDDC00F),
                textTheme: new TextTheme(
                  headline6: headline6,
                ))));
  }
}
