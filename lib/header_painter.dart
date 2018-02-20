import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  HeaderPainter();

  final double animationValue = 0.0;

  @override
  paint(Canvas canvas, Size size) {
    _drawSky(canvas, size);

    _drawArc(canvas, size, 0.0, 30.0, 50.0, 1.0);
    _drawArc(canvas, size, 50.0, 145.0, 145.0, 0.35);
    _drawArc(canvas, size, 145.0, 80.0, 145.0, 0.35);
    _drawArc(canvas, size, 80.0, 50.0, 95.0, 0.35);

    _drawSunRays(canvas);
    _drawSun(canvas);

    _drawStar(canvas, 30.0, 35.0, 2.0, 0.35);
    _drawStar(canvas, 25.0, 150.0, 2.5, 0.6);
    _drawStar(canvas, 180.0, 75.0, 2.5, 0.9);
    _drawStar(canvas, 265.0, 80.0, 1.5, 0.4);
    _drawStar(canvas, 165.0, 150.0, 2.5, 0.75);
    _drawStar(canvas, 270.0, 155.0, 2.0, 0.35);
    _drawStar(canvas, 70.0, 215.0, 2.0, 0.35);
    _drawStar(canvas, 210.0, 233.0, 2.0, 0.35);

    _drawTree(canvas, size, -7.5, 35.0, 70.0);
    _drawTree(canvas, size, 12.0, 35.0, 56.5);
    _drawTree(canvas, size, 32.0, 40.0, 96.5);
    _drawTree(canvas, size, 57.0, 30.0, 55.0);
    _drawTree(canvas, size, size.width - 50.0, 17.5, 30.0);
    _drawTree(canvas, size, size.width - 35.0, 25.0, 60.0);
    _drawTree(canvas, size, size.width - 10.0, 10.0, 20.0);

    _drawFallingStar(canvas, 135.0, 90.0, 210.0, 40.0, 1.0);
    _drawFallingStar(canvas, 275.0, 60.0, 315.0, 30.0, 0.25);
    _drawFallingStar(canvas, 325.0, 135.0, 360.0, 100.0, 1.0);
  }

  _drawSky(Canvas canvas, Size size) {
    var skyGradient = new LinearGradient(
      colors: [
        Colors.lightBlueAccent.shade700,
        Colors.lightBlueAccent.shade100.withOpacity(0.8),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawRect(
      new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      new Paint()
        ..shader = skyGradient.createShader(
          new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        ),
    );
  }

  _drawArc(Canvas canvas, Size size, double pathLineToHeight,
      double endPointHeight, double controlPointHeight, double opacity) {
    var path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - pathLineToHeight);

    var endPoint = new Offset(0.0, size.height - endPointHeight);
    var controlPoint =
        new Offset(size.width / 2, size.height - controlPointHeight);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.close();

    canvas.drawPath(
      path,
      new Paint()..color = Colors.white.withOpacity(opacity),
    );
  }

  _drawTree(Canvas canvas, Size size, double dx, double width, double height) {
    var path = new Path();
    path.addPolygon([
      new Offset(dx, size.height),
      new Offset(dx + width, size.height),
      new Offset(dx + width / 2, size.height - height),
    ], true);
    path.close();

    canvas.drawPath(path, new Paint()..color = Colors.white);
  }

  _drawStar(
      Canvas canvas, double dx, double dy, double radius, double opacity) {
    var starGradientRadius = radius * 1.8;
    var startCenter = new Offset(dx, dy);

    var circleGradientShader = new RadialGradient(colors: [
      Colors.white.withOpacity(opacity),
      Colors.white.withOpacity(0.0)
    ]).createShader(
      new Rect.fromCircle(center: startCenter, radius: starGradientRadius),
    );

    canvas.drawCircle(startCenter, starGradientRadius,
        new Paint()..shader = circleGradientShader);
    canvas.drawCircle(
      startCenter,
      radius,
      new Paint()..color = Colors.white.withOpacity(opacity),
    );
  }

  _drawFallingStar(Canvas canvas, double dx, double dy, double endX,
      double endY, double opacity) {
    var fallingStarGradient = new LinearGradient(
      colors: [
        Colors.white.withOpacity(opacity),
        Colors.white.withOpacity(0.0),
      ],
    );

    var path = new Path();
    path.addPolygon([
      new Offset(dx - 1.0, dy - 1.5),
      new Offset(dx + 1.5, dy + 1.0),
      new Offset(endX, endY),
    ], true);
    path.close();

    canvas.drawPath(
      path,
      new Paint()
        ..shader = fallingStarGradient.createShader(
          new Rect.fromLTRB(dx, dy, endX, endY),
        ),
    );
    canvas.drawCircle(new Offset(dx, dy), 1.6,
        new Paint()..color = Colors.white.withOpacity(opacity - 0.2));
    _drawStar(canvas, dx, dy, 1.5, opacity);
  }

  _drawSun(Canvas canvas) {
    var sunCenter = new Offset(60.0, 90.0);

    var sunInnerGradientRadius = 35.0;
    var circleInnerGradientShader = new RadialGradient(colors: [
      Colors.white.withOpacity(0.5),
      Colors.white.withOpacity(0.0)
    ]).createShader(
      new Rect.fromCircle(center: sunCenter, radius: sunInnerGradientRadius),
    );
    canvas.drawCircle(sunCenter, sunInnerGradientRadius,
        new Paint()..shader = circleInnerGradientShader);

    var sunOuternGradientRadius = 50.0;
    var circleOuternGradientShader = new RadialGradient(colors: [
      Colors.white.withOpacity(0.35),
      Colors.white.withOpacity(0.0)
    ]).createShader(
      new Rect.fromCircle(center: sunCenter, radius: sunOuternGradientRadius),
    );
    canvas.drawCircle(sunCenter, sunOuternGradientRadius,
        new Paint()..shader = circleOuternGradientShader);

    canvas.drawCircle(sunCenter, 18.0, new Paint()..color = Colors.white);
  }

  _drawSunRays(Canvas canvas) {
    var sunCenter = new Offset(60.0, 90.0);

    var sunRayHorizontalColors = [
      new Color(0xFF4DA3E9).withOpacity(0.2),
      Colors.white.withOpacity(0.6),
      new Color(0xFF4DA3E9).withOpacity(0.2),
    ];

    var sunRayVerticalColors = [
      new Color(0xFF4197E5).withOpacity(0.2),
      Colors.white.withOpacity(0.6),
      new Color(0xFF66B6EF).withOpacity(0.2),
    ];

    var sunRayHorizontalRect = new Rect.fromLTRB(sunCenter.dx - 60.0,
        sunCenter.dy - 18.0, sunCenter.dx + 60.0, sunCenter.dy + 18.0);
    var sunRayVerticalRect = new Rect.fromLTRB(sunCenter.dx - 18.0,
        sunCenter.dy - 60.0, sunCenter.dx + 18.0, sunCenter.dy + 60.0);
    var sunRayHorizontalGradient =
        new LinearGradient(colors: sunRayHorizontalColors);
    var sunRayVerticalGradient = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: sunRayVerticalColors,
    );

    canvas.drawRect(
      sunRayHorizontalRect,
      new Paint()
        ..shader = sunRayHorizontalGradient.createShader(sunRayHorizontalRect),
    );
    canvas.drawRect(
      sunRayVerticalRect,
      new Paint()
        ..shader = sunRayVerticalGradient.createShader(sunRayVerticalRect),
    );
  }

  @override
  bool shouldRepaint(HeaderPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
