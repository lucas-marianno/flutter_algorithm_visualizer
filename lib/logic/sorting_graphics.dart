import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

abstract class SortingGraphics {
  final Future<void> Function(List<Bar> newBars) updateBarsGraph;
  SortingGraphics({
    required this.updateBarsGraph,
  });

  List<Bar> colorize(List<Bar> bars, {Color? color}) {
    List<Bar> colorized = [];
    for (Bar bar in bars) {
      colorized.add(Bar(bar.value, color: color));
    }
    return colorized;
  }

  Future<void> tempHighlight(
    List<int> indexes,
    List<Bar> bars, {
    Color? color = Colors.amber,
  }) async {
    for (int i in indexes) {
      bars[i] = Bar(bars[i].value, color: color);
    }
    await updateBarsGraph(bars);
    for (int i in indexes) {
      bars[i] = Bar(bars[i].value);
    }
    updateBarsGraph(bars);
  }

  Future<void> highlight(
    List<int> indexes,
    List<Bar> bars, {
    Color? color = Colors.amber,
  }) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value, color: color);
    }
    await updateBarsGraph(bars);
  }

  Future<void> undoHighlight(List<int> indexes, List<Bar> bars) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value);
    }
    updateBarsGraph(bars);
  }
}
