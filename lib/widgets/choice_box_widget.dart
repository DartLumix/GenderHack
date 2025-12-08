import 'package:flutter/material.dart';
import '../models/story_step.dart';

class ChoiceBoxWidget extends StatelessWidget {
  final Animation<double> opacity;
  final ValueChanged<int> onChoiceSelected;
  final List<StoryChoice> choices;

  const ChoiceBoxWidget({
    super.key,
    required this.opacity,
    required this.onChoiceSelected,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.37, MediaQuery.of(context).size.height * 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return FadeTransition(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12.0,
            // a row for each couple of choices
            children: [
              for (int i = 0; i < choices.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // first choice
                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => onChoiceSelected(i),
                      child: Text(
                        choices[i].text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (i + 1 < choices.length)
                      // second choice
                      ElevatedButton(
                        style: buttonStyle,
                        onPressed: () => onChoiceSelected(i + 1),
                        child: Text(
                          choices[i + 1].text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          softWrap: true,
                        ),
                      ),
                  ],
                ),
            ]),
      ),
    );
  }
}
