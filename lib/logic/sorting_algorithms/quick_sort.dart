import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> quick(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  List<Bar> colorize(List<Bar> barsList, {Color? color}) {
    List<Bar> colorized = [];
    for (Bar bar in barsList) {
      colorized.add(Bar(bar.value, color: color));
    }
    return colorized;
  }

  Future<void> updateGraphics(
    List<Bar> pre,
    List<Bar> left,
    List<Bar> center,
    List<Bar> equal,
    List<Bar> right,
    List<Bar> pos,
  ) async {
    pre = colorize(pre);
    left = colorize(left, color: const Color.fromARGB(255, 68, 110, 131));
    // center = colorize(center);
    equal = colorize(equal, color: Colors.red);
    right = colorize(right, color: Colors.grey);
    pos = colorize(pos);
    bars = pre + left + center + equal + right + pos;
    await updateBarsGraph(bars);
  }

  Future<List<Bar>> sort(List<Bar> barsList, {List<Bar>? pre, List<Bar>? pos}) async {
    if (barsList.isEmpty || hasStopped()) return barsList;
    pre = pre ?? [];
    pos = pos ?? [];

    List<Bar> smaller = [];
    List<Bar> equal = [];
    List<Bar> larger = [];

    int pivotIndex = barsList.length ~/ 2;
    Bar pivot = Bar(barsList[pivotIndex].value, color: Colors.red);
    barsList[pivotIndex] = pivot;

    while (barsList.isNotEmpty && !hasStopped()) {
      barsList[0] = Bar(barsList[0].value, color: Colors.amber);

      await updateGraphics(pre, smaller, barsList, equal, larger, pos);
      if (barsList[0].value < pivot.value) {
        smaller.add(Bar(barsList[0].value));
      } else if (barsList[0].value > pivot.value) {
        larger.add(Bar(barsList[0].value));
      } else {
        equal.add(Bar(barsList[0].value));
      }

      barsList.removeAt(0);
      updateGraphics(pre, smaller, barsList, equal, larger, pos);
      registerOperation();
    }
    smaller = await sort(smaller, pre: pre, pos: equal + larger + pos);
    larger = await sort(larger, pre: pre + smaller + equal, pos: pos);
    barsList.addAll([...smaller, ...equal, ...larger]);
    return barsList;
  }

  bars = await sort(bars);
  await updateBarsGraph(bars);
}
