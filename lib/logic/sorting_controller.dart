import 'dart:math';
import 'package:algorithm_visualizer/logic/sorting_algorithms/bitonic_sort.dart';
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
import 'package:algorithm_visualizer/logic/sorting_algorithms/shuffle.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';

class SortingController {
  SortingController({required this.stateCallBack});

  final void Function() stateCallBack;
  final int _barHeight = 400;
  final Stopwatch _stopwatch = Stopwatch();
  final int _barsMaxQuantity = 500;
  final int _barsInitialQuantity = 100;
  final int _barsMinQuantity = 2;

  List<Bar> _bars = [];
  int _nOfOperations = 0;
  int _speed = 3;
  String _algo = 'Bubble Sort';
  bool _stopSorting = false;

  /// public
  Future<void> init() async {
    await _populate(_barsInitialQuantity);
  }

  bool hasStopped() => _stopSorting;

  Future<void> startSorting() async {
    await stopSorting();

    _nOfOperations = 0;
    _stopSorting = false;

    _stopwatch.reset();
    _stopwatch.start();

    switch (_algo.toLowerCase()) {
      case 'bubble sort':
        await bubble(_bars, _render, _incrementOperations, hasStopped);
      case 'merge sort':
        await merge(_bars, _render, _incrementOperations, hasStopped);
      case 'selection sort':
        await selection(_bars, _render, _incrementOperations, hasStopped);
      case 'insertion sort':
        await insertion(_bars, _render, _incrementOperations, hasStopped);
      case 'quick sort':
        await quick(_bars, _render, _incrementOperations, hasStopped);
      case 'shell sort':
        await shell(_bars, _render, _incrementOperations, hasStopped);
      case 'heap sort':
        await heap(_bars, _render, _incrementOperations, hasStopped);
      case 'radix sort':
        await radix(_bars, _render, _incrementOperations, hasStopped);
      case 'bitonic sort':
        await bitonic(_bars, _render, _incrementOperations, hasStopped);
      case 'gnome sort':
        await gnome(_bars, _render, _incrementOperations, hasStopped);
      case 'bogo sort':
        await bogo(_bars, _render, _incrementOperations, hasStopped);
      default:
    }

    _stopwatch.stop();

    await stopSorting();
  }

  Future<void> stopSorting() async {
    _stopSorting = true;
    await _sleep();
  }

  Future<void> startShuffling() async {
    _stopSorting = !_stopSorting;
    await shuffle(bars, _render, _incrementOperations, hasStopped);
    await stopSorting();
  }

  Future<void> reverseOrder() async {
    await _speedBypass(() async {
      await stopSorting();
      _bars = _bars.reversed.toList();
      await _render(_bars);
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

  Future<void> _populate(int quantity) async {
    quantity = max(quantity, _barsMinQuantity);

    await stopSorting();
    _bars.clear();

    double multiplier = _barHeight / quantity;

    for (int i = 1; i <= quantity; i++) {
      _bars.add(Bar((i * multiplier).toInt()));
    }
    await _render(_bars);
  }

  Future<void> _render(List<Bar> newBar) async {
    // _bars = [...newBar];
    stateCallBack();
    await _sleep();
  }

  /// getters
  String get algorithm => _algo;

  List<Bar> get bars => _bars;

  int get barsQuantity {
    if (_bars.length < _barsMinQuantity) return _barsMinQuantity;
    if (_bars.length > _barsMaxQuantity) return _barsMaxQuantity;
    return _bars.length;
  }

  int get barsMaxQuantity => _barsMaxQuantity;
  int get barsMinQuantity => _barsMinQuantity;

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

  Duration get elapsedTime => _stopwatch.elapsed;

  int get nOfOperations => _nOfOperations;

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

  double get speedValue => _speed.toDouble();

  /// setters
  set setBarsQuantity(int newQuantity) => _populate(newQuantity);

  set setAlgorithm(String algo) => _algo = algo;

  set setSpeedFromValue(int newSpeed) => _speed = newSpeed;
}
