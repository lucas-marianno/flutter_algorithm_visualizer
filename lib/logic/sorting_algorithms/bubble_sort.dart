import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class BubbleSort extends SortingAlgorithm {
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

      await highlight([i, i + 1], bars);

      if (bars[i].value > bars[i + 1].value) {
        isSorted = false;
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await undoHighlight([i, i + 1], bars);
      registerOperation();
    }
    if (isSorted) return;
    await _bubbleSort(bars, steps - 1);
  }
}
