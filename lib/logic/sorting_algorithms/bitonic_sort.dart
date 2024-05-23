import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class BitonicSort extends SortingAlgorithm {
  BitonicSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });
  List<Bar> _bars = [];
  int _nextPowerOf2(int n) {
    int power = 1;
    while (power < n) {
      power *= 2;
    }
    return power;
  }

  Future<void> _removePadding() async {
    List<int> toBeRemoved = [];
    for (int i = 0; i < _bars.length; i++) {
      if (_bars[i].value >= 10000) {
        toBeRemoved.add(i);
      }
    }
    while (toBeRemoved.isNotEmpty) {
      _bars.removeAt(toBeRemoved.last);
      toBeRemoved.removeLast();
      await updateBarsGraph(_bars);
    }
  }

  Future<void> _addPadding() async {
    int nextPow = _nextPowerOf2(_bars.length);

    while (_bars.length < nextPow) {
      _bars.add(const Bar(10000, color: Colors.grey));
      await updateBarsGraph(_bars);
    }
  }

  @override
  Future<void> sort(List<Bar> bars) async {
    _bars = bars;

    await _addPadding();

    int n = _bars.length;

    for (int k = 2; k <= n; k *= 2) {
      for (int j = k ~/ 2; j > 0; j ~/= 2) {
        for (int i = 0; i < n; i++) {
          if (hasStopped()) {
            _removePadding();
            return;
          }
          await tempHighlight([i, j], _bars);
          registerOperation();

          int l = i ^ j;
          if (l > i) {
            if ((i & k == 0 && _bars[i].value > _bars[l].value) ||
                (i & k != 0 && _bars[i].value < _bars[l].value)) {
              Bar temp = _bars[i];
              _bars[i] = _bars[l];
              _bars[l] = temp;
              tempHighlight([i, j], _bars, color: Colors.red);
            }
          }
        }
      }
    }

    await _removePadding();
  }
}
