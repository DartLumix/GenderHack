import 'package:flutter/material.dart';

class SceneObject extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Alignment alignment;
  final Widget? child;

  const SceneObject({
    super.key,
    required this.fadeAnimation,
    this.alignment = const Alignment(-0.6, -0.8),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: child ??
            Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
      ),
    );
  }
}