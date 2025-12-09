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
        child: ShaderMask( // Vertical fade
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent
              ],
              stops: [0.0, 0.07, 0.85, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ShaderMask( // Horizontal fade
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent
                ],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: child ??
                Container(
                  width: 270,
                  height: 200,
                  decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          Image.asset('assets/scene.png', fit: BoxFit.cover)),
                ),
          ),
        ),
      ),
    );
  }
}