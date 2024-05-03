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
  final SortingSpeed sortingSpeed = SortingSpeed();
  final Duration animationInterval = const Duration(microseconds: 1);
  final int barHeight = 400;
  int nOfBars = 100;
  String sortAlgorithm = 'bubble sort';
  bool stopSort = false;
  List<Bar> bars = [];

  void selectAlgorithm(String algo) {
    setState(() {
      sortAlgorithm = algo;
    });
  }

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
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bozo Sort'),
                        Text('n array access'),
                        Text('n calculations'),
                        Text('n ms delay')
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: bars,
                  ),
                ],
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
                          selectedAlgorithm: sortAlgorithm,
                          onTap: () => selectAlgorithm('bubble sort'),
                          // () {
                          //   // stopSorting();
                          //   stopSort = false;
                          //   bubble(bars, updateBarsGraph);
                          // },
                        ),
                        MyButton(
                          title: 'Merge Sort',
                          selectedAlgorithm: sortAlgorithm,
                          onTap: () => selectAlgorithm('merge sort'),
                          // () {
                          //   // stopSorting();
                          //   stopSort = false;
                          //   merge(bars, updateBarsGraph);
                          // },
                        ),
                        MyButton(title: 'Selection Sort', onTap: () {}),
                        const MyButton(title: 'Insertion Sort', onTap: null),
                        const MyButton(title: 'Quick Sort', onTap: null),
                        const MyButton(title: 'Heap Sort', onTap: null),
                        const MyButton(title: 'Radix sort', onTap: null),
                        const MyButton(title: 'Shell Sort', onTap: null),
                        const MyButton(title: 'Cocktail shaker Sort', onTap: null),
                        const MyButton(title: 'Gnome Sort', onTap: null),
                        const MyButton(title: 'Bitonic Sort', onTap: null),
                        const MyButton(title: 'Bogo Sort', onTap: null),
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
