import 'dart:math';
import 'package:algovis/logic/sorter.dart';
import 'package:algovis/widgets/bar.dart';

class SortingController {
  SortingController({required this.stateCallBack});

  final void Function() stateCallBack;
  final Stopwatch _stopwatch = Stopwatch();

  late final Sorter _sorter;

  static const int _barMaxHeight = 9999;
  static const int _barsInitialQuantity = 100;
  static const int _barsMaxQuantity = 999;
  static const int _barsMinQuantity = 2;

  List<Bar> _bars = [];
  int _nOfOperations = 0;
  int _speed = 3;
  String _algo = 'bubble sort';
  bool _stopSorting = true;

  /// public
  Future<void> init() async {
    _sorter = Sorter(
      updateBarsGraph: _render,
      registerOperation: _incrementOperations,
      hasStopped: hasStopped,
    );

    _sorter.init();

    await _populate(_barsInitialQuantity);
  }

  bool hasStopped() => _stopSorting;

  Future<void> startSorting() async {
    await stopSorting();

    _nOfOperations = 0;
    _stopSorting = false;

    _stopwatch.reset();
    _stopwatch.start();

    await _sorter.sort(_algo, _bars);

    _stopwatch.stop();

    await stopSorting();
  }

  Future<void> stopSorting() async {
    _stopSorting = true;
    await _sleep();
  }

  Future<void> startShuffling() async {
    _nOfOperations = 0;
    _stopSorting = !_stopSorting;
    await _sorter.shuffle(bars);
    await stopSorting();
  }

  Future<void> reverseOrder() async {
    _nOfOperations = 0;
    _stopSorting = !_stopSorting;
    await _sorter.reverse(bars);
    await stopSorting();
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

  Future<void> _populate(int quantity) async {
    if (!_stopSorting) {
      await stopSorting();
      return;
    }

    quantity = max(quantity, _barsMinQuantity);
    _bars.clear();

    double multiplier = _barMaxHeight / quantity;

    for (int i = 1; i <= quantity; i++) {
      _bars.add(Bar((i * multiplier).toInt()));
    }
    await _render(_bars);
  }

  Future<void> _render(List<Bar> newBar) async {
    _bars = [...newBar];
    stateCallBack();
    await _sleep();
  }

  /// getters
  String get algorithm => _algo;

  List<Bar> get bars => _bars;

  int get barsQuantity {
    return _bars.length.clamp(_barsMinQuantity, _barsMaxQuantity);
  }

  int get barMaxHeight => _barMaxHeight;
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

  int get speedValue => _speed;

  /// setters
  set setAlgorithm(String algo) {
    _algo = algo.toLowerCase();
    stateCallBack();
  }

  set setBarsQuantity(num newQuantity) => _populate(newQuantity.toInt());

  set setSpeedFromValue(num newSpeed) {
    _speed = newSpeed.toInt();
    stateCallBack();
  }
}
