import 'package:algorithm_visualizer/logic/sorting_algorithms/bogo_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/insertion_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/merge_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/quick_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/selection_sort.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

class SortingControllerState extends ChangeNotifier {
  /// singleton
  static final SortingControllerState _instance = SortingControllerState._internal();
  SortingControllerState._internal();
  factory SortingControllerState() => _instance;

  bool _stopSorting = false;

  set stopSorting(bool stopSorting) {
    _stopSorting = stopSorting;
    notifyListeners();
  }

  bool get hasStopped => _stopSorting;
}

class SortingController {
  final void Function(List<Bar> newBar) updateBarsCallback;
  final int barHeight = 400;

  SortingController({
    required this.bars,
    required this.barsQuantity,
    required this.updateBarsCallback,
  });

  List<Bar> bars;
  int barsQuantity = 100;
  int _nOfOperations = 0;
  int _speed = 3;
  String _algo = 'bubble sort';

  /// public
  Future<void> init() async {
    await _populate(barHeight);
  }

  Future<void> startSorting() async {
    await stopSorting();

    _nOfOperations = 0;
    SortingControllerState().stopSorting = false;

    switch (_algo.toLowerCase()) {
      case 'bubble sort':
        await bubble(bars, _updateBarsGraph, _incrementOperations);
      case 'merge sort':
        await merge(bars, _updateBarsGraph, _incrementOperations);
      case 'selection sort':
        await selectionSort(bars, _updateBarsGraph, _incrementOperations);
      case 'insertion sort':
        await insertionSort(bars, _updateBarsGraph, _incrementOperations);
      case 'quick sort':
        await quick(bars, _updateBarsGraph, _incrementOperations);
      case 'bogo sort':
        await bogoSort(bars, _updateBarsGraph, _incrementOperations);
      default:
    }
    await stopSorting();
  }

  Future<void> stopSorting() async {
    await _speedBypass(() async {
      SortingControllerState().stopSorting = true;
      await _sleep();
    });
    //TODO: use provider to manage state and stop the sorting algorithm at once
  }

  Future<void> randomize() async {
    _speedBypass(() async {
      await stopSorting();
      await _populate(barHeight);
      bars.shuffle();
      await _updateBarsGraph(bars);
    });
  }

  Future<void> reverseOrder() async {
    _speedBypass(() async {
      await stopSorting();
      bars = bars.reversed.toList();
      await _updateBarsGraph(bars);
    });
  }

  /// private
  void _incrementOperations() {
    if (!SortingControllerState().hasStopped) _nOfOperations++;
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
    await _speedBypass(() async {
      await stopSorting();
      bars.clear();

      double multiplier = barHeight / barsQuantity;

      for (int i = 1; i <= barsQuantity; i++) {
        bars.add(Bar((i * multiplier).toInt()));
      }
      await _updateBarsGraph(bars);
    });
  }

  Future<void> _updateBarsGraph(List<Bar> newBar) async {
    updateBarsCallback(newBar);
    await _sleep();
    // if (!SortingControllerState().hasStopped) _nOfOperations++;
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

  /// setters
  set setBarsQuantity(int quantity) {
    _speedBypass(() async {
      barsQuantity = quantity;
      await _populate(barHeight);
    });
  }

  set setAlgorithm(String algo) => _algo = algo;

  set setSpeedFromValue(int newSpeed) => _speed = newSpeed;
}
