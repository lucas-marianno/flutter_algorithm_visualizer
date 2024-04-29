import 'package:algorithm_visualizer/bar.dart';

List<Bar> populate(int barHeight, int nOfBars) {
  //bars.clear();
  List<Bar> bars = [];

  double multiplier = barHeight / nOfBars;

  for (int i = 1; i <= nOfBars; i++) {
    bars.add(Bar((i * multiplier).toInt()));
  }
  return bars;
}

Future<void> delay(int sortingSpeed, bool stopSort) async {
  if (stopSort) return;
  switch (sortingSpeed) {
    case 1:
      await Future.delayed(const Duration(milliseconds: 1000));
      return;
    case 2:
      await Future.delayed(const Duration(milliseconds: 100));
      return;
    case 3:
      await Future.delayed(const Duration(milliseconds: 1));
      return;
    default:
      return;
  }
}

String sortingSpeedLabel(int sortingSpeed) {
  switch (sortingSpeed) {
    case 1:
      return 'slow af';
    case 2:
      return 'slow';
    case 3:
      return 'fast';
    default:
      return 'instant';
  }
}
