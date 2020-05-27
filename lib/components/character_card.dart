import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/character_display.dart';

import 'package:ssbu_info/styles/textstyles.dart';

Widget characterCard(dynamic data, BuildContext context, double index) {
  CharacterNotifier characterNotifier = Provider.of<CharacterNotifier>(context);
  // Orange starts at 45, ends at 65, blue starts at 165
  double hue = 45 + index;
  if (hue > 66 && hue < 166) hue += 100; 
  return Container(
    decoration: BoxDecoration(
      color: HSVColor.fromAHSV(0.9, hue, 1, 0.8).toColor(),
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
        color: new Color.fromARGB(80, 0, 0, 0),
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
                            style: bodyText1,
                          ),
                          Text(
                            "Difficulty: ${data['difficulty'].toString()}",
                            style: bodyText2,
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
