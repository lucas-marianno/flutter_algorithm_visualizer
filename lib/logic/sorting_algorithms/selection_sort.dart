import 'package:algorithm_visualizer/logic/sorting_speed_controller.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> selectionSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
) async {
  Future<void> update(int i, {Color? color}) async {
    bars[i] = Bar(bars[i].value, color: color);
    await updateBarsGraph(bars);
  }

  bool isSorted = true;

  for (int sorted = 0; sorted < bars.length; sorted++) {
    int indexOfSmallest = sorted;

    await update(indexOfSmallest, color: Colors.red);

    for (int i = sorted + 1; i < bars.length; i++) {
      if (SortingControllerState().hasStopped) return;
      await update(i, color: Colors.amber);

      if (bars[i].value < bars[indexOfSmallest].value) {
        isSorted = false;
        update(indexOfSmallest);
        update(i, color: Colors.red);

        indexOfSmallest = i;
      } else {
        update(i);
      }
      if (i == bars.length - 1 && isSorted) return;
    }
    Bar temp = bars[sorted];
    bars[sorted] = bars[indexOfSmallest];
    bars[indexOfSmallest] = temp;
    update(sorted);
  }

  await updateBarsGraph(bars);
}
