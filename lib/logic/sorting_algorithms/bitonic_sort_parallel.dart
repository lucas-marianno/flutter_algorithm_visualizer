import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class ParallelBitonicSort extends SortingAlgorithm {
  ParallelBitonicSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    await _addPadding(bars);
    await _bitonicSort(bars, 0, bars.length, true);
    await _removePadding(bars);
    await updateBarsGraph(bars);
  }

  int _nextPowerOf2(int n) {
    int power = 1;
    while (power < n) {
      power *= 2;
    }
    return power;
  }

  Future<void> _removePadding(List<Bar> bars) async {
    List<int> toBeRemoved = [];
    for (int i = 0; i < bars.length; i++) {
      if (bars[i].value >= 10000) {
        toBeRemoved.add(i);
      }
    }
    while (toBeRemoved.isNotEmpty) {
      bars.removeAt(toBeRemoved.last);
      toBeRemoved.removeLast();
      if (!hasStopped()) await updateBarsGraph(bars);
    }
  }

  Future<void> _addPadding(List<Bar> bars) async {
    int nextPow = _nextPowerOf2(bars.length);

    while (bars.length < nextPow) {
      bars.add(const Bar(10000, color: Colors.grey));
      if (!hasStopped()) await updateBarsGraph(bars);
    }
  }

  Future<void> _bitonicSort(List<Bar> bars, int low, int count, bool dir) async {
    if (count > 1) {
      int k = count ~/ 2;

      await Future.wait([
        // Sort first half in ascending order
        _bitonicSort(bars, low, k, true),
        // Sort second half in descending order
        _bitonicSort(bars, low + k, k, false),
      ]);
      // Merge the entire sequence in ascending or descending order
      await _bitonicMerge(bars, low, count, dir);
    }
  }

  Future<void> _bitonicMerge(List<Bar> bars, int low, int count, bool dir) async {
    if (count > 1) {
      int k = count ~/ 2;
      for (int i = low; i < low + k; i++) {
        if (hasStopped()) return;
        await updateBarsGraph(bars);
        if (dir == (bars[i].value > bars[i + k].value)) {
          await _swap(bars, i, i + k);
        }
      }

      await Future.wait([
        _bitonicMerge(bars, low, k, dir),
        _bitonicMerge(bars, low + k, k, dir),
      ]);
    }
  }

  Future<void> _swap(List<Bar> bars, int i, int j) async {
    await highlight([i, j], bars, color: Colors.amber);

    Bar temp = bars[i];
    bars[i] = bars[j];
    bars[j] = temp;

    await updateBarsGraph(bars);
    registerOperation();

    await undoHighlight([i, j], bars);
  }
}
