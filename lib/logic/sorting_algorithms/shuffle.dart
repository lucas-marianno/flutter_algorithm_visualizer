import 'dart:math';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> shuffle(
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

  Future<void> slowShuffle() async {
    for (int i = 1; i < bars.length; i++) {
      if (hasStopped()) return;

      int rnd = Random().nextInt(i);
      Bar temp = bars[rnd];
      bars[rnd] = bars[i];
      bars[i] = temp;

      await colorize([i, rnd]);
      registerOperation();
    }
  }

  await slowShuffle();
}
