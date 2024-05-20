import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> radix(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  List<Bar> colorizeList(List<Bar> bl, int interaction) {
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

  List<Bar> bucketToList(List<List<Bar>> buckets) {
    List<Bar> nl = [];
    for (int i = 0; i < buckets.length; i++) {
      List<Bar> l = colorizeList(buckets[i], i);
      for (Bar b in l) {
        nl.add(b);
      }
    }
    return nl;
  }

  Future<void> update(List<List<Bar>> buckets, barsList) async {
    await updateBarsGraph(bucketToList(buckets) + barsList);
  }

  Future<void> bucketSort(int lookAt) async {
    List<List<Bar>> buckets = [[], [], [], [], [], [], [], [], [], []];
    //count
    while (bars.isNotEmpty && !hasStopped()) {
      Bar b = bars[0];

      bars[0] = Bar(bars[0].value, color: Colors.red);
      await update(buckets, bars);

      final String bValue = b.value.toString();
      final int index = bValue.length - 1 - lookAt;
      final int digit = index < 0 ? 0 : int.parse(bValue[index]);

      buckets[digit].add(b);

      bars.removeAt(0);
      update(buckets, bars);
      registerOperation();
    }
    // rebuild
    List<Bar> temp = [];
    if (bars.isNotEmpty) {
      temp = [...bars];
      bars.clear();
    }
    for (int b = 0; b < buckets.length; b++) {
      for (int q = 0; q < buckets[b].length; q++) {
        bars.add(buckets[b][q]);
        registerOperation();
      }
    }
    bars.addAll([...temp]);
  }

  Future<void> radix() async {
    int max = 0;
    for (int i = 0; i < bars.length; i++) {
      int digits = bars[i].value.toString().length;
      if (digits > max) {
        max = digits;
        registerOperation();
      }
    }

    for (int i = 0; i < max; i++) {
      await bucketSort(i);
      updateBarsGraph(bars);
      registerOperation();
    }
  }

  await radix();
  updateBarsGraph(bars);
}
