import 'dart:math';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> bogoSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  void colorizeRandom() {
    for (int i = 0; i < bars.length; i++) {
      if (Random().nextBool()) {
        bars[i] = Bar(bars[i].value, color: Colors.amber);
      } else {
        bars[i] = Bar(bars[i].value);
      }
    }
  }

  bool isSorted() {
    for (int i = 1; i < bars.length; i++) {
      if (bars[i - 1].value > bars[i].value) {
        return false;
      }
    }
    return true;
  }

  while (!isSorted() && !hasStopped()) {
    bars.shuffle();
    colorizeRandom();

    await updateBarsGraph(bars);

    //just in case user sets to instant (avoids overflow)
    await Future.delayed(const Duration(milliseconds: 1));
    registerOperation();
  }
}
