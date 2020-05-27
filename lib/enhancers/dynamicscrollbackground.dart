import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DynamicScrollBackground extends StatefulWidget {
  final double firstHue;
  final double secondHue;
  final double topStop;
  final double bottomStop;
  final Widget child;
  final ScrollController childScrollController;
  final bool moveStops;
  final double velocityScale;
  final colorGrowthBase;
  final int backgroundRefreshDelay;
  final int backgorundDelay;

  DynamicScrollBackground(
      {@required this.firstHue,
      @required this.secondHue,
      @required this.child,
      @required this.childScrollController,
      this.topStop = 0.5,
      this.bottomStop = 1.5,
      this.moveStops = false,
      this.velocityScale = 0.3,
      this.colorGrowthBase = 0.01,
      this.backgorundDelay = 100,
      this.backgroundRefreshDelay = 5,
      this.bottomLeftPoint = 319,
      this.bottomRightPoint = 359});

  @override
  _DynamicScrollBackgroundState createState() =>
      _DynamicScrollBackgroundState();
}

class _DynamicScrollBackgroundState extends State<DynamicScrollBackground> {
  double _iFH = 0;
  double _iSH = 0;
  Color _topColor = Colors.white;
  Color _bottomColor = Colors.white;
  List <Color> _colors = [];

  @override
  void initState(){
    super.initState();
    _iFH = widget.firstHue;
    _iSH = widget.secondHue;
    _topColor = HSVColor.fromAHSV(1, widget.firstHue, 1, 1).toColor();
    _bottomColor = HSVColor.fromAHSV(1, widget.secondHue, 1, 1).toColor();
    _colors = [_topColor, _bottomColor];
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: widget.child,
      onNotification: (notification) {
        ScrollDirection direction =
            widget.childScrollController.position.userScrollDirection;
        double velocity = widget.childScrollController.position.velocity.abs();
        double convertedVelocity = cascadeVelocity(velocity);

        switch (direction) {
          case ScrollDirection.forward:
            moveForward(convertedVelocity);
            break;
          case ScrollDirection.reverse:
            moveBackwards(convertedVelocity);
            break;
          default: break;
        }

        return true;
      },
    );
  }

  void moveForward(double convertedVelocity){
    double f = _iFH - convertedVelocity;
    double s =_iSH - convertedVelocity;

    if (f < 0){
      f = widget.firstHue;
      s = widget.secondHue; 
    }

    Future.delayed(Duration(milliseconds: widget.backgroundRefreshDelay), () {
      setState(() {
        _iFH = f;
        _iSH = s;
        _topColor = new HSVColor.fromAHSV(1, _iFH, 1, 1).toColor();
        _bottomColor = new HSVColor.fromAHSV(1, _iSH, 1, 1).toColor();
        _colors = [_topColor, _bottomColor];
      });
    });
  }
  void moveBackwards(double convertedVelocity){
    double f = _iFH + convertedVelocity;
    double s =_iSH + convertedVelocity;

    if (s > 360){
      f = widget.firstHue;
      s = widget.secondHue; 
    }

    Future.delayed(Duration(milliseconds: widget.backgroundRefreshDelay), () {
      setState(() {
        _iFH = f;
        _iSH = s;
        _topColor = new HSVColor.fromAHSV(1, _iFH, 1, 1).toColor();
        _bottomColor = new HSVColor.fromAHSV(1, _iSH, 1, 1).toColor();
        _colors = [_topColor, _bottomColor];
      });
    });
  }

  double cascadeVelocity(double velocity) {
    double convertedVelocity = widget.colorGrowthBase;
    if (velocity > 1000) {
      velocity /= 1000;
      convertedVelocity = (widget.velocityScale * velocity);
    }

    if (velocity > 100) {
      velocity /= 100;
      convertedVelocity = (widget.velocityScale * velocity);
    }

    if (velocity > 10) {
      velocity /= 10;
      convertedVelocity = (widget.velocityScale * velocity);
    }
    return convertedVelocity;
  }
}
