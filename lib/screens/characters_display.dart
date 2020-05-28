import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ssbu_info/notifiers/characters_notifier.dart';
import 'package:ssbu_info/enhancers/dynamicscrollbackground.dart';
import 'package:ssbu_info/components/character_card.dart';

class CharactersDisplay extends StatefulWidget {
  @override
  _CharactersDisplayState createState() => _CharactersDisplayState();
}

class _CharactersDisplayState extends State<CharactersDisplay> {
  Widget build(BuildContext context) {
    CharacterNotifier characterNotifier =
        Provider.of<CharacterNotifier>(context);
    ScrollController _scrollController = new ScrollController();

    return (characterNotifier.characters == null
        ? new Container()
        : DynamicScrollBackground(
            firstHue: 170,
            secondHue: 200,
            childScrollController: _scrollController,
            child: new ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return CharacterCard(index: index);
              },
              itemCount: characterNotifier.characters.length,
            ),
          ));
  }
}
