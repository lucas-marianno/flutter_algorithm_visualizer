import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> cocktail(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  Future<void> colorize(int i, {Color? color = Colors.amber}) async {
    bars[i] = Bar(bars[i].value, color: color);
    await updateBarsGraph(bars);
    bars[i] = Bar(bars[i].value);
    updateBarsGraph(bars);
  }

  Future<void> sort() async {
    bool swapped = true;
    int start = 0;
    int end = bars.length;

    while (swapped) {
      swapped = false;

      // Forward pass
      for (int i = start; i < end - 1; i++) {
        if (hasStopped()) return;
        await colorize(i);
        registerOperation();
        if (bars[i].value > bars[i + 1].value) {
          Bar temp = bars[i];
          bars[i] = bars[i + 1];
          bars[i + 1] = temp;
          swapped = true;
        }
      }

      if (!swapped) break;

      swapped = false;
      end--;

      // Backward pass
      for (int i = end - 1; i > start; i--) {
        if (hasStopped()) return;
        await colorize(i);
        registerOperation();
        if (bars[i].value < bars[i - 1].value) {
          Bar temp = bars[i];
          bars[i] = bars[i - 1];
          bars[i - 1] = temp;
          swapped = true;
        }
      }

      start++;
    }
  }

  await sort();
}
