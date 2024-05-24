import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/logic/sorting_algorithms/shuffle.dart';
import 'package:algovis/widgets/bar.dart';

class BogoSort extends SortingAlgorithm {
  BogoSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    while (!_isSorted(bars) && !hasStopped()) {
      await shuffle(bars, updateBarsGraph, registerOperation, hasStopped);

      //just in case user sets to instant (avoids overflow)
      await Future.delayed(const Duration(microseconds: 1));
      registerOperation();
    }
  }

  bool _isSorted(List<Bar> bars) {
    for (int i = 1; i < bars.length; i++) {
      if (bars[i - 1].value > bars[i].value) {
        return false;
      }
    }
    return true;
  }
}
