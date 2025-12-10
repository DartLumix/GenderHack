import 'package:flutter/material.dart';

/// A widget that displays a character image with animations.
///
/// Handles movement (alignment), rotation (angle), and fade-in (opacity) animations.
class CharacterWidget extends StatelessWidget {
  /// The alignment animation controlling the character's position.
  final Animation<Alignment> alignment;

  /// The angle animation controlling the character's rotation.
  final Animation<double> angleAnimation;

  /// The opacity animation controlling the character's fade-in effect.
  final Animation<double> opacity;

  /// An optional child widget to display instead of the default image.
  final Widget? child;

  /// Creates a [CharacterWidget].
  ///
  /// * [alignment]: Animation for position.
  /// * [angleAnimation]: Animation for rotation.
  /// * [opacity]: Animation for transparency.
  /// * [child]: Optional custom child widget.
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
