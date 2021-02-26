import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
        painter: ClockPainter(),
      ),
    ),
    );
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Colors.indigo[800];

    var outlineBrush = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16.0;

    var insideCircleBrush = Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill
      ..strokeWidth = 16.0;


    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16.0;

    var secHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.orange, Colors.red]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.pink[200], Colors.purpleAccent[700]]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16.0;


    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX + 60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX + 60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX,minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX,secHandY), secHandBrush);


    canvas.drawCircle(center, 16, insideCircleBrush);


    var outerLineCircle = radius;
    var innerLineCircle = radius - 14;

    for(double i = 0; i < 360; i += 12){
      var x1 = centerX + outerLineCircle * cos(i * pi / 180);
      var y1 = centerX + outerLineCircle * sin(i * pi / 180);

      var x2 = centerX + innerLineCircle * cos(i * pi / 180);
      var y2 = centerX + innerLineCircle * sin(i * pi / 180);

      var dashBrush = Paint()
      ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2;

      canvas.drawLine(Offset(x1,y1), Offset(x2,y2), dashBrush);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
