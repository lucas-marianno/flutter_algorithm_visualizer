import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class SelectionSort extends SortingAlgorithm {
  SelectionSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    for (int sorted = 0; sorted < bars.length; sorted++) {
      int indexOfSmallest = sorted;

      highlight([indexOfSmallest], bars, color: Colors.red);

      for (int i = sorted + 1; i < bars.length; i++) {
        if (hasStopped()) return;
        await highlight([i], bars);

        if (bars[i].value < bars[indexOfSmallest].value) {
          undoHighlight([indexOfSmallest], bars);
          highlight([i], bars, color: Colors.red);

          indexOfSmallest = i;
        } else {
          undoHighlight([i], bars);
        }
        registerOperation();
      }
      Bar temp = bars[sorted];
      bars[sorted] = bars[indexOfSmallest];
      bars[indexOfSmallest] = temp;
      registerOperation();
      undoHighlight([sorted], bars);
    }
  }
}
