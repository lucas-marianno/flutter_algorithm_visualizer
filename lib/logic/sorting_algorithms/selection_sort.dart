import 'package:algorithm_visualizer/logic/sorting_speed_controller.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> selectionSort(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
) async {
  //logic
  List<Bar> sorted = [];

  //graphics
  Future<void> update(List<Bar> unSorted) async {
    await updateBarsGraph(sorted + unSorted);
  }

  Future<List<Bar>> sort(List<Bar> unSorted) async {
    //logic
    if (unSorted.isEmpty) return sorted;

    //logic
    Bar smallest = unSorted[0];
    // graphics
    int smallestIndex = 0;

    for (int i = 1; i < unSorted.length; i++) {
      //graphics
      if (SortingControllerState().hasStopped == true) return sorted + unSorted;
      unSorted[i] = Bar(unSorted[i].value, color: Colors.amber);
      await update(unSorted);
      unSorted[i] = Bar(unSorted[i].value);
      await update(unSorted);

      //logic
      if (unSorted[i].value < smallest.value) {
        unSorted[smallestIndex] = Bar(smallest.value);

        unSorted[i] = Bar(unSorted[i].value, color: Colors.red);
        await update(unSorted);
        smallest = unSorted[i];
        smallestIndex = i;
      }
    }
    sorted.add(Bar(smallest.value));
    unSorted.remove(smallest);
    return await sort(unSorted);
  }

  await updateBarsGraph(await sort(bars));
}
