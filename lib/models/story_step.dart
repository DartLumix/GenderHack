import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

/// Defines the possible actions that can occur during a story step.
enum StoryAction {
  /// Shows the character widget.
  showCharacter,
  /// Moves the character to a new position.
  moveCharacter,
  /// Shows the background scene.
  showBackground,
  /// Displays the choice selection box.
  showChoices,
  /// Ends the current course/story.
  endCourse,
}

/// Represents a single choice available to the player in the story.
class StoryChoice {
  /// The text displayed for the choice.
  final String text;

  /// Creates a [StoryChoice].
  ///
  /// * [text]: The text content of the choice.
  const StoryChoice({required this.text});

  /// Creates a [StoryChoice] from a JSON map.
  ///
  /// * [json]: The JSON map containing the 'text' key.
  factory StoryChoice.fromJson(Map<String, dynamic> json) {
    return StoryChoice(
      text: json['text'] as String,
    );
  }
}

/// Represents a single step in the interactive story.
///
/// A step consists of a message to display, text alignment,
/// a list of actions to trigger, and optional choices for the user.
class StoryStep {
  /// The message text to display.
  final String message;

  /// The alignment of the message text on the screen.
  final Alignment textAlignment;

  /// The list of actions to execute when this step is reached.
  final List<StoryAction> actions;

  /// The list of choices available to the user at this step.
  final List<StoryChoice>? choices;

  /// Creates a [StoryStep].
  ///
  /// * [message]: The text content.
  /// * [textAlignment]: Where to position the text (default is (0.0, 0.8)).
  /// * [actions]: List of [StoryAction]s.
  /// * [choices]: Optional list of [StoryChoice]s.
  const StoryStep({
    required this.message,
    this.textAlignment = const Alignment(0.0, 0.8),
    this.actions = const [],
    this.choices,
  });

  /// Creates a [StoryStep] from a JSON map.
  ///
  /// * [json]: The JSON map containing step data.
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

  /// Checks if the character should be shown.
  bool get shouldShowCharacter => actions.contains(StoryAction.showCharacter);

  /// Checks if the character should move.
  bool get shouldMoveCharacter => actions.contains(StoryAction.moveCharacter);

  /// Checks if the background should be shown.
  bool get shouldShowBackground => actions.contains(StoryAction.showBackground);

  /// Checks if choices should be displayed.
  bool get shouldShowChoices => actions.contains(StoryAction.showChoices);

  /// Checks if the course should end.
  bool get shouldEndCourse => actions.contains(StoryAction.endCourse);
}
