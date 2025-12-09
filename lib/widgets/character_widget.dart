import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  final Animation<Alignment> alignment;
  final Animation<double> angleAnimation;
  final Animation<double> opacity;
  final Widget? child;

  const CharacterWidget({
    super.key,
    required this.alignment,
    required this.angleAnimation,
    required this.opacity,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([alignment, angleAnimation]),
      builder: (context, animatedChild) {
        return Align(
          alignment: alignment.value, // This handles the movement
          child: FadeTransition(
            opacity: opacity, // This handles the fade-in
            child: Transform.rotate(
              angle: angleAnimation.value, // Apply animated angle
              child: animatedChild,
            ),
          ),
        );
      },
      child: child ??
          SizedBox(
            width: 150,
            height: 200,
            child: Image.asset('assets/base.png'),
            // color: Colors.red,
          ),
    );
  }
}