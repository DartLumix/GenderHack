import 'package:flutter/material.dart';

import 'widgets/character_widget.dart';
import 'widgets/scene_object.dart';
import 'widgets/typewriter_text.dart';
import 'widgets/choice_box_widget.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> with TickerProviderStateMixin {
  int _step = 0;
  int? _selectedChoice;
  final List<String> _messages = [
    'Hi there!',
    'I\'m Ada',
    'I will guide you into my story.',
    'Choose one.',
    'Great! You chose option ',
  ];

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _characterController;
  late Animation<Alignment> _characterAlignment;

  late AnimationController _characterAngleController;
  late Animation<double> _characterAngleAnimation;

  late AnimationController _characterFadeController;
  late Animation<double> _characterFadeAnimation;

  late AnimationController _choiceBoxFadeController;
  late Animation<double> _choiceBoxFadeAnimation;

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

    _characterAngleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _characterAngleAnimation = Tween<double>(begin: 0.0, end: -0.2).animate(
      CurvedAnimation(
        parent: _characterAngleController,
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

    _choiceBoxFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _choiceBoxFadeAnimation = CurvedAnimation(
      parent: _choiceBoxFadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _characterController.dispose();
    _characterAngleController.dispose();
    _characterFadeController.dispose();
    _choiceBoxFadeController.dispose();
    super.dispose();
  }

  void _nextStep([int? choiceIndex]) {
    // Prevent advancing state by tapping when choices are visible at step 3
    if (_step == 3 && choiceIndex == null) return;

    setState(() {
      if (choiceIndex != null) {
        _selectedChoice = choiceIndex;
      }
      if (_step < _messages.length) {
        _step++;
        if (_step == 1) {
          _characterFadeController.forward();
        } else if (_step == 3) {
          _characterController.forward();
          _characterAngleController.forward();
          _fadeController.forward();
          _choiceBoxFadeController.forward(from: 0.0);
        } else if (_step == 5) {
          Navigator.pop(context);
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

                if (_step >= 3)
                  SceneObject(
                    fadeAnimation: _fadeAnimation,
                  ),
                if (_step >= 1)
                  CharacterWidget(
                    alignment: _characterAlignment,
                    opacity: _characterFadeAnimation,
                    angleAnimation: _characterAngleAnimation,
                  ),
                if (_step == 3)
                  Align(
                    alignment: const Alignment(0.1, 0.9),
                    child: ChoiceBoxWidget(
                      opacity: _choiceBoxFadeAnimation,
                      onChoiceSelected: (index) {
                        print('Choice $index selected');
                        _nextStep(index); // Proceed after a choice is made
                      },
                    ),
                  ),
                Align(
                  alignment: _step < 3
                      ? const Alignment(0.0, 0.8)
                      : const Alignment(-0.23, 0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TypewriterText(
                      _step < _messages.length
                          ? _messages[_step]
                          : '', // The text to be animated
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
