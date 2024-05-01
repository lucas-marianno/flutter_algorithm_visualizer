import 'package:algorithm_visualizer/widgets/borded_container.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.title, required this.onTap, super.key});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MyBordedContainer(
      child: TextButton(
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
