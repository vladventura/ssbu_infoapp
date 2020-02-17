import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';

class CharacterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[topSection(context)],
      ),
    );
  }
}

Widget topSection(BuildContext context) {
  CharacterNotifier characterNotifier = Provider.of<CharacterNotifier>(context);
  return Container(
      child: Column(children: <Widget>[
    new Text(characterNotifier.selectedCharacter['info']['name']),
    new Stack(
      children: <Widget>[
        new Image(
            image: new AssetImage(
                "assets/Slivers/${characterNotifier.selectedCharacter['info']['name']}_sliver_0.png")),
      ],
    )
  ]));
}
