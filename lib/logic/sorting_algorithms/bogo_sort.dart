import 'package:algorithm_visualizer/logic/sorting_algorithms/shuffle.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';

Future<void> bogo(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
  bool isSorted() {
    for (int i = 1; i < bars.length; i++) {
      if (bars[i - 1].value > bars[i].value) {
        return false;
      }
    }
    return true;
  }

  while (!isSorted() && !hasStopped()) {
    await shuffle(bars, updateBarsGraph, registerOperation, hasStopped);

    //just in case user sets to instant (avoids overflow)
    await Future.delayed(const Duration(milliseconds: 1));
    registerOperation();
  }
}
