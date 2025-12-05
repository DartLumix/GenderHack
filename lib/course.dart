import 'package:flutter/material.dart';
import 'dart:async';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> with TickerProviderStateMixin {
  int _step = 0;
  final List<String> _messages = [
    'Hi there!',
    'I\'m Ada',
    'Choose one',
    'Great!',
  ];

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _characterController;
  late Animation<Alignment> _characterAlignment;

  late AnimationController _characterFadeController;
  late Animation<double> _characterFadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _characterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _characterAlignment =
        Tween<Alignment>(
          begin: Alignment.center,
          end: const Alignment(1.2, -0.3),
        ).animate(
          CurvedAnimation(
            parent: _characterController,
            curve: Curves.easeInOut,
          ),
        );

    _characterFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _characterFadeAnimation = CurvedAnimation(
      parent: _characterFadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _characterController.dispose();
    _characterFadeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      if (_step < _messages.length - 1) {
        _step++;
        if (_step == 2) {
          _characterController.forward();
          _fadeController.forward();
        } else if (_step == 1) {
          _characterFadeController.forward();
        }
      } else {
        // Optional: Navigate back or to another screen when done
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: _nextStep,
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/back-purp-white.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Color.fromRGBO(0, 0, 0, 0.7),
                          BlendMode.darken,
                        ),
                        opacity: 0.6,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),

                // Fade in scene
                if (_step >= 2)
                  Align(
                    alignment: const Alignment(-0.6, -0.8),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                if (_step >=
                    1) // Show character after first message starts typing
                  AnimatedBuilder(
                    animation: _characterController,
                    builder: (context, child) {
                      return Align(
                        alignment: _characterAlignment
                            .value, // This handles the movement
                        child: FadeTransition(
                          opacity:
                              _characterFadeAnimation, // This handles the fade-in
                          child: Transform.rotate(
                            angle: _step >= 2
                                ? -0.2
                                : 0, // slight oblique angle
                            child: Container(
                              width: 100,
                              height: 150,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                Align(
                  alignment: _step < 2
                      ? const Alignment(0.0, 0.8)
                      : const Alignment(-0.3, 0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TypewriterText(
                      _messages[_step], // The text to be animated
                      key: ValueKey<int>(
                        _step,
                      ), // Essential for telling Flutter to recreate the widget
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;

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
