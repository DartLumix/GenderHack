import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

enum StoryAction {
  showCharacter,
  moveCharacter,
  showBackground,
  showChoices,
  endCourse,
}

// single choice available to the player.
class StoryChoice {
  final String text;

  const StoryChoice({required this.text});

  factory StoryChoice.fromJson(Map<String, dynamic> json) {
    return StoryChoice(
      text: json['text'] as String,
    );
  }
}

// single step in the story.
class StoryStep {
  final String message;
  final Alignment textAlignment;
  final List<StoryAction> actions;
  final List<StoryChoice>? choices;

  const StoryStep({
    required this.message,
    this.textAlignment = const Alignment(0.0, 0.8),
    this.actions = const [],
    this.choices,
  });

  factory StoryStep.fromJson(Map<String, dynamic> json) {
    // Parse actions from a list of strings
    final List<StoryAction> actions = (json['actions'] as List<dynamic>?)
            ?.map((actionString) => StoryAction.values.firstWhereOrNull(
                (e) => e.toString() == 'StoryAction.$actionString'))
            .whereNotNull()
            .toList() ??
        [];

    // Parse choices
    final List<StoryChoice>? choices = (json['choices'] as List<dynamic>?)
        ?.map((choiceJson) => StoryChoice.fromJson(choiceJson))
        .toList();

    // Parse alignment from a list of two numbers
    final List<dynamic>? alignmentList = json['textAlignment'] as List<dynamic>?;
    final Alignment textAlignment = (alignmentList != null && alignmentList.length == 2)
        ? Alignment(
            (alignmentList[0] as num).toDouble(),
            (alignmentList[1] as num).toDouble(),
          )
        : const Alignment(0.0, 0.8);

    // parse message if null
    final String message = json['message'] as String? ?? '';

    return StoryStep(
        message: message,
        actions: actions,
        choices: choices,
        textAlignment: textAlignment);
  }

  /// Helper getters to make checking for actions and visibility cleaner in the UI.
  bool get shouldShowCharacter => actions.contains(StoryAction.showCharacter);
  bool get shouldMoveCharacter => actions.contains(StoryAction.moveCharacter);
  bool get shouldShowBackground => actions.contains(StoryAction.showBackground);
  bool get shouldShowChoices => actions.contains(StoryAction.showChoices);
  bool get shouldEndCourse => actions.contains(StoryAction.endCourse);
}