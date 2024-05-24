import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class QuickSort extends SortingAlgorithm {
  QuickSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });
  List<Bar> _bars = [];

  @override
  Future<void> sort(List<Bar> bars) async {
    _bars = bars;
    bars = await _quick(bars);
    await updateBarsGraph(bars);
  }

  Future<void> _updateGraphics(
    List<Bar> pre,
    List<Bar> left,
    List<Bar> center,
    List<Bar> equal,
    List<Bar> right,
    List<Bar> pos,
  ) async {
    pre = colorize(pre, color: Colors.blue);
    left = colorize(left, color: const Color.fromARGB(255, 68, 110, 131));
    equal = colorize(equal, color: Colors.red);
    right = colorize(right, color: Colors.grey);
    pos = colorize(pos, color: Colors.blue);
    _bars = pre + left + center + equal + right + pos;
    await updateBarsGraph(_bars);
  }

  Future<List<Bar>> _quick(List<Bar> barsList, {List<Bar>? pre, List<Bar>? pos}) async {
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

      await _updateGraphics(pre, smaller, barsList, equal, larger, pos);
      if (barsList[0].value < pivot.value) {
        smaller.add(Bar(barsList[0].value));
      } else if (barsList[0].value > pivot.value) {
        larger.add(Bar(barsList[0].value));
      } else {
        equal.add(Bar(barsList[0].value));
      }

      barsList.removeAt(0);
      _updateGraphics(pre, smaller, barsList, equal, larger, pos);
      registerOperation();
    }
    smaller = await _quick(smaller, pre: pre, pos: equal + larger + pos);
    larger = await _quick(larger, pre: pre + smaller + equal, pos: pos);
    barsList.addAll([...smaller, ...equal, ...larger]);
    return barsList;
  }
}
