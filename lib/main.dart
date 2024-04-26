import 'package:algorithm_visualizer/bar.dart';
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

  void populate(int quantity) {
    bars.clear();

    multiplier = barHeight / nOfBars;

    for (int i = 1; i <= quantity; i++) {
      bars.add(Bar((i * multiplier).toInt()));
    }
  }

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

      await Future.delayed(animationInterval);
      bars[i] = Bar(bars[i].value);
      bars[i + 1] = Bar(bars[i + 1].value);
    }
    setState(() {});
    bubbleSort(steps - 1, isSorted: isSorted);
  }

  String sortingSpeedLabel() {
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

  @override
  void initState() {
    populate(nOfBars);
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Slider(
                        label: nOfBars.toString(),
                        value: nOfBars.toDouble(),
                        divisions: 100,
                        min: 2,
                        max: 100,
                        onChanged: (value) {
                          stopSort = true;
                          setState(() {});
                          nOfBars = value.toInt();
                          populate(nOfBars);
                          setState(() {});
                        },
                      ),
                      Slider(
                        value: sortingSpeed.toDouble(),
                        label: sortingSpeedLabel(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: randomize, child: const Text('randomize')),
                      ElevatedButton(onPressed: stop, child: const Text('stop'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          stopSort = false;
                          bubbleSort(bars.length);
                        },
                        child: const Text('bubble sort'),
                      ),
                    ],
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
