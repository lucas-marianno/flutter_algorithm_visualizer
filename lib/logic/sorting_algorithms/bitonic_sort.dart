import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> bitonicSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  Future<void> colorize(List<int> l, {Color? color = Colors.amber}) async {
    for (int i in l) {
      bars[i] = Bar(bars[i].value, color: color);
    }
    await updateBarsGraph(bars);
    for (int i in l) {
      bars[i] = Bar(bars[i].value);
    }
    updateBarsGraph(bars);
  }

  int nextPowerOf2(int n) {
    int power = 1;
    while (power < n) {
      power *= 2;
    }
    return power;
  }

  Future<void> removePadding() async {
    List<int> toBeRemoved = [];
    for (int i = 0; i < bars.length; i++) {
      if (bars[i].value >= 10000) {
        toBeRemoved.add(i);
      }
    }
    while (toBeRemoved.isNotEmpty) {
      bars.removeAt(toBeRemoved.last);
      toBeRemoved.removeLast();
    }
    await updateBarsGraph(bars);
  }

  Future<List<Bar>> sort(List<Bar> list) async {
    int originalLength = list.length;
    int nextPow = nextPowerOf2(originalLength);

    list.addAll(List.filled(nextPow - originalLength, const Bar(10000, color: Colors.grey)));

    int n = list.length;

    for (int k = 2; k <= n; k *= 2) {
      for (int j = k ~/ 2; j > 0; j ~/= 2) {
        for (int i = 0; i < n; i++) {
          if (hasStopped()) {
            await removePadding();
            return bars;
          }
          await colorize([i, j]);
          registerOperation();

          int l = i ^ j;
          if (l > i) {
            if ((i & k == 0 && list[i].value > list[l].value) ||
                (i & k != 0 && list[i].value < list[l].value)) {
              Bar temp = list[i];
              list[i] = list[l];
              list[l] = temp;
              colorize([i, j], color: Colors.red);
            }
          }
        }
      }
    }

    list.removeRange(originalLength, n);
    await updateBarsGraph(list);

    return list;
  }

  await sort(bars);
}
