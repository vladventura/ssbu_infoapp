import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swipedetector/swipedetector.dart';

class MoveCard extends StatefulWidget {
  MoveCard({this.button = "", this.move = const []});
  final String button;
  final List<dynamic> move;
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

  /// Initial State of the Move Card
  ///
  /// We first get the move array from the DB (specifically sent by the character display).
  /// Then, we send this array of moves and build either a single [Image] for the [Row] inside
  /// the build method, or we return a [GestureDetector] with the

  @override
  void initState() {
    super.initState();
    _currentName = widget.move[0]['name'];
    _currentMove = widget.move[0]['description'];
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.move.forEach((element) {
      CachedNetworkImage img = new CachedNetworkImage(
        imageUrl: element['imageLink'],
        placeholder: (context, url) => CircularProgressIndicator(),
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
      child: SwipeDetector(
        onSwipeLeft: () => _carouselController.nextPage(),
        onSwipeRight: () => _carouselController.previousPage(),
        onSwipeDown: null,
        onSwipeUp: null,
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
                          _currentMove =
                              widget.move[_imageIndex]['description'];
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
                      new Text(_currentName,
                          style: TextStyle(color: Colors.white))
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
      ),
    );
  }
}
