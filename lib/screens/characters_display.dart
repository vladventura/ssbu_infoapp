import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ssbu_info/notifiers/characters_notifier.dart';

import 'package:ssbu_info/components/character_card.dart';

class CharactersDisplay extends StatelessWidget {
  Widget build(BuildContext context) {
    CharacterNotifier characterNotifier =
        Provider.of<CharacterNotifier>(context);

    return characterNotifier.characters == null
        ? new Container()
        : new ListView.builder(
            itemBuilder: (context, index) {
              return characterCard(
                  characterNotifier.characters[index], context);
            },
            itemCount: characterNotifier.characters.length,
          );
  }
}
