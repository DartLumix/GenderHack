import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final Animation<Alignment> alignment;
  final Animation<double> opacity;
  final int step;
  final double angle;
  final Widget? child;

  const CharacterWidget({
    super.key,
    required this.alignment,
    required this.opacity,
    required this.step,
    this.angle = -0.2,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: alignment,
      builder: (context, animatedChild) {
        return Align(
          alignment: alignment.value, // This handles the movement
          child: FadeTransition(
            opacity: opacity, // This handles the fade-in
            child: Transform.rotate(
              angle: step >= 2 ? angle : 0, // Apply angle after moving
              child: animatedChild,
            ),
          ),
        );
      },
      child: child ??
          Container(
            width: 100,
            height: 150,
            color: Colors.red, // Placeholder for Rive animation
          ),
    );
  }
}