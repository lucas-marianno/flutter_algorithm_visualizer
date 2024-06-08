import 'package:algovis/logic/sorting_algorithms/bitonic_sort.dart';
import 'package:algovis/logic/sorting_algorithms/bitonic_sort_parallel.dart';
import 'package:algovis/logic/sorting_algorithms/bogo_sort.dart';
import 'package:algovis/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algovis/logic/sorting_algorithms/cocktail_shaker_sort.dart';
import 'package:algovis/logic/sorting_algorithms/gnome_sort.dart';
import 'package:algovis/logic/sorting_algorithms/heap_sort.dart';
import 'package:algovis/logic/sorting_algorithms/insertion_sort.dart';
import 'package:algovis/logic/sorting_algorithms/merge_sort.dart';
import 'package:algovis/logic/sorting_algorithms/quick_sort.dart';
import 'package:algovis/logic/sorting_algorithms/radix_sort.dart';
import 'package:algovis/logic/sorting_algorithms/reverse.dart';
import 'package:algovis/logic/sorting_algorithms/selection_sort.dart';
import 'package:algovis/logic/sorting_algorithm.dart';
import 'package:algovis/logic/sorting_algorithms/shell_sort.dart';
import 'package:algovis/logic/sorting_algorithms/shuffle.dart';
import 'package:algovis/widgets/bar.dart';

class AlgorithmController {
  final Future<void> Function(List<Bar> newBars) updateBarsGraph;
  final void Function() registerOperation;
  final bool Function() hasStopped;
  AlgorithmController({
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
  late final SortingAlgorithm _shell;
  late final SortingAlgorithm _merge;
  late final SortingAlgorithm _quick;
  late final SortingAlgorithm _heap;
  late final SortingAlgorithm _radix;
  late final SortingAlgorithm _cocktail;
  late final SortingAlgorithm _gnome;
  late final SortingAlgorithm _bogo;
  late final SortingAlgorithm _parallelBitonic;
  late final SortingAlgorithm _shuffle;
  late final SortingAlgorithm _reverse;

  _setters() {
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
    _parallelBitonic = ParallelBitonicSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _shell = ShellSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _merge = MergeSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _quick = QuickSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _heap = HeapSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _radix = RadixSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _cocktail = CocktailSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _gnome = GnomeSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _bogo = BogoSort(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _shuffle = Shuffle(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
    _reverse = Reverse(
      updateBarsGraph: updateBarsGraph,
      registerOperation: registerOperation,
      hasStopped: hasStopped,
    );
  }

  void init() {
    _setters();
    _algorithms = {
      'bubble sort': _bubble,
      'selection sort': _selection,
      'insertion sort': _insertion,
      'bitonic sort': _bitonic,
      'bitonic sort (parallel)': _parallelBitonic,
      'shell sort': _shell,
      'merge sort': _merge,
      'quick sort': _quick,
      'heap sort': _heap,
      'radix sort': _radix,
      'cocktail shaker sort': _cocktail,
      'gnome sort': _gnome,
      'bogo sort': _bogo,
    };

    _hasInitialized = true;
  }

  Future<void> sort(String algorithm, List<Bar> bars) async {
    assert(_hasInitialized, '$AlgorithmController must be initialized before use.');
    algorithm = algorithm.toLowerCase();
    if (!_algorithms.containsKey(algorithm)) throw '$algorithm hasn\'t been implemented.';

    await _algorithms[algorithm]!.sort(bars);
  }

  Future<void> shuffle(List<Bar> bars) async => await _shuffle.sort(bars);
  Future<void> reverse(List<Bar> bars) async => await _reverse.sort(bars);
}
