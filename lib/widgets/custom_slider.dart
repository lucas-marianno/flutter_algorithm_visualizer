import 'package:algorithm_visualizer/widgets/borded_container.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  const MySlider({
    required this.title,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.divisions,
    required this.min,
    required this.max,
    super.key,
  });
  final String title;
  final String label;
  final double value;
  final void Function(double) onChanged;
  final int divisions;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyBordedContainer(
        child: Column(
          children: [
            Text(title),
            Slider(
              label: label,
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
