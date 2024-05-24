import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class CocktailSort extends SortingAlgorithm {
  CocktailSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    bool swapped = true;
    int start = 0;
    int end = bars.length;

    while (swapped) {
      swapped = false;

      // Forward pass
      for (int i = start; i < end - 1; i++) {
        if (hasStopped()) return;
        await tempHighlight([i], bars);
        registerOperation();
        if (bars[i].value > bars[i + 1].value) {
          Bar temp = bars[i];
          bars[i] = bars[i + 1];
          bars[i + 1] = temp;
          swapped = true;
        }
      }

      if (!swapped) break;

      swapped = false;
      end--;

      // Backward pass
      for (int i = end - 1; i > start; i--) {
        if (hasStopped()) return;
        await tempHighlight([i], bars);
        registerOperation();
        if (bars[i].value < bars[i - 1].value) {
          Bar temp = bars[i];
          bars[i] = bars[i - 1];
          bars[i - 1] = temp;
          swapped = true;
        }
      }

      start++;
    }

    await updateBarsGraph(bars);
  }
}
