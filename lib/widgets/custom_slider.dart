import 'package:algovis/widgets/borded_container.dart';
import 'package:algovis/widgets/input_int_dialog.dart';
import 'package:flutter/material.dart';

class MySlider extends StatelessWidget {
  const MySlider({
    required this.title,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    this.manualInput = true,
    super.key,
  });
  final String title;
  final String label;
  final int value;
  final void Function(int) onChanged;
  final int min;
  final int max;
  final bool manualInput;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MyBordedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InkWell(
                onLongPress: () async {
                  if (!manualInput) return;
                  final newValue = await intInputDialog(context, title, value, min, max);

                  if (newValue != null) onChanged(newValue);
                },
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.deepPurple[900]),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Slider(
                  label: label,
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (n) => onChanged(n.toInt()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:algovis/widgets/borded_container.dart';
// import 'package:flutter/material.dart';

// class MySlider extends StatelessWidget {
//   const MySlider({
//     required this.title,
//     required this.label,
//     required this.value,
//     required this.onChanged,
//     required this.min,
//     required this.max,
//     super.key,
//   });
//   final String title;
//   final String label;
//   final int value;
//   final void Function(double) onChanged;
//   final int min;
//   final int max;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: MyBordedContainer(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 12, color: Colors.deepPurple[900]),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Slider(
//                   label: label,
//                   value: value.toDouble(),
//                   min: min.toDouble(),
//                   max: max.toDouble(),
//                   divisions: max - min,
//                   onChanged: onChanged,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
