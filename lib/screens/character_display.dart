import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:ssbu_info/notifiers/characters_notifier.dart';

class CharacterDisplay extends StatelessWidget {
  static CharacterNotifier characterNotifier;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    characterNotifier = Provider.of<CharacterNotifier>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: new ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              topBanner(context),
              bottomSection(context),
            ],
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

  Widget bottomSection(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: new Column(
          children: [
            neutrals(context),
            new Text("Hello", style: TextStyle(color: Colors.white)),
            new Text("Hello", style: TextStyle(color: Colors.white)),
            new Text("Hello", style: TextStyle(color: Colors.white)),
            new Text("Hello", style: TextStyle(color: Colors.white)),
            new Text("Hello", style: TextStyle(color: Colors.white)),
            new Text("Hello", style: TextStyle(color: Colors.white)),
          ],
        ));
  }

  /* NOTE: In the future, each item inside each attack type will be an object.
  This will be done to make each object hold a reference to the picture of the attack. **/
  Widget neutrals(BuildContext context) {
    return new Column(
      children: [
        attackCard(
            "UpTilt", characterNotifier.selectedCharacter['tilts']['uptilt']),
        attackCard("DownTilt", "Down tilt"),
        attackCard("RightTilt", "Side tilt"),
        attackCard("LeftTilt", "Neutral"),
      ],
    );
  }

  Container attackCard(String btnIcon, String text) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // This will eventually be the move's image by the way
          new Image(
            image: new AssetImage(
              "assets/Controls/" + btnIcon + ".png",
            ),
            height: 100,
            width: 100,
          ),
          // This will also eventually be some controller input images as well
          new Image(
              image: new AssetImage(
                  "assets/Stock/${characterNotifier.selectedCharacter['info']['name']}_stock_0.png")),
          new Text(text, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
