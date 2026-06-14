import 'package:flutter/material.dart';
import 'package:mole/size/size_config.dart';

class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final line = SizeConfig.w(60);
    final paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = SizeConfig.w(10)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(line, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, line), paint);

    canvas.drawLine(Offset(size.width, 0), Offset(size.width - line, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, line), paint);

    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - line),
      paint,
    );
    canvas.drawLine(Offset(0, size.height), Offset(line, size.height), paint);

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - line, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - line),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
