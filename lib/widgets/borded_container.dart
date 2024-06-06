import 'package:flutter/material.dart';

class MyBordedContainer extends StatelessWidget {
  const MyBordedContainer({required this.child, this.height, this.width, this.color, super.key});
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: child,
    );
  }
}
