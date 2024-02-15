import 'package:flutter/material.dart';

class CutomTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CutomTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  _CirclePainter({
    required this.color,
    required this.radius,
  });
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = offset + Offset(configuration.size!.width/2 -radius/2, configuration.size!.height - radius);

    canvas.drawCircle(circleOffset, radius, paint);
  }
}
