import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/characters_display.dart';

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
        appBar: new AppBar(
          title: new Text("SSBU Info App Main Screen Template"),
        ),
        body: chooseDisplay(bottomNavBarIndex),
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit), title: new Text("Characters")),
            new BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit), title: new Text("Stages")),
            new BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit), title: new Text("Music")),
          ],
          currentIndex: bottomNavBarIndex,
          onTap: (int tappedIndex) {
            setState(() {
              bottomNavBarIndex = tappedIndex;
            });
          },
        ),
      ),
    );
  }
}

Widget chooseDisplay(int index) {
  switch (index) {
    case 0:
      return CharactersDisplay();
      break;
    case 1:
      return musicDisplay();
      break;
    case 2:
      return stagesDisplay();
      break;
    default:
      break;
  }
}

ListView musicDisplay() {
  return ListView(
    children: <Widget>[
      new Text("Music 1"),
      new Text("Music 2"),
      new Text("Music 3"),
      new Text("Music 4"),
      new Text("Music 5"),
      new Text("Music 6"),
      new Text("Music 7"),
      new Text("Music 8"),
      new Text("Music 9"),
      new Text("Music 10"),
    ],
  );
}

ListView stagesDisplay() {
  return ListView(
    children: <Widget>[
      new Text("Stage 1"),
      new Text("Stage 2"),
      new Text("Stage 3"),
      new Text("Stage 4"),
      new Text("Stage 5"),
      new Text("Stage 6"),
      new Text("Stage 7"),
      new Text("Stage 8"),
      new Text("Stage 9"),
      new Text("Stage 10"),
    ],
  );
}
