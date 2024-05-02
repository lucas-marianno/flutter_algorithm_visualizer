import 'package:algorithm_visualizer/logic/sorting_algorithms/bubble_sort.dart';
import 'package:algorithm_visualizer/logic/sorting_algorithms/merge_sort.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:algorithm_visualizer/widgets/buttom.dart';
import 'package:algorithm_visualizer/widgets/custom_slider.dart';
import 'package:algorithm_visualizer/logic/logic.dart';
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
  SortingSpeed sortingSpeed = SortingSpeed();
  final Duration animationInterval = const Duration(microseconds: 1);
  final int barHeight = 400;

  bool stopSort = false;
  List<Bar> bars = [];
  double multiplier = 1;

  void randomize() {
    stopSorting();
    setState(() => bars.shuffle());
  }

  List<Bar> populate(int barHeight, int nOfBars) {
    stopSorting();
    bars.clear();

    double multiplier = barHeight / nOfBars;

    for (int i = 1; i <= nOfBars; i++) {
      bars.add(Bar((i * multiplier).toInt()));
    }
    return bars;
  }

  void stopSorting() {
    setState(() {
      stopSort = true;
      // sortingSpeed.setSpeed = Speed.instant;
    });
  }

  Future<void> updateBarsGraph(List<Bar> newBars) async {
    if (stopSort) return;

    await sortingSpeed.delay();
    setState(() {
      bars = newBars;
    });
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
                          stopSorting();
                          nOfBars = value.toInt();
                          bars = populate(barHeight, nOfBars);
                          setState(() {});
                        },
                      ),
                      MySlider(
                        title: 'Sorting Speed',
                        value: sortingSpeed.value(),
                        label: sortingSpeed.label(),
                        min: 1,
                        max: 4,
                        divisions: 3,
                        onChanged: (speed) {
                          sortingSpeed.setSpeedFromValue = speed.toInt();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: MyButton(title: 'Randomize', onTap: randomize)),
                      Expanded(
                        child: MyButton(title: 'Stop', onTap: stopSorting),
                      ),
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
                            // stopSorting();
                            stopSort = false;
                            bubble(bars, updateBarsGraph);
                          },
                        ),
                        MyButton(
                          title: 'Merge Sort',
                          onTap: () {
                            // stopSorting();
                            stopSort = false;
                            merge(bars, updateBarsGraph);
                          },
                        ),
                        MyButton(
                          title: 'Selection Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Insertion Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Quick Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Heap Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Radix sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Shell Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Cocktail shaker Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Gnome Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Bitonic Sort',
                          onTap: () {
                            stopSorting();
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Bogo Sort',
                          onTap: () {
                            stopSorting();
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
