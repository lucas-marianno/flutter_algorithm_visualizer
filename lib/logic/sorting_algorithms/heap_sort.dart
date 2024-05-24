import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class HeapSort extends SortingAlgorithm {
  HeapSort({
    required super.updateBarsGraph,
    required super.registerOperation,
    required super.hasStopped,
  });

  @override
  Future<void> sort(List<Bar> bars) async {
    if (hasStopped()) return;
    int n = bars.length;

    // Build heap (rearrange array)
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      if (hasStopped()) return;
      _heapify(bars, n, i);
      await tempHighlight([i], bars);
      registerOperation();
    }

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
      if (hasStopped()) return;
      // Move current root to end
      Bar temp = bars[0];
      bars[0] = bars[i];
      bars[i] = temp;

      // call max heapify on the reduced heap
      await _heapify(bars, i, 0);
      await tempHighlight([i], bars);
      registerOperation();
    }
    await updateBarsGraph(bars);
  }

  Future<void> _heapify(List<Bar> bars, int n, int i) async {
    if (hasStopped()) return;
    await tempHighlight([i], bars);

    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    // If left child is larger than root
    if (left < n && bars[left].value > bars[largest].value) {
      largest = left;
    }

    // If right child is larger than largest so far
    if (right < n && bars[right].value > bars[largest].value) {
      largest = right;
    }

    // If largest is not root
    if (largest != i) {
      Bar swap = bars[i];
      bars[i] = bars[largest];
      bars[largest] = swap;
      // Recursively heapify the affected sub-tree
      await _heapify(bars, n, largest);
    }
    registerOperation();
  }
}
