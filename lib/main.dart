import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';

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

class CharactersDisplay extends StatelessWidget {
  Widget build(BuildContext context) {
    CharacterNotifier characterNotifier =
        Provider.of<CharacterNotifier>(context);

    return characterNotifier.characters == null
        ? new Container()
        : new ListView.builder(
            itemBuilder: (context, index) {
              return characterCard(characterNotifier.characters[index]);
            },
            itemCount: characterNotifier.characters.length,
          );
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

Widget characterCard(dynamic data) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.amber,
        boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 10,
              offset: Offset.zero,
              color: Colors.grey.withOpacity(0.5))
        ],
        borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.all(10),
    child: FlatButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          new Center(
              child: new Text(
            data['series'],
            style: TextStyle(
              color: Colors.red,
            ),
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(data['info']['name']),
                    Text(data['difficulty'].toString()),
                  ],
                ),
                Text("Stock Icon here"),
                Text("Custom color"),
              ])
        ],
      ),
    ),
  );
}
