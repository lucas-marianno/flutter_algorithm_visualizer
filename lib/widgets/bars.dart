import 'package:algovis/logic/sorting_controller.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class Bars extends StatelessWidget {
  const Bars({super.key, required this.sortCtrl});

  final SortingController sortCtrl;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scaleFactor = constraints.maxHeight / sortCtrl.barMaxHeight;

        final List<Bar> scaledBars = List.generate(sortCtrl.bars.length, (int i) {
          final Bar b = sortCtrl.bars[i];
          return Bar((b.value * scaleFactor).toInt(), color: b.color);
        });

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: scaledBars,
        );
      },
    );
  }
}
