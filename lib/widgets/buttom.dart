import 'package:algorithm_visualizer/widgets/borded_container.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    required this.title,
    required this.onTap,
    this.selectedAlgorithm,
    super.key,
  });
  final String title;
  final void Function(String btnTitle)? onTap;
  final String? selectedAlgorithm;

  @override
  Widget build(BuildContext context) {
    final bool selected = selectedAlgorithm?.toLowerCase() == title.toLowerCase();
    return MyBordedContainer(
      color: selected ? Colors.deepPurple : null,
      child: TextButton(
        onPressed: () => onTap?.call(title),
        child: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : null),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
