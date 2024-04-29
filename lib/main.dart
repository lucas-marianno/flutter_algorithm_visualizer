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

  Future<void> bubbleSort(int steps, {bool isSorted = false}) async {
    if (steps <= 1 || stopSort || isSorted) return;
    isSorted = true;
    for (int i = 0; i < steps - 1; i++) {
      bars[i] = Bar(bars[i].value, selected: true);
      bars[i + 1] = Bar(bars[i + 1].value, selected: true);
      setState(() {});
      if (bars[i].value > bars[i + 1].value) {
        isSorted = false;
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await delay(sortingSpeed, stopSort);
      bars[i] = Bar(bars[i].value);
      bars[i + 1] = Bar(bars[i + 1].value);
    }
    setState(() {});
    bubbleSort(steps - 1, isSorted: isSorted);
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
                  const Divider(height: 50),
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
                  const SizedBox(height: 25),
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
                          title: 'Merge Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'Pogo Sort',
                          onTap: () {
                            stopSort = false;
                            //TODO:
                          },
                        ),
                        MyButton(
                          title: 'IDK Sort',
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
