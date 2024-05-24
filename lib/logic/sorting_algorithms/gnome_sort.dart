import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class GnomeSort extends SortingAlgorithm {
  GnomeSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    int i = 0;
    while (i < bars.length) {
      if (hasStopped()) return;
      registerOperation();

      if (i == 0 || bars[i].value >= bars[i - 1].value) {
        await tempHighlight([i], bars);
        i++;
      } else {
        await tempHighlight([i], bars, color: Colors.red);
        Bar temp = bars[i];
        bars[i] = bars[i - 1];
        bars[i - 1] = temp;
        i--;
      }
    }
  }
}
