import 'package:algorithm_visualizer/logic/sorting_algorithms/bogo_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/insertion_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/merge_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/selection_sort.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

class SortingControllerState extends ChangeNotifier {
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
  SortingController({
    required this.bars,
    required this.barsQuantity,
    required this.updateBarsCallback,
  });
  final Future<void> Function(List<Bar> newBar) updateBarsCallback;
  final int barHeight = 400;

  List<Bar> bars;
  int barsQuantity = 100;
  int _nOfOperations = 0;
  int _speed = 3;
  String _algo = 'bubble sort';

  Future<void> _updateBarsGraph(List<Bar> newBar) async {
    await sleep();
    updateBarsCallback(newBar);
    if (!SortingControllerState().hasStopped) _nOfOperations++;
  }

  void randomize() async {
    await stopSorting();
    bars.shuffle();
    updateBarsCallback(bars);
  }

  void startSorting() async {
    await stopSorting();

    _nOfOperations = 0;
    SortingControllerState().stopSorting = false;

    switch (_algo.toLowerCase()) {
      case 'bubble sort':
        await bubble(bars, _updateBarsGraph);
      case 'merge sort':
        await merge(bars, _updateBarsGraph);
      case 'selection sort':
        await selectionSort(bars, _updateBarsGraph);
      case 'insertion sort':
        await insertionSort(bars, _updateBarsGraph);
      case 'bogo sort':
        await bogoSort(bars, _updateBarsGraph);
      default:
    }
    await stopSorting();
  }

  Future<void> stopSorting() async {
    SortingControllerState().stopSorting = true;
    await sleep();
    //TODO: use provider to manage state and stop the sorting algorithm at once
  }

  Future<void> sleep() async {
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

  void init() {
    _populate(barHeight);
  }

  Future<void> _populate(int barHeight) async {
    await stopSorting();
    bars.clear();

    double multiplier = barHeight / barsQuantity;

    for (int i = 1; i <= barsQuantity; i++) {
      bars.add(Bar((i * multiplier).toInt()));
    }
  }

  String get algorithm => _algo;

  double get speedValue => _speed.toDouble();

  int get nOfOperations => _nOfOperations;

  List<Bar> get getBars => bars;

  set setBarsQuantity(int quantity) {
    barsQuantity = quantity;
    _populate(barHeight);
  }

  set setAlgorithm(String algo) => _algo = algo;

  set setSpeedFromValue(int newSpeed) => _speed = newSpeed;
}
