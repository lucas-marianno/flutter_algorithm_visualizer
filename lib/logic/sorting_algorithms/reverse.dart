import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class Reverse extends SortingAlgorithm {
  Reverse({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    int start = 0;
    int end = bars.length - 1;

    while (start < end && !hasStopped()) {
      await tempHighlight([start, end], bars);
      Bar temp = bars[start];
      bars[start] = bars[end];
      bars[end] = temp;
      start++;
      end--;
    }
    await updateBarsGraph(bars);
  }
}
