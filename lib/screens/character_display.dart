import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/components/move_card.dart';
import 'package:ssbu_info/constants.dart';

class CharacterDisplay extends StatelessWidget {
  static CharacterNotifier characterNotifier;

  @override
  Widget build(BuildContext context) {
    characterNotifier = Provider.of<CharacterNotifier>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.black38),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: new ListView(
              children: <Widget>[
                topBanner(context),
                bottomSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container topBanner(BuildContext context) {
    String characterName = characterNotifier.selectedCharacter['info']['name'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
            image: new AssetImage(sliverPath(character: characterName)),
            fit: BoxFit.fill,
            repeat: ImageRepeat.noRepeat),
      ),
      child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(150, 0, 0, 0),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.30,
          child: Container(
              alignment: Alignment.topCenter,
              child: new Text(
                characterNotifier.selectedCharacter["info"]["name"],
                style: TextStyle(color: Colors.white),
                textScaleFactor: 3,
              ))),
    );
  }

  Widget bottomSection() {
    return Container(
        child: new Column(
      children: [
        new Text(
          "Neutrals",
          style: TextStyle(color: Colors.white),
          textScaleFactor: 2.5,
        ),
        neutrals(),
        new Text(
          "Aerials",
          style: TextStyle(color: Colors.white),
          textScaleFactor: 2.5,
        ),
        aerials(),
        new Text(
          "Specials",
          style: TextStyle(color: Colors.white),
          textScaleFactor: 2.5,
        ),
        specials(),
        new Text(
          "Smashes",
          style: TextStyle(color: Colors.white),
          textScaleFactor: 2.5,
        ),
        smashes(),
      ],
    ));
  }

  Widget neutrals() {
    List<Widget> children = [];
    Map<String, dynamic> tilts = characterNotifier.selectedCharacter['tilts'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
          characterName: characterNotifier.selectedCharacter['info']['name'],
          moveType: "Tilts",
        )));

    return new Column(children: children);
  }

  Widget aerials() {
    List<Widget> children = [];
    Map<String, dynamic> tilts = characterNotifier.selectedCharacter['aerials'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
          characterName: characterNotifier.selectedCharacter['info']['name'],
          moveType: "Airs",
        )));

    return new Column(children: children);
  }

  Widget specials() {
    List<Widget> children = [];
    Map<String, dynamic> tilts =
        characterNotifier.selectedCharacter['specials'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
          characterName: characterNotifier.selectedCharacter['info']['name'],
          moveType: "Bs",
        )));

    return new Column(children: children);
  }

  Widget smashes() {
    List<Widget> children = [];
    Map<String, dynamic> tilts = characterNotifier.selectedCharacter['smashes'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
          characterName: characterNotifier.selectedCharacter['info']['name'],
          moveType: "Smashes",
        )));

    return new Column(children: children);
  }
}
