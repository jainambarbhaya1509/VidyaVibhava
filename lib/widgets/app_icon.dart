import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GeneralAppIcon extends StatelessWidget {
  IconData icon;
  Color color;
  double? size;

  GeneralAppIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
