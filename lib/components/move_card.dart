import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ssbu_info/cdn.dart';

class MoveCard extends StatefulWidget {
  MoveCard(
      {this.button = "",
      this.move = const [],
      this.characterName,
      this.moveType});
  final String button;
  final List<dynamic> move;
  final String characterName;
  final String moveType;
  @override
  _MoveCardState createState() => _MoveCardState();
}

class _MoveCardState extends State<MoveCard> {
  bool _visibility = false;
  List<Widget> _images = new List<Widget>();
  int _imageIndex = 0;
  String _currentMove = "";
  String _currentName = "";
  CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _currentName = widget.move[0]['name'];
    _currentMove = widget.move[0]['description'];
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.move.forEach((element) {
      String url =
          "https://$id.$domain/${widget.characterName}/${widget.moveType}/${element['name']}.jpg";
      CachedNetworkImage img = new CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.width * 0.08,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorWidget: (context, url, error) => Image(
          image: new AssetImage("assets/General/nonet.jpg"),
        ),
        height: 720,
        width: 1280,
      );
      _images.add(img);
    });
  }

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
              child: new CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: (page, c) {
                      this.setState(() {
                        _imageIndex = page;
                        _currentMove = widget.move[_imageIndex]['description'];
                        _currentName = widget.move[_imageIndex]['name'];
                      });
                    },
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0),
                items: _images,
                carouselController: _carouselController,
              ),
            ),
            new Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                decoration: new BoxDecoration(color: Colors.black87),
                height: MediaQuery.of(context).size.height * 0.07,
                child: new Row(
                  children: [
                    new Image(
                      image: new AssetImage(
                        "assets/Controls/" + widget.button + ".png",
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Spacer(flex: 5),
                    new Text(_currentName,
                        style: TextStyle(color: Colors.white)),
                    Spacer(flex: 1),
                    (widget.move.length == 1
                        ? new Container()
                        : (_imageIndex < widget.move.length - 1
                            ? new Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              )
                            : new Icon(Icons.arrow_left, color: Colors.white))),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            new Positioned(
                child: new AnimatedOpacity(
              opacity: _visibility ? 1.0 : 0.0,
              duration: new Duration(milliseconds: 100),
              child: new Container(
                child: Center(
                  child: new Text(
                    _currentMove,
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
