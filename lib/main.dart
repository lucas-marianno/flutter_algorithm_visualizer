import 'package:algorithm_visualizer/bar.dart';
import 'package:algorithm_visualizer/widgets/buttom.dart';
import 'package:algorithm_visualizer/widgets/custom_slider.dart';
import 'package:algorithm_visualizer/logic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int nOfBars = 100;
  int sortingSpeed = 2;
  final Duration animationInterval = const Duration(microseconds: 1);
  final int barHeight = 400;

  bool stopSort = false;
  List<Bar> bars = [];
  double multiplier = 1;

  void randomize() {
    setState(() => bars.shuffle());
  }

  void stop() {
    setState(() {
      stopSort = true;
    });
  }

  void selectBars(List<int> indexes) {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value, selected: true);
    }
    setState(() {});
  }

  void unSelectBars(List<int> indexes) {
    for (int index in indexes) {
      bars[index] = Bar(bars[index].value);
    }
    setState(() {});
  }

  Future<void> bubbleSort(int steps, {bool isSorted = false}) async {
    if (steps <= 1 || stopSort || isSorted) return;
    isSorted = true;
    for (int i = 0; i < steps - 1; i++) {
      selectBars([i, i + 1]);

      if (bars[i].value > bars[i + 1].value) {
        isSorted = false;
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await delay(sortingSpeed, stopSort);
      unSelectBars([i, i + 1]);
    }
    bubbleSort(steps - 1, isSorted: isSorted);
  }

  Future<List<Bar>> mergeSort(List<Bar> barsList, int startIndex, int endIndex) async {
    if (barsList.length == 1) return barsList;
    print('from $startIndex to $endIndex');

    List<Bar> left = barsList.sublist(0, barsList.length ~/ 2);
    List<Bar> right = barsList.sublist(barsList.length ~/ 2);
    left = await mergeSort(left, 0, barsList.length ~/ 2);
    right = await mergeSort(right, barsList.length ~/ 2, barsList.length);

    //merge part
    List<Bar> merged = [];
    while (left.isNotEmpty && right.isNotEmpty) {
      final tempA = merged.length;
      final tempB = merged.length + left.length;
      selectBars([tempA, tempB]);
      if (left[0].value < right[0].value) {
        merged.add(left[0]);
        left.removeAt(0);
      } else {
        merged.add(right[0]);
        right.removeAt(0);
      }
      await delay(sortingSpeed, stopSort);
      unSelectBars([tempA, tempB]);
      setState(() {
        bars.replaceRange(startIndex, endIndex, merged + left + right);
      });
    }
    // unSelectBars([startIndex, endIndex]);
    while (left.isNotEmpty) {
      selectBars([merged.length]);
      merged.add(left[0]);
      left.removeAt(0);
      selectBars([merged.length - 1]);
    }
    while (right.isNotEmpty) {
      selectBars([merged.length]);
      merged.add(right[0]);
      right.removeAt(0);
      selectBars([merged.length - 1]);
    }
    await delay(sortingSpeed, stopSort);

    return merged;
  }

  @override
  void initState() {
    bars = populate(barHeight, nOfBars);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("algorithms")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bars,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MySlider(
                        title: 'Quantity',
                        label: nOfBars.toString(),
                        value: nOfBars.toDouble(),
                        min: 2,
                        max: 100,
                        divisions: 100,
                        onChanged: (value) {
                          stop();
                          nOfBars = value.toInt();
                          bars = populate(barHeight, nOfBars);
                          setState(() {});
                        },
                      ),
                      MySlider(
                        title: 'Sorting Speed',
                        value: sortingSpeed.toDouble(),
                        label: sortingSpeedLabel(sortingSpeed),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        onChanged: (speed) {
                          sortingSpeed = speed.toInt();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyButton(title: 'Randomize', onTap: randomize),
                      MyButton(title: 'Stop', onTap: stop),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        MyButton(
                          title: 'Bubble Sort',
                          onTap: () {
                            stopSort = false;
                            bubbleSort(bars.length);
                          },
                        ),
                        MyButton(
                          title: 'Selection Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Insertion Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Quick Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Merge Sort',
                          onTap: () {
                            stopSort = false;
                            mergeSort(bars, 0, bars.length);
                          },
                        ),
                        MyButton(
                          title: 'Heap Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Radix sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Shell Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Cocktail shaker Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Gnome Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Bitonic Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Bogo Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
