import 'package:algorithm_visualizer/logic/sorting_speed_controller.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

// Future<void> quick(List<Bar> bars, Future<void> Function(List<Bar> newBars) updateBarsGraph) async {
//   if (SortingControllerState().hasStopped) return;
//   List<Bar> colorize(List<Bar> barsList, {Color? color}) {
//     List<Bar> colorized = [];
//     for (Bar bar in barsList) {
//       colorized.add(Bar(bar.value, color: color));
//     }
//     return colorized;
//   }
//   Future<List<Bar>> sort(List<Bar> barsList, int startingIndex) async {
//     if (SortingControllerState().hasStopped) return barsList;
//     if (barsList.length <= 1) return barsList;
//
//     List<Bar> smaller = [];
//     List<Bar> equal = [];
//     List<Bar> larger = [];
//
//     Bar pivot = Bar(barsList[barsList.length ~/ 2].value, color: Colors.red);
//
//     barsList[barsList.length ~/ 2] = pivot;
//
//     // await updateBarsGraph(barsList);
//
//     barsList.removeAt(barsList.length ~/ 2);
//     equal.add(pivot);
//
//     List<Bar> unsorted = bars.sublist(equal.length + barsList.length - 2);
//
//     await updateBarsGraph(equal + barsList + unsorted);
//
//     while (barsList.isNotEmpty) {
//       if (SortingControllerState().hasStopped) return barsList;
//       barsList[0] = Bar(barsList[0].value, color: Colors.amber);
//
//       await updateBarsGraph(smaller + equal + barsList + larger + unsorted);
//
//       if (barsList[0].value < pivot.value) {
//         smaller.add(barsList[0]);
//       } else if (barsList[0].value > pivot.value) {
//         larger.add(barsList[0]);
//       } else {
//         equal.add(barsList[0]);
//       }
//
//       barsList.removeAt(0);
//       smaller = colorize(smaller);
//       larger = colorize(larger);
//
//       await updateBarsGraph(smaller + equal + barsList + larger + unsorted);
//     }
//     await updateBarsGraph(smaller + equal + barsList + larger + unsorted);
//
//     smaller = await sort(colorize(smaller), 0);
//     larger = await sort(colorize(larger), smaller.length + equal.length);
//     barsList = smaller + equal + larger;
//     return barsList;
//   }
//
//   await updateBarsGraph(await sort(bars, 0));
// }

Future<void> quick(List<Bar> bars, Future<void> Function(List<Bar> newBars) updateBarsGraph) async {
  if (SortingControllerState().hasStopped) return;

  meh() async {
    await updateBarsGraph(bars);
  }

  Future<List<Bar>> sort(
    List<Bar> barsList,
  ) async {
    if (SortingControllerState().hasStopped) return barsList;
    if (barsList.length <= 1) return barsList;

    List<Bar> smaller = [];
    List<Bar> equal = [];
    List<Bar> larger = [];

    Bar pivot = barsList[barsList.length ~/ 2];

    barsList[barsList.length ~/ 2] = pivot;

    barsList.removeAt(barsList.length ~/ 2);
    equal.add(pivot);

    while (barsList.isNotEmpty) {
      if (SortingControllerState().hasStopped) return barsList;
      await meh();
      if (barsList[0].value < pivot.value) {
        smaller.add(barsList[0]);
      } else if (barsList[0].value > pivot.value) {
        larger.add(barsList[0]);
      } else {
        equal.add(barsList[0]);
      }

      barsList.removeAt(0);
    }

    smaller = await sort(smaller);
    larger = await sort(larger);
    barsList = smaller + equal + larger;
    return barsList;
  }

  await updateBarsGraph(await sort([...bars]));
}
