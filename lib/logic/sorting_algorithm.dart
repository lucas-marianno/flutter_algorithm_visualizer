import 'package:algovis/logic/sorting_graphics.dart';
import 'package:algovis/widgets/bar.dart';

abstract class SortingAlgorithm extends SortingGraphics {
  final void Function() registerOperation;
  final bool Function() hasStopped;

  SortingAlgorithm({
    required super.updateBarsGraph,
    required this.registerOperation,
    required this.hasStopped,
  });

  Future<void> sort(List<Bar> bars);
}
