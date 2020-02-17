import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/character_display.dart';

Widget characterCard(dynamic data, BuildContext context) {
  CharacterNotifier characterNotifier = Provider.of<CharacterNotifier>(context);

  return Container(
    decoration: BoxDecoration(
      color: Colors.black45,
      borderRadius: BorderRadius.circular(15),
      image: new DecorationImage(
          image: new AssetImage(
              "assets/Slivers/${data['info']['name']}_sliver_0.png"),
          fit: BoxFit.fitWidth),
    ),
    margin: EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: new Color.fromARGB(150, 0, 0, 0),
      ),
      child: FlatButton(
        onPressed: () {
          characterNotifier.selectedCharacter = data;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CharacterDisplay()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            new Center(
                child: new Image(
              image: new AssetImage("assets/Series/${data['series']}.png"),
              fit: BoxFit.contain,
              width: 60,
            )),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            data['info']['name'],
                            style: new TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Difficulty: ${data['difficulty'].toString()}",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  new Image(
                    image: new AssetImage(
                        "assets/Stock/${data['info']['name']}_stock_0.png"),
                  ),
                ])
          ],
        ),
      ),
    ),
  );
}
