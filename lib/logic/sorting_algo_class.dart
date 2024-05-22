import 'package:algovis/logic/graphics.dart';
import 'package:algovis/widgets/bar.dart';
import 'package:flutter/material.dart';

abstract class _SortingAlgo {
  final Future<void> Function(List<Bar> newBars) updateBarsGraph;
  final void Function() registerOperation;
  final bool Function() hasStopped;

  _SortingAlgo({
    required this.updateBarsGraph,
    required this.registerOperation,
    required this.hasStopped,
  });

  Future<void> sort(List<Bar> bars);
}

abstract class SortingWithGraphics extends _SortingAlgo {
  SortingWithGraphics({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  Future<void> highLightIndexes(List<int> indexes, List<Bar> bars) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value, color: Colors.amber);
    }
    await updateBarsGraph(bars);
  }

  Future<void> unHighLightIndexes(List<int> indexes, List<Bar> bars) async {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value);
    }
    await updateBarsGraph(bars);
  }
}

class BubbleSort extends SortingWithGraphics {
  BubbleSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    await _bubbleSort(bars, bars.length);
  }

  Future<void> _bubbleSort(List<Bar> bars, int steps) async {
    if (steps <= 1) return;
    bool isSorted = true;
    for (int i = 0; i < steps - 1; i++) {
      if (hasStopped()) return;

      await highLightIndexes([i, i + 1], bars);

      if (bars[i].value > bars[i + 1].value) {
        isSorted = false;
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await unHighLightIndexes([i, i + 1], bars);
      registerOperation();
    }
    if (isSorted) return;
    await _bubbleSort(bars, steps - 1);
  }
}



// abstract class SortingAlgo {
//   late final List<Bar> bars;
//   final Future<void> Function(List<Bar> newBars) updateBarsGraph;
//   final void Function() registerOperation;
//   final bool Function() hasStopped;
//   SortingAlgo({
//     required this.updateBarsGraph,
//     required this.registerOperation,
//     required this.hasStopped,
//   });
//   Future<void> sort(List<Bar> bars);
// }
// mixin Graphics implements SortingAlgo {
//   Future<void> highLight(List<int> indexes) async {
//     for (int index in indexes) {
//       bars[index] = Bar(bars[index].value, color: Colors.amber);
//     }
//     await updateBarsGraph(bars);
//   }
//   Future<void> undoHighLight(List<int> indexes) async {
//     for (int index in indexes) {
//       bars[index] = Bar(bars[index].value);
//     }
//     await updateBarsGraph(bars);
//   }
// }
// class BubbleSort with Graphics {
//   BubbleSort({
//     required this.updateBarsGraph,
//     required this.registerOperation,
//     required this.hasStopped,
//   });
//   @override
//   late final List<Bar> bars;
//   @override
//   final Future<void> Function(List<Bar> newBars) updateBarsGraph;
//   @override
//   final void Function() registerOperation;
//   @override
//   final bool Function() hasStopped;
//   @override
//   Future<void> sort(List<Bar> bbars) async {
//     bars = bbars;
//     await _bubbleSort(bars.length);
//   }
//   Future<void> _bubbleSort(int steps) async {
//     if (steps <= 1) return;
//     bool isSorted = true;
//     for (int i = 0; i < steps - 1; i++) {
//       if (hasStopped()) return;
//       await highLight([i, i + 1]);
//       if (bars[i].value > bars[i + 1].value) {
//         isSorted = false;
//         final Bar tempBar = bars[i];
//         bars[i] = bars[i + 1];
//         bars[i + 1] = tempBar;
//       }
//       undoHighLight([i, i + 1]);
//       registerOperation();
//     }
//     if (isSorted) return;
//     await _bubbleSort(steps - 1);
//   }
// }
