import 'package:algorithm_visualizer/logic/sorting_algorithms/bogo_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/gnome_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/heap_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/insertion_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/merge_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/quick_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/radix_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/selection_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/shell_sort.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';

class SortingController {
  final void Function(List<Bar> newBar) updateBarsCallback;
  final int barHeight = 400;
  final Stopwatch _stopwatch = Stopwatch();
  List<Bar> bars;
  int barsQuantity;
  int _nOfOperations = 0;
  int _speed = 3;
  String _algo = 'Bubble Sort';
  bool _stopSorting = false;
  SortingController({
    required this.bars,
    required this.barsQuantity,
    required this.updateBarsCallback,
  });

  /// public
  Future<void> init() async {
    await _populate(barHeight);
  }

  Future<void> startSorting() async {
    await stopSort();

    _nOfOperations = 0;
    _stopSorting = false;

    _stopwatch.reset();
    _stopwatch.start();

    switch (_algo.toLowerCase()) {
      case 'bubble sort':
        await bubble(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'merge sort':
        await merge(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'selection sort':
        await selectionSort(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'insertion sort':
        await insertionSort(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'quick sort':
        await quick(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'shell sort':
        await shell(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'heap sort':
        await heap(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'radix sort':
        await radixSort(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'gnome sort':
        await gnomeSort(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      case 'bogo sort':
        await bogoSort(bars, _updateBarsGraph, _incrementOperations, hasStopped);
      default:
    }

    _stopwatch.stop();

    await stopSort();
  }

  Future<void> stopSort() async {
    _stopSorting = true;
    await _sleep();
  }

  Future<void> randomize() async {
    await _speedBypass(() async {
      await stopSort();
      await _populate(barHeight);
      bars.shuffle();
      await _updateBarsGraph(bars);
    });
  }

  Future<void> reverseOrder() async {
    await _speedBypass(() async {
      await stopSort();
      bars = bars.reversed.toList();
      await _updateBarsGraph(bars);
    });
  }

  /// private
  void _incrementOperations() {
    if (!_stopSorting) _nOfOperations++;
  }

  Future<void> _sleep() async {
    switch (_speed) {
      case 1:
        await Future.delayed(const Duration(milliseconds: 1000));
        return;
      case 2:
        await Future.delayed(const Duration(milliseconds: 100));
        return;
      case 3:
        await Future.delayed(const Duration(milliseconds: 1));
        return;
      case 4:
        // instant
        return;
      default:
        return;
    }
  }

  Future<void> _speedBypass(Future<void> Function() function) async {
    int temp = _speed;
    _speed = 4;
    await function();
    _speed = temp;
  }

  Future<void> _populate(int barHeight) async {
    await stopSort();
    bars.clear();

    double multiplier = barHeight / barsQuantity;

    for (int i = 1; i <= barsQuantity; i++) {
      bars.add(Bar((i * multiplier).toInt()));
    }
    await _updateBarsGraph(bars);
  }

  Future<void> _updateBarsGraph(List<Bar> newBar) async {
    updateBarsCallback(newBar);
    await _sleep();
  }

  /// getters
  int get delayMs {
    switch (_speed) {
      case 1:
        return 1000;
      case 2:
        return 100;
      case 3:
        return 1;
      case 4:
        return 0;
      default:
        return 9999999999;
    }
  }

  String get speedLabel {
    switch (_speed) {
      case 1:
        return 'slow af';
      case 2:
        return 'slow';
      case 3:
        return 'fast';
      case 4:
        return 'instant';
      default:
        return '';
    }
  }

  String get algorithm => _algo;

  double get speedValue => _speed.toDouble();

  int get nOfOperations => _nOfOperations;

  List<Bar> get getBars => bars;

  Duration get elapsedTime => _stopwatch.elapsed;

  bool hasStopped() => _stopSorting;

  set setBarsQuantity(int quantity) {
    _speedBypass(() async {
      barsQuantity = quantity;
      await _populate(barHeight);
    });
  }

  set setAlgorithm(String algo) => _algo = algo;

  set setSpeedFromValue(int newSpeed) => _speed = newSpeed;
}
