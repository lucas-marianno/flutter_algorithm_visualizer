import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> gnome(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  Future<void> colorize(int i, {Color? color = Colors.amber}) async {
    bars[i] = Bar(bars[i].value, color: color);
    await updateBarsGraph(bars);
    bars[i] = Bar(bars[i].value);
    updateBarsGraph(bars);
  }

  int i = 0;
  while (i < bars.length) {
    if (hasStopped()) return;
    registerOperation();

    if (i == 0 || bars[i].value >= bars[i - 1].value) {
      await colorize(i);
      i++;
    } else {
      await colorize(i, color: Colors.red);
      Bar temp = bars[i];
      bars[i] = bars[i - 1];
      bars[i - 1] = temp;
      i--;
    }
  }
}
