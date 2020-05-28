import 'package:flutter/material.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/screens/character_display.dart';

import 'package:ssbu_info/styles/textstyles.dart';

class CharacterCard extends StatelessWidget {
  final int index;
  final CharacterNotifier characterNotifier;
  CharacterCard({@required this.index, @required this.characterNotifier});

  Column infoOverlayNameDifficulty() {
    return Column(
      children: <Widget>[
        Text(
          characterNotifier.characters[index]['info']['name'],
          style: bodyText1,
        ),
        Text(
          "Difficulty: ${characterNotifier.characters[index]['difficulty'].toString()}",
          style: bodyText2,
        ),
      ],
    );
  }

  Image infoOverlayIcon() {
    return new Image(
      image: new AssetImage(
          "assets/Stock/${characterNotifier.characters[index]['info']['name']}_stock_0.png"),
    );
  }

  Center infoOverlaySeries() {
    return new Center(
        child: new Image(
      image: new AssetImage(
          "assets/Series/${characterNotifier.characters[index]['series']}.png"),
      fit: BoxFit.contain,
      width: 60,
    ));
  }

  Row infoOverlay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        infoOverlayNameDifficulty(),
        infoOverlaySeries(),
        infoOverlayIcon(),
      ],
    );
  }

  FlatButton characterTappable(BuildContext context) {
    return FlatButton(
        onPressed: () {
          characterNotifier.selectedCharacter =
              characterNotifier.characters[index];
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CharacterDisplay()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(20),
        child: infoOverlay());
  }

  BoxDecoration characterSliverBackground() {
    double hue = 45.0 + index;
    if (hue > 66 && hue < 166) hue += 100;
    return BoxDecoration(
      color: HSVColor.fromAHSV(0.9, hue, 1, 0.8).toColor(),
      borderRadius: BorderRadius.circular(15),
      image: new DecorationImage(
          image: new AssetImage(
              "assets/Slivers/${characterNotifier.characters[index]['info']['name']}_sliver_0.png"),
          fit: BoxFit.fitWidth),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: characterSliverBackground(),
      margin: EdgeInsets.all(10),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: new Color.fromARGB(80, 0, 0, 0),
          ),
          child: characterTappable(context)),
    );
  }
}
