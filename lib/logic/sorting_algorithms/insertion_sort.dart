import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class InsertionSort extends SortingAlgorithm {
  InsertionSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    for (int i = 1; i < bars.length; i++) {
      if (hasStopped()) return;
      await tempHighlight([i], bars);

      int j = i - 1;
      while (j >= 0 && bars[j].value > bars[j + 1].value) {
        if (hasStopped()) return;
        await tempHighlight([j + 1], bars, color: Colors.red);

        Bar temp = bars[j];
        bars[j] = bars[j + 1];
        bars[j + 1] = temp;
        j--;
        registerOperation();
      }
      registerOperation();
    }
    await updateBarsGraph(bars);
  }
}
