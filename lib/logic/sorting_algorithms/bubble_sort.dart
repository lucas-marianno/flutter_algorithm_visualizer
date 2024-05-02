import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> bubble(List<Bar> bars, Future<void> Function(List<Bar> newBar) updateBarsGraph) async {
  //graphics
  Future<void> highLight(List<int> indexes) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value, color: Colors.amber);
    }
    await updateBarsGraph(bars);
  }

  Future<void> undoHighLight(List<int> indexes) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value);
    }
    await updateBarsGraph(bars);
  }

  //logic
  Future<void> bubbleSort(int steps, {bool isSorted = false}) async {
    if (steps <= 1 || isSorted) return;
    isSorted = true;
    for (int i = 0; i < steps - 1; i++) {
      await highLight([i, i + 1]);

      if (bars[i].value > bars[i + 1].value) {
        isSorted = false;
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await undoHighLight([i, i + 1]);
    }
    await bubbleSort(steps - 1, isSorted: isSorted);
  }

  await bubbleSort(bars.length);
}
