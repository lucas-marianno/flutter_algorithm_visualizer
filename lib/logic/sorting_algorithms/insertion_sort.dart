import 'package:algorithm_visualizer/logic/sorting_speed_controller.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> insertionSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
) async {
  Future<void> colorize(int i, {Color? color = Colors.amber}) async {
    bars[i] = Bar(bars[i].value, color: color);
    await updateBarsGraph(bars);
    bars[i] = Bar(bars[i].value);
    updateBarsGraph(bars);
  }

  for (int i = 1; i < bars.length; i++) {
    if (SortingControllerState().hasStopped) return;
    await colorize(i);

    //go back in the look and find the bar that is smaller than itself and place it there
    int j = i - 1;
    while (j >= 0 && bars[j].value > bars[j + 1].value) {
      if (SortingControllerState().hasStopped) return;
      await colorize(j + 1, color: Colors.red);

      Bar temp = bars[j];
      bars[j] = bars[j + 1];
      bars[j + 1] = temp;
      j--;
    }
  }
}