import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/components/move_card.dart';

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
              overscroll.disallowGlow();
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
            image: new AssetImage(
                "assets/Slivers/${characterNotifier.selectedCharacter['info']['name']}_sliver_0.png"),
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
              ))),
    );
  }

  Widget bottomSection() {
    return Container(
        child: new Column(
      children: [
        neutrals(),
        aerials(),
        specials(),
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
        )));

    return new Column(children: children);
  }

  Widget aerials() {
    List<Widget> children = [];
    Map<String, dynamic> tilts = characterNotifier.selectedCharacter['aerials'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
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
        )));

    return new Column(children: children);
  }

  Widget smashes() {
    List<Widget> children = [];
    Map<String, dynamic> tilts = characterNotifier.selectedCharacter['smashes'];
    tilts.forEach((key, val) => children.add(MoveCard(
          button: key,
          move: val,
        )));

    return new Column(children: children);
  }
}
