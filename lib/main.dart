import 'package:flutter/material.dart';

void main() {
  // Over here we would wrap the Application with the
  // ChangeNotifierProvider widget, or a MultiProvider widget
  runApp(App());
}

class App extends StatefulWidget {
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  int bottomNavBarIndex = 0;
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
      return charactersDisplay();
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

ListView charactersDisplay() {
  return ListView.builder(
    itemBuilder: (context, index) {
      return characterCard();
    },
    itemCount: 100,
  );
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

Widget characterCard() {
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
            "Series here",
            style: TextStyle(
              color: Colors.red,
            ),
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Name here'),
                    Text('Difficulty here'),
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
