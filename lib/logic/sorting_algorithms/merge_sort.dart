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
    return colorized;
  }

  Future<void> updateGraphics(
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

    bars.replaceRange(startIndex, endIndex, merged + left + right);
    await updateBarsGraph(bars);
  }

  //logic
  //startIndex and endIndex only use is to accurately display graphics
  Future<List<Bar>> mergeSort(List<Bar> barsList, int startIndex, int endIndex) async {
    if (barsList.length == 1) return barsList;

    //breaks the loop if the array is already partially sorted or sorted
    for (int i = 0; i < barsList.length - 1; i++) {
      if (SortingControllerState().hasStopped) return barsList;
      updateBarsGraph(bars);
      if (barsList[i].value > barsList[i + 1].value) {
        break;
      } else if (i == barsList.length - 2) {
        return barsList;
      }
    }

    List<Bar> merged = [];
    List<Bar> left = barsList.sublist(0, barsList.length ~/ 2);
    List<Bar> right = barsList.sublist(barsList.length ~/ 2);

    await updateGraphics(startIndex, endIndex, merged, left, right);

    //divide part
    left = await mergeSort(left, 0 + startIndex, barsList.length ~/ 2 + startIndex);
    right = await mergeSort(right, barsList.length ~/ 2 + startIndex, barsList.length + startIndex);

    //sort part
    while (left.isNotEmpty && right.isNotEmpty) {
      if (SortingControllerState().hasStopped) return barsList;
      await updateGraphics(startIndex, endIndex, merged, left, right, highlightFirst: true);

      if (left[0].value < right[0].value) {
        merged.add(left[0]);
        left.removeAt(0);
      } else {
        merged.add(right[0]);
        right.removeAt(0);
      }
      updateGraphics(startIndex, endIndex, merged, left, right);
    }

    while (left.isNotEmpty) {
      merged.add(left[0]);
      left.removeAt(0);
      await updateGraphics(startIndex, endIndex, merged, left, right);
    }
    while (right.isNotEmpty) {
      merged.add(right[0]);
      right.removeAt(0);
      await updateGraphics(startIndex, endIndex, merged, left, right);
    }

    await updateGraphics(startIndex, endIndex, merged, left, right);
    return merged;
  }

  bars = await mergeSort(bars, 0, bars.length);
  await updateBarsGraph(colorize(bars));
}
