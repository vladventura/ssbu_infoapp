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
  final Duration backgroundRefreshDelay;
  final Duration backgorundDelay;
  final double bottomLeftPoint;
  final double bottomRightPoint;
  final Curve animationCurve;
  final Alignment gradientBegin;
  final Alignment gradientEnd;

  DynamicScrollBackground(
      {@required this.firstHue,
      @required this.secondHue,
      @required this.child,
      @required this.childScrollController,
      this.gradientBegin = Alignment.topLeft,
      this.gradientEnd = Alignment.bottomRight,
      this.topStop = 0.5,
      this.bottomStop = 1.5,
      this.moveStops = false,
      this.velocityScale = 0.3,
      this.colorGrowthBase = 0.01,
      this.backgorundDelay = const Duration(milliseconds: 100),
      this.backgroundRefreshDelay = const Duration(milliseconds: 5),
      this.bottomLeftPoint = 319,
      this.bottomRightPoint = 359,
      this.animationCurve = Curves.linear});

  @override
  _DynamicScrollBackgroundState createState() =>
      _DynamicScrollBackgroundState();
}

class _DynamicScrollBackgroundState extends State<DynamicScrollBackground> {
  double _iFH = 0;
  double _iSH = 0;
  Color _topColor = Colors.white;
  Color _bottomColor = Colors.white;
  List<Color> _colors = [];

  @override
  void initState() {
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
        child: AnimatedContainer(
          child: widget.child,
          duration: widget.backgorundDelay,
          curve: widget.animationCurve,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: _colors,
            stops: [widget.topStop, widget.bottomStop],
            begin: widget.gradientBegin,
            end: widget.gradientEnd,
          )),
        ),
        onNotification: handleScroll);
  }

  bool handleScroll(ScrollNotification notification) {
    ScrollDirection direction =
        widget.childScrollController.position.userScrollDirection;
    // ignore: invalid_use_of_protected_member
    double velocity = widget.childScrollController.position.activity.velocity;
    double convertedVelocity = cascadeVelocity(velocity);

    switch (direction) {
      case ScrollDirection.forward:
        moveForward(convertedVelocity);
        break;
      case ScrollDirection.reverse:
        moveBackwards(convertedVelocity);
        break;
      default:
        break;
    }
    return true;
  }

  void moveForward(double convertedVelocity) {
    double f = _iFH - convertedVelocity;
    double s = _iSH - convertedVelocity;

    if (f < 0) {
      f = widget.firstHue;
      s = widget.secondHue;
    }

    Future.delayed(widget.backgroundRefreshDelay, () {
      setState(() {
        _iFH = f;
        _iSH = s;
        _topColor = new HSVColor.fromAHSV(1, _iFH, 1, 1).toColor();
        _bottomColor = new HSVColor.fromAHSV(1, _iSH, 1, 1).toColor();
        _colors = [_topColor, _bottomColor];
      });
    });
  }

  void moveBackwards(double convertedVelocity) {
    double f = _iFH + convertedVelocity;
    double s = _iSH + convertedVelocity;

    if (s > 360) {
      f = widget.bottomLeftPoint;
      s = widget.bottomRightPoint;
    }

    Future.delayed(widget.backgroundRefreshDelay, () {
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
