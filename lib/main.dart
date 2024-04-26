import 'package:algorithm_visualizer/bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Bar> bars = [];
  List<Bar> barsSorted = [];
  int multiplier = 10;
  Duration animationInterval = const Duration(milliseconds: 50);

  void populate(int nOfBars) {
    for (int i = 0; i < nOfBars; i++) {
      bars.add(Bar(i * multiplier));
    }
    barsSorted = bars;
  }

  void randomize() {
    print('randomize click');
    setState(() => bars.shuffle());
  }

  void bubbleSort(int steps) async {
    print(steps);
    if (steps <= 0) return;

    //for each item in list
    //compare with next item's value
    //if next items value is smaller thant current value, switch places
    //go to next item

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
    steps--;
    bubbleSort(steps);
  }

  @override
  void initState() {
    populate(30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("algorithms")),
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: randomize, child: const Text('randomize')),
                ElevatedButton(onPressed: () => bubbleSort(bars.length), child: const Text('sort')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
