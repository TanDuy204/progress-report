import 'dart:math';

import 'package:flutter/material.dart';

class PieChartProgress extends StatelessWidget {
  final double percentage;

  const PieChartProgress({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(25, 30),
      painter: PieChartPainter(percentage / 100),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double progress;

  PieChartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey[200]!;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      backgroundPaint,
    );

    double angle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -pi / 2,
      angle,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
