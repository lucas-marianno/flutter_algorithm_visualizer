import 'package:algovis/logic/sorting_algorithms/bitonic_sort.dart';
import 'package:algovis/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algovis/logic/sorting_algorithms/insertion_sort.dart';
import 'package:algovis/logic/sorting_algorithms/merge_sort.dart';
import 'package:algovis/logic/sorting_algorithms/selection_sort.dart';
import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/widgets/bar.dart';

class Sorter {
  final Future<void> Function(List<Bar> newBars) updateBarsGraph;
  final void Function() registerOperation;
  final bool Function() hasStopped;
  Sorter({
    required this.updateBarsGraph,
    required this.registerOperation,
    required this.hasStopped,
  });

  bool _hasInitialized = false;

  late final Map<String, SortingAlgorithm> _algorithms;

  late final SortingAlgorithm _bubble;
  late final SortingAlgorithm _selection;
  late final SortingAlgorithm _insertion;
  late final SortingAlgorithm _bitonic;
  late final SortingAlgorithm _merge;

  void init() {
    _bubble = BubbleSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _selection = SelectionSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _insertion = InsertionSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _bitonic = BitonicSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _merge = MergeSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );

    _algorithms = {
      'bubble sort': _bubble,
      'selection sort': _selection,
      'insertion sort': _insertion,
      'bitonic sort': _bitonic,
      // 'shell sort': shell,
      'merge sort': _merge,
      // 'quick sort': quick,
      // 'heap sort': heap,
      // 'radix sort': radix,
      // 'cocktail shaker sort': cocktail,
      // 'gnome sort': gnome,
      // 'bogo sort': bogo,
      // 'bitonic sort (parallel)': parallelBitonic,
    };

    _hasInitialized = true;
  }

  Future<void> sort(String algorithm, List<Bar> bars) async {
    assert(_hasInitialized, '$Sorter must be initialized before use.');
    if (!_algorithms.containsKey(algorithm)) throw '$algorithm hasn\'t been implemented.';

    await _algorithms[algorithm]!.sort(bars);
  }
}
