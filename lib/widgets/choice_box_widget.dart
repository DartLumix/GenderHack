import 'package:flutter/material.dart';

class ChoiceBoxWidget extends StatelessWidget {
  final Animation<double> opacity;
  final ValueChanged<int> onChoiceSelected;

  const ChoiceBoxWidget({
    super.key,
    required this.opacity,
    required this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return FadeTransition(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () => onChoiceSelected(0),
                  style: buttonStyle,
                  child: const Text('Option A'),
                ),
                ElevatedButton(
                  onPressed: () => onChoiceSelected(1),
                  style: buttonStyle,
                  child: const Text('Option B'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () => onChoiceSelected(2),
                  style: buttonStyle,
                  child: const Text('Option C'),
                ),
                ElevatedButton(
                  onPressed: () => onChoiceSelected(3),
                  style: buttonStyle,
                  child: const Text('Option D'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}