import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> radixSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
  void Function() registerOperation,
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

  Future<void> update(List<List<Bar>> buckets, barsList) async {
    List<Bar> nl = [];
    for (int i = 0; i < buckets.length; i++) {
      List<Bar> l = colorizeList(buckets[i], i);
      for (Bar b in l) {
        nl.add(b);
      }
    }
    bars = nl + barsList;
    await updateBarsGraph(bars);
  }

  Future<List<Bar>> countSort(List<Bar> barsList, int lookAt) async {
    List<List<Bar>> buckets = [[], [], [], [], [], [], [], [], [], []];
    //count
    while (barsList.isNotEmpty) {
      Bar b = barsList[0];

      barsList[0] = Bar(barsList[0].value, color: Colors.red);
      await update(buckets, barsList);

      String bValue = b.value.toString();
      int digit =
          (bValue.length - 1 - lookAt) < 0 ? 0 : int.parse(bValue[bValue.length - 1 - lookAt]);

      buckets[digit].add(b);

      barsList.removeAt(0);
      update(buckets, barsList);
      registerOperation();
    }
    // rebuild
    for (int b = 0; b < buckets.length; b++) {
      for (int q = 0; q < buckets[b].length; q++) {
        barsList.add(buckets[b][q]);
        registerOperation();
      }
    }
    return barsList;
  }

  Future<List<Bar>> radix(List<Bar> list) async {
    int max = 0;
    for (int i = 0; i < list.length; i++) {
      int digits = list[i].value.toString().length;
      if (digits > max) {
        max = digits;
        registerOperation();
      }
    }

    for (int i = 0; i < max; i++) {
      list = await countSort(list, i);
      registerOperation();
    }
    return list;
  }

  bars = await radix(bars);
  updateBarsGraph(bars);
}
