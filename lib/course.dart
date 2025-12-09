import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/story_step.dart';
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
  late Future<List<StoryStep>> _storyFuture;
  List<StoryStep> _story = [];

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
    _storyFuture = _loadStory();

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
          end: const Alignment(1.2, -0.5),
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

  Future<List<StoryStep>> _loadStory() async {
    final String jsonString =
        await rootBundle.loadString('assets/story/ada.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((jsonStep) =>
            StoryStep.fromJson(jsonStep as Map<String, dynamic>))
        .toList();
  }

  void _processStepActions(StoryStep currentStep) {
    if (currentStep.shouldShowCharacter) {
      _characterFadeController.forward();
    }
    if (currentStep.shouldMoveCharacter) {
      _characterController.forward();
      _characterAngleController.forward();
    }
    if (currentStep.shouldShowBackground) {
      _fadeController.forward();
    }
    if (currentStep.shouldShowChoices) {
      _choiceBoxFadeController.forward(from: 0.0);
    }
    if (currentStep.shouldEndCourse) {
      Navigator.pop(context);
    }
  }

  void _nextStep([int? choiceIndex]) {
    if (_story[_step].shouldShowChoices && choiceIndex == null) return;

    setState(() {
      if (_step < _story.length - 1) {
        _step++;
        _processStepActions(_story[_step]);
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
        child: FutureBuilder<List<StoryStep>>(
          future: _storyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading story: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Story not found.'));
            }

            _story = snapshot.data!;
            // Determine visibility based on all steps up to the current one.
            final bool isCharacterVisible =
                _story.sublist(0, _step + 1).any((s) => s.shouldShowCharacter);
            final bool isBackgroundVisible =
                _story.sublist(0, _step + 1).any((s) => s.shouldShowBackground);
            final currentStep = _story[_step];

            return GestureDetector(
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

                    if (isBackgroundVisible)
                      SceneObject(
                        fadeAnimation: _fadeAnimation,
                      ),
                    if (isCharacterVisible)
                      CharacterWidget(
                        alignment: _characterAlignment,
                        opacity: _characterFadeAnimation,
                        angleAnimation: _characterAngleAnimation,
                      ),
                    if (currentStep.shouldShowChoices)
                      Align(
                        alignment: const Alignment(0.1, 0.9),
                        child: ChoiceBoxWidget(
                          choices: currentStep.choices!,
                          opacity: _choiceBoxFadeAnimation,
                          onChoiceSelected: (index) {
                            print('Choice $index selected');
                            _nextStep(index); // Proceed after a choice is made
                          },
                        ),
                      ),
                    Align(
                      alignment: currentStep.textAlignment,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TypewriterText(
                          currentStep.message, // The text to be animated
                          key: ValueKey<int>(
                            _step,
                          ), // Essential for telling Flutter to recreate the widget
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 350),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
