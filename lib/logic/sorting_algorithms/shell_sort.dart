import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class ShellSort extends SortingAlgorithm {
  ShellSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    int n = bars.length;

    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < n; i++) {
        if (hasStopped()) return;
        await tempHighlight([i], bars);
        registerOperation();

        Bar temp = bars[i];

        int j;
        for (j = i; j >= gap && bars[j - gap].value > temp.value; j -= gap) {
          if (hasStopped()) return;
          await tempHighlight([i, j - gap], bars, color: Colors.red);
          registerOperation();

          bars[j] = bars[j - gap];
        }

        bars[j] = temp;
      }
    }
    await updateBarsGraph(bars);
  }
}
