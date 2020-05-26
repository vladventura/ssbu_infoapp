import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/characters_display.dart';

import 'package:google_fonts/google_fonts.dart';

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
            backgroundColor: Colors.black,
            appBar: new AppBar(
              title: new Text("SSBU Info App"),
            ),
            body: CharactersDisplay()),
        theme: new ThemeData(
            accentColor: Colors.black,
            backgroundColor: Colors.black,
            appBarTheme: new AppBarTheme(
                color: Colors.black,
                textTheme: new TextTheme(
                    headline6: GoogleFonts.lato(
                  color: Colors.red,
                  fontSize: 20,
                )))));
  }
}
