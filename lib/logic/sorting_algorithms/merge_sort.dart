import 'package:algorithm_visualizer/logic/sorting_speed_controller.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> merge(List<Bar> bars, Future<void> Function(List<Bar> newBars) updateBarsGraph) async {
  //graphics
  List<Bar> colorize(List<Bar> barsList, {Color? color}) {
    List<Bar> colorized = [];
    for (Bar bar in barsList) {
      colorized.add(Bar(bar.value, color: color));
    }
    colorized[0] = Bar(colorized[0].value, color: Colors.amber);
    return colorized;
  }

  Bar colorizeBar(Bar b) => Bar(b.value, color: Colors.amber);

  Future<void> update(
    int startIndex,
    int endIndex,
    List<Bar> merged,
    List<Bar> left,
    List<Bar> right,
  ) async {
    bars.replaceRange(startIndex, endIndex, merged + left + right);
    await updateBarsGraph(bars);
  }

  //logic
  //startIndex and endIndex only use is to accurately display graphics
  Future<List<Bar>> mergeSort(List<Bar> barsList, int startIndex, int endIndex) async {
    //logic
    if (barsList.length == 1) return barsList;
    if (SortingControllerState().hasStopped == true) return barsList;

    //optmized version
    //breaks the function if the array is already sorted
    for (int i = 0; i < barsList.length - 1; i++) {
      if (barsList[i].value > barsList[i + 1].value) {
        break;
      } else if (i == barsList.length - 2) {
        return barsList;
      }
    }

    //logic
    List<Bar> merged = [];
    List<Bar> left = barsList.sublist(0, barsList.length ~/ 2);
    List<Bar> right = barsList.sublist(barsList.length ~/ 2);

    //graphics
    left = colorize(left, color: const Color.fromARGB(255, 68, 110, 131));
    right = colorize(right, color: Colors.grey);
    await update(startIndex, endIndex, merged, left, right);

    //logic
    //dividing the array (and sorting recursively)
    left = await mergeSort(left, 0 + startIndex, barsList.length ~/ 2 + startIndex);
    right = await mergeSort(right, barsList.length ~/ 2 + startIndex, barsList.length + startIndex);

    //merge part
    while (left.isNotEmpty && right.isNotEmpty) {
      //graphics
      if (SortingControllerState().hasStopped == true) break;
      left[0] = colorizeBar(left[0]);
      right[0] = colorizeBar(right[0]);
      await update(startIndex, endIndex, merged, left, right);

      //logic
      if (left[0].value < right[0].value) {
        merged.add(left[0]);
        left.removeAt(0);
      } else {
        merged.add(right[0]);
        right.removeAt(0);
      }
      //graphics
      update(startIndex, endIndex, merged, left, right);
      merged.last = Bar(merged.last.value);
    }

    // logic
    // merge remainder
    while (left.isNotEmpty) {
      left[0] = colorizeBar(left[0]);
      merged.add(left[0]);
      left.removeAt(0);
      await update(startIndex, endIndex, merged, left, right);
    }
    while (right.isNotEmpty) {
      right[0] = colorizeBar(right[0]);
      merged.add(right[0]);
      right.removeAt(0);
      await update(startIndex, endIndex, merged, left, right);
    }

    //graphics
    merged = colorize(merged);
    await update(startIndex, endIndex, merged, left, right);

    //logic
    return merged;
  }

  await updateBarsGraph(await mergeSort(bars, 0, bars.length));
}
