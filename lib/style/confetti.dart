import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

ConfettiController controller =
    ConfettiController(duration: const Duration(seconds: 1));
void showConfetti(BuildContext context) {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0.0,
      right: 0.0,
      left: 10.0,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirection: pi / 2,
        particleDrag: 0.05,
        emissionFrequency: 0.5,
        numberOfParticles: 10,
        maxBlastForce: 11,
        minBlastForce: 10,
        gravity: 0.5,
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.orange,
          Colors.white,
        ],
      ),
    ),
  );
  overlayState.insert(overlayEntry);
  controller.play();
}
