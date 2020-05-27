import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:ssbu_info/notifiers/characters_notifier.dart';

import 'package:ssbu_info/components/character_card.dart';

double _firstHue = 170;
double _secondHue = 200;
double _topStop = 0.5;
double _bottomStop = 1.5;
Color _topColor = HSVColor.fromAHSV(1, _firstHue, 1, 1).toColor();
Color _bottomColor = HSVColor.fromAHSV(1, _secondHue, 1, 1).toColor();
List<Color> _colors = [_topColor, _bottomColor];
List<double> _stops = [_topStop, _bottomStop];
int _index = 0;

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
              print("Pixels: " + notif.metrics.pixels.toString());
              print(_scrollController.position.velocity);
              print(_index);

              double velocity = _scrollController.position.velocity.abs();
              double convertedVelocity = 0.01;
              if (velocity > 1000) {
                velocity /= 1000;
                convertedVelocity = (0.8 * velocity);
              }
              if (velocity > 100) {
                velocity /= 100;
                convertedVelocity = (0.8 * velocity);
              }
              if (velocity > 10) {
                velocity /= 10;
                convertedVelocity = (0.8 * velocity);
              }

              if (direction == ScrollDirection.forward) {
                double firstHue = _firstHue - convertedVelocity;
                double secondHue = _secondHue - convertedVelocity;

                if (firstHue < 0) {
                  firstHue = 170;
                  secondHue = 200;
                }
                Future.delayed(Duration(milliseconds: 100), () {
                  setState(() {
                    _firstHue = firstHue;
                    _secondHue = secondHue;
                    _topColor =
                        new HSVColor.fromAHSV(1, _firstHue, 1, 1).toColor();
                    _bottomColor =
                        HSVColor.fromAHSV(1, _secondHue, 1, 1).toColor();
                    _colors = [_topColor, _bottomColor];
                    _stops = [_topStop, _bottomStop];
                  });
                });
              }
              if (direction == ScrollDirection.reverse) {
                double firstHue = _firstHue + convertedVelocity;
                double secondHue = _secondHue + convertedVelocity;

                if (secondHue > 360) {
                  firstHue = 319;
                  secondHue = 359;
                }
                Future.delayed(Duration(milliseconds: 100), () {
                  setState(() {
                    _firstHue = firstHue;
                    _secondHue = secondHue;
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
