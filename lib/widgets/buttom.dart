import 'package:algorithm_visualizer/widgets/borded_container.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.title, required this.onTap, this.selectedAlgorithm, super.key});
  final String title;
  final void Function()? onTap;
  final String? selectedAlgorithm;

  @override
  Widget build(BuildContext context) {
    final bool selected = selectedAlgorithm?.toLowerCase() == title.toLowerCase();
    return MyBordedContainer(
      color: selected ? Colors.grey : null,
      child: TextButton(
        onPressed: onTap,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
