import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class MergeSort extends SortingAlgorithm {
  MergeSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  List<Bar> _bars = [];

  Future<void> _updateGraphics(
    int startIndex,
    int endIndex,
    List<Bar> merged,
    List<Bar> left,
    List<Bar> right, {
    bool highlightFirst = false,
  }) async {
    left = colorize(left, color: const Color.fromARGB(255, 68, 110, 131));
    right = colorize(right, color: Colors.grey);
    if (highlightFirst) {
      if (left.isNotEmpty) left[0] = Bar(left[0].value, color: Colors.amber);
      if (right.isNotEmpty) right[0] = Bar(right[0].value, color: Colors.amber);
    }
    if (merged.isNotEmpty) merged = colorize(merged);
    _bars.replaceRange(startIndex, endIndex, merged + left + right);
    await updateBarsGraph(_bars);
  }

  @override
  Future<void> sort(List<Bar> bars) async {
    _bars = bars;
    bars = await _mergeSort(bars, 0, bars.length);
    await updateBarsGraph(colorize(bars));
  }

  //startIndex and endIndex only use is to accurately display graphics
  Future<List<Bar>> _mergeSort(List<Bar> barsList, int startIndex, int endIndex) async {
    if (hasStopped()) return barsList;
    if (barsList.length == 1) return barsList;

    List<Bar> merged = [];
    List<Bar> left = barsList.sublist(0, barsList.length ~/ 2);
    List<Bar> right = barsList.sublist(barsList.length ~/ 2);

    await _updateGraphics(startIndex, endIndex, merged, left, right);

    //divide part
    left = await _mergeSort(left, 0 + startIndex, barsList.length ~/ 2 + startIndex);
    right =
        await _mergeSort(right, barsList.length ~/ 2 + startIndex, barsList.length + startIndex);

    //sort part
    while (left.isNotEmpty && right.isNotEmpty) {
      if (hasStopped()) return barsList;
      await _updateGraphics(startIndex, endIndex, merged, left, right, highlightFirst: true);

      if (left[0].value < right[0].value) {
        merged.add(left[0]);
        left.removeAt(0);
      } else {
        merged.add(right[0]);
        right.removeAt(0);
      }
      _updateGraphics(startIndex, endIndex, merged, left, right);
      registerOperation();
    }

    while (left.isNotEmpty) {
      merged.add(left[0]);
      left.removeAt(0);
      await _updateGraphics(startIndex, endIndex, merged, left, right);
      registerOperation();
    }
    while (right.isNotEmpty) {
      merged.add(right[0]);
      right.removeAt(0);
      await _updateGraphics(startIndex, endIndex, merged, left, right);
      registerOperation();
    }

    await _updateGraphics(startIndex, endIndex, merged, left, right);
    return merged;
  }
}
