import 'package:algorithm_visualizer/widgets/borded_container.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    required this.title,
    required this.onTap,
    super.key,
  });
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MyBordedContainer(
      child: TextButton(
        onPressed: onTap,
        child: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}