import 'dart:convert' show json;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CharacterNotifier with ChangeNotifier {
  List _characters;
  List get characters => _characters;
  set characters(List data) {
    _characters = data;
    notifyListeners();
  }

  Map _selectedCharacter;
  Map get selectedCharacter => _selectedCharacter;
  set selectedCharacter(Map data) {
    _selectedCharacter = data;
    notifyListeners();
  }

  void initialize() {
    Map data;
    rootBundle.loadString('assets/db.json').then((value) {
      data = json.decode(value);
      this.characters = data['characters'];
    });
  }
}
