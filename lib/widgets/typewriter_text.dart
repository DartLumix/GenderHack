import 'dart:async';
import 'package:flutter/material.dart';

/// A text widget that animates the display of text word by word,
/// simulating a typewriter effect.
class TypewriterText extends StatefulWidget {
  /// The full text string to display.
  final String text;

  /// The text style to apply.
  final TextStyle style;

  /// The duration between each word appearing.
  final Duration speed;

  /// Creates a [TypewriterText] widget.
  ///
  /// * [text]: The content to animate.
  /// * [style]: Text styling (default white, bold, size 25).
  /// * [speed]: Animation speed (default 500ms per word).
  const TypewriterText(
    this.text, {
    super.key,
    this.style = const TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    this.speed = const Duration(milliseconds: 500),
  });

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  late final List<String> _words;
  String _displayedText = '';
  Timer? _timer;
  int _wordIndex = 0;

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(' ');
    _startAnimation();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _timer?.cancel();
      _wordIndex = 0;
      _displayedText = '';
      _words.clear();
      _words.addAll(widget.text.split(' '));
      _startAnimation();
    }
  }

  void _startAnimation() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_wordIndex < _words.length) {
        setState(() {
          _displayedText = '$_displayedText ${_words[_wordIndex]}'.trim();
          _wordIndex++;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      textAlign: TextAlign.center,
      style: widget.style,
    );
  }
}
