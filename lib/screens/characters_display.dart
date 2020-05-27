import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:ssbu_info/notifiers/characters_notifier.dart';

import 'package:ssbu_info/components/character_card.dart';

double _firstHue = 150;
double _secondHue = 190;
double _topStop = 0.4;
double _bottomStop = 1.5;
Color _topColor = HSVColor.fromAHSV(1, _firstHue, 1, 1).toColor();
Color _bottomColor = HSVColor.fromAHSV(1, _secondHue, 1, 1).toColor();
List<Color> _colors = [_topColor, _bottomColor];
List<double> _stops = [_topStop, _bottomStop];

class CharactersDisplay extends StatefulWidget {
  @override
  _CharactersDisplayState createState() => _CharactersDisplayState();
}

class _CharactersDisplayState extends State<CharactersDisplay> {
  Widget build(BuildContext context) {
    CharacterNotifier characterNotifier =
        Provider.of<CharacterNotifier>(context);
    ScrollController _scrollController = new ScrollController();

    return characterNotifier.characters == null
        ? new Container()
        : NotificationListener<ScrollNotification>(
            onNotification: (notif) {
              ScrollDirection direction =
                  _scrollController.position.userScrollDirection;
              print(_scrollController.position.userScrollDirection);
              print(_scrollController.position.velocity);

              double velocity =
                  _scrollController.position.velocity.abs();

              if (velocity > 1000) velocity /= 1000;
              if (velocity > 100) velocity /= 100;
              if (velocity > 10) velocity /= 10;

              double convertedVelocity = (1 * velocity);

              if (direction == ScrollDirection.forward) {
                double firstHue = _firstHue - convertedVelocity;
                double secondHue = _secondHue - convertedVelocity;

                if (firstHue < 0) {
                  firstHue = 150;
                  secondHue = 190;
                }
                setState(() {
                  print(_firstHue);
                  _firstHue = firstHue;
                  print(firstHue);
                  _secondHue = secondHue;
                  _topStop -= 0.01;
                  _bottomStop -= 0.01;
                  _topColor =
                      new HSVColor.fromAHSV(1, _firstHue, 1, 1).toColor();
                  _bottomColor =
                      HSVColor.fromAHSV(1, _secondHue, 1, 1).toColor();
                  _colors = [_topColor, _bottomColor];
                  _stops = [_topStop, _bottomStop];
                });
              }
              if (direction == ScrollDirection.reverse) {
                print(_secondHue);
                Future.delayed(Duration(milliseconds: 100), () {
                  setState(() {
                    _firstHue++;
                    _secondHue++;
                    _topStop += 0.01;
                    _bottomStop += 0.01;
                    _topColor = HSVColor.fromAHSV(1, _firstHue, 1, 1).toColor();
                    _bottomColor =
                        HSVColor.fromAHSV(1, _secondHue, 1, 1).toColor();
                    _colors = [_topColor, _bottomColor];
                    _stops = [_topStop, _bottomStop];
                  });
                });
              }
              return true;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  // #1CA0F2 (203)
                  // #561CF2 (256)
                  gradient: LinearGradient(
                      colors: _colors,
                      stops: _stops,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: new ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return characterCard(characterNotifier.characters[index],
                      context, (index + 0.0));
                },
                itemCount: characterNotifier.characters.length,
              ),
            ));
  }
}
