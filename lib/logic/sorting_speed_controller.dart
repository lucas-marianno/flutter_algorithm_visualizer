import 'package:algorithm_visualizer/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/merge_sort.dart';
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
    required this.updateBarsCallback,
  });
  final List<Bar> bars;
  final Future<void> Function(List<Bar> newBar) updateBarsCallback;

  int _speed = 3;
  String _algo = 'bubble sort';

  Future<void> _updateBarsGraph(List<Bar> newBar) async {
    await sleep();
    updateBarsCallback(bars);
  }

  void randomize() {
    stopSorting();
    bars.shuffle();
    _updateBarsGraph(bars);
  }

  void startSorting() {
    stopSorting();

    SortingControllerState().stopSorting = false;

    switch (_algo.toLowerCase()) {
      case 'bubble sort':
        bubble(bars, _updateBarsGraph);
      case 'merge sort':
        merge(bars, _updateBarsGraph);
      default:
    }
  }

  void stopSorting() {
    SortingControllerState().stopSorting = true;
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

  // bool get hasStopped => _stopSorting;

  set setAlgorithm(String algo) => _algo = algo;

  set setSpeedFromValue(int newSpeed) => _speed = newSpeed;
}
