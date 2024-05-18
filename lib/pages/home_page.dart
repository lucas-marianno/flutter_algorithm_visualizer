import 'package:algorithm_visualizer/pages/algo_info_page.dart';
import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:algorithm_visualizer/widgets/buttom.dart';
import 'package:algorithm_visualizer/widgets/custom_slider.dart';
import 'package:algorithm_visualizer/logic/sorting_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SortingController sortingController;

  List<Bar> bars = [];

  void selectAlgorithm(String algo) {
    setState(() {
      sortingController.setAlgorithm = algo;
    });
  }

  void updateBarsGraph(List<Bar> newBars) {
    setState(() {
      bars = [...newBars];
    });
  }

  @override
  void initState() {
    sortingController = SortingController(
      bars: bars,
      barsQuantity: 100,
      updateBarsCallback: updateBarsGraph,
    );
    sortingController.init();

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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlgoInfoPage(sortingController.algorithm)),
                        );
                      },
                      icon: const Icon(Icons.info_outline),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sortingController.algorithm),
                        Text('${sortingController.delayMs}ms delay / loop'),
                        Text('${sortingController.nOfOperations} operations'),
                        Text(sortingController.elapsedTime.toString())
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
                        label: sortingController.barsQuantity.toString(),
                        value: sortingController.barsQuantity.toDouble(),
                        min: 2,
                        max: 100,
                        divisions: 100,
                        onChanged: (value) {
                          sortingController.stopSort();
                          sortingController.setBarsQuantity = value.toInt();
                          bars = sortingController.getBars;
                          setState(() {});
                        },
                      ),
                      MySlider(
                        title: 'Sorting Speed',
                        value: sortingController.speedValue,
                        label: sortingController.speedLabel,
                        min: 1,
                        max: 4,
                        divisions: 3,
                        onChanged: (speed) {
                          sortingController.setSpeedFromValue = speed.toInt();
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                title: 'Randomize',
                                onTap: (_) => sortingController.randomize(),
                              ),
                            ),
                            Expanded(
                              child: MyButton(
                                title: 'Reverse',
                                onTap: (_) => sortingController.reverseOrder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MyButton(
                          title: sortingController.hasStopped() ? 'Start' : 'Stop',
                          onTap: (_) async {
                            sortingController.hasStopped()
                                ? sortingController.startSorting()
                                : await sortingController.stopSort();
                          },
                        ),
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
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Merge Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Selection Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Insertion Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Quick Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Shell Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Heap Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Radix Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Cocktail shaker Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Gnome Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Bitonic Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
                        ),
                        MyButton(
                          title: 'Bogo Sort',
                          selectedAlgorithm: sortingController.algorithm,
                          onTap: selectAlgorithm,
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
