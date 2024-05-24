import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

class RadixSort extends SortingAlgorithm {
  RadixSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });
  List<Bar> _bars = [];

  @override
  Future<void> sort(List<Bar> bars) async {
    _bars = bars;
    await _radix();
    await updateBarsGraph(bars);
  }

  Future<void> _radix() async {
    int max = 0;
    for (int i = 0; i < _bars.length; i++) {
      int digits = _bars[i].value.toString().length;
      if (digits > max) {
        max = digits;
        registerOperation();
      }
    }

    for (int i = 0; i < max; i++) {
      await _bucketSort(i);
      updateBarsGraph(_bars);
      registerOperation();
    }
  }

  Future<void> _bucketSort(int lookAt) async {
    List<List<Bar>> buckets = [[], [], [], [], [], [], [], [], [], []];
    //count
    while (_bars.isNotEmpty && !hasStopped()) {
      Bar b = _bars[0];

      _bars[0] = Bar(_bars[0].value, color: Colors.red);
      await _update(buckets, _bars);

      final String bValue = b.value.toString();
      final int index = bValue.length - 1 - lookAt;
      final int digit = index < 0 ? 0 : int.parse(bValue[index]);

      buckets[digit].add(b);

      _bars.removeAt(0);
      _update(buckets, _bars);
      registerOperation();
    }
    // rebuild
    List<Bar> temp = [];
    if (_bars.isNotEmpty) {
      temp = [..._bars];
      _bars.clear();
    }
    for (int b = 0; b < buckets.length; b++) {
      for (int q = 0; q < buckets[b].length; q++) {
        _bars.add(buckets[b][q]);
        registerOperation();
      }
    }
    _bars.addAll([...temp]);
  }

  List<Bar> _bucketToList(List<List<Bar>> buckets) {
    List<Bar> nl = [];
    for (int i = 0; i < buckets.length; i++) {
      List<Bar> l = _colorizeList(buckets[i], i);
      for (Bar b in l) {
        nl.add(b);
      }
    }
    return nl;
  }

  List<Bar> _colorizeList(List<Bar> bl, int interaction) {
    List<Bar> nl = [];
    int colorValue = 150 * interaction % 256;
    for (Bar b in bl) {
      nl.add(Bar(b.value, color: Color.fromARGB(255, colorValue, colorValue, colorValue)));
    }
    if (nl.isNotEmpty) {
      nl[nl.length - 1] = Bar(nl[nl.length - 1].value, color: Colors.amber);
    }
    return nl;
  }

  Future<void> _update(List<List<Bar>> buckets, barsList) async {
    await updateBarsGraph(_bucketToList(buckets) + barsList);
  }
}
