import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> shell(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  Future<void> colorize(List<int> index, {Color? color = Colors.amber}) async {
    for (int i in index) {
      bars[i] = Bar(bars[i].value, color: color);
    }
    await updateBarsGraph(bars);
    for (int i in index) {
      bars[i] = Bar(bars[i].value);
    }
    updateBarsGraph(bars);
  }

  Future<List<Bar>> shellSort(List<Bar> barsList) async {
    int n = barsList.length;

    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < n; i++) {
        if (hasStopped()) return barsList;
        await colorize([i]);
        registerOperation();

        Bar temp = barsList[i];

        int j;
        for (j = i; j >= gap && barsList[j - gap].value > temp.value; j -= gap) {
          if (hasStopped()) return barsList;
          await colorize([i, j - gap], color: Colors.red);
          registerOperation();

          barsList[j] = barsList[j - gap];
        }

        barsList[j] = temp;
      }
    }
    return barsList;
  }

  await updateBarsGraph(await shellSort(bars));
}
