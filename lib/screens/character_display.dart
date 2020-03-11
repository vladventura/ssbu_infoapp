import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';

class CharacterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: new ListView(
          children: <Widget>[topSection(context)],
        ),
      ),
    );
  }

  Widget topSection(BuildContext context) {
    CharacterNotifier characterNotifier =
        Provider.of<CharacterNotifier>(context);
    return Container(
        child: Column(children: <Widget>[
      topBanner(characterNotifier.selectedCharacter, context)
    ]));
  }

  Container topBanner(Map data, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        image: new DecorationImage(
            image: new AssetImage(
                "assets/Slivers/${data['info']['name']}_sliver_0.png"),
            fit: BoxFit.fill,
            repeat: ImageRepeat.noRepeat),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(150, 0, 0, 0),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        child: new Row(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Text(
                  "Stock Icons Here",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                new Text(
                  "Stock Icons Here",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
                new Text(
                  "Columns of Four Icons",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
