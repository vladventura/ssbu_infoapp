import 'package:flutter/material.dart';

class MoveCard extends StatefulWidget {
  MoveCard({this.button, this.text, this.description = "Move Description."});
  final String button;
  final String text;
  final String description;
  @override
  _MoveCardState createState() => _MoveCardState();
}

class _MoveCardState extends State<MoveCard> {
  bool _visibility = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _visibility = !_visibility;
          });
        },
        child: new Stack(
          children: [
            new Container(
                child: new Image(
                    image: new AssetImage("assets/General/nonet.jpg"))),
            new Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.98,
              child: Container(
                decoration: new BoxDecoration(color: Colors.black87),
                height: MediaQuery.of(context).size.height * 0.07,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Image(
                      image: new AssetImage(
                        "assets/Controls/" + widget.button + ".png",
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    new Text(widget.text, style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
            new Positioned(
                height: MediaQuery.of(context).size.height * 0.269,
                width: MediaQuery.of(context).size.width,
                child: new AnimatedOpacity(
                  opacity: _visibility ? 1.0 : 0.0,
                  duration: new Duration(milliseconds: 100),
                  child: new Container(
                    child: Center(
                      child: new Text(
                        widget.description,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.black87),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
