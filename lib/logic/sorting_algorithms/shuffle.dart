import 'dart:math';
import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class Shuffle extends SortingAlgorithm {
  Shuffle({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    for (int i = 1; i < bars.length; i++) {
      if (hasStopped()) return;

      int rnd = Random().nextInt(i);
      Bar temp = bars[rnd];
      bars[rnd] = bars[i];
      bars[i] = temp;

      await tempHighlight([i, rnd], bars);
      registerOperation();
    }
  }
}
