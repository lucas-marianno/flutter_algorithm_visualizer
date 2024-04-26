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
  final int nOfBars = 10;
  final Duration animationInterval = const Duration(milliseconds: 1);
  final int barHeight = 400;

  bool stopSort = false;
  List<Bar> bars = [];
  int multiplier = 1;

  void populate(int quantity) {
    for (int i = 1; i <= quantity; i++) {
      bars.add(Bar(i * multiplier));
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

  void bubbleSort(int steps) async {
    if (steps <= 1 || stopSort) return;

    for (int i = 0; i < steps - 1; i++) {
      bars[i] = Bar(bars[i].value, selected: true);
      bars[i + 1] = Bar(bars[i + 1].value, selected: true);
      setState(() {});
      if (bars[i].value > bars[i + 1].value) {
        final Bar tempBar = bars[i];
        bars[i] = bars[i + 1];
        bars[i + 1] = tempBar;
      }

      await Future.delayed(animationInterval);
      bars[i] = Bar(bars[i].value);
      bars[i + 1] = Bar(bars[i + 1].value);
      setState(() {});
    }
    bubbleSort(steps - 1);
  }

  @override
  void initState() {
    multiplier = barHeight ~/ nOfBars;
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
