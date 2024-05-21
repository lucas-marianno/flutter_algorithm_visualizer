import 'package:algorithm_visualizer/pages/algo_info_page.dart';
import 'package:algorithm_visualizer/widgets/algo_button.dart';
import 'package:algorithm_visualizer/widgets/menu_button.dart';
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

  void selectAlgorithm(String algo) {
    setState(() {
      sortingController.setAlgorithm = algo;
    });
  }

  @override
  void initState() {
    sortingController = SortingController(stateCallBack: () => setState(() {}));
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
            // graphics
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
                        Text('${sortingController.barsQuantity} array elements'),
                        Text('${sortingController.delayMs}ms delay / loop'),
                        Text('${sortingController.nOfOperations} operations'),
                        Text(sortingController.elapsedTime.toString())
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: sortingController.bars,
                  ),
                ],
              ),
            ),
            // buttons
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 5),
                  const Divider(),
                  // menu buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MySlider(
                        title: 'Quantity',
                        label: sortingController.barsQuantity.toString(),
                        value: sortingController.barsQuantity,
                        min: sortingController.barsMinQuantity,
                        max: sortingController.barsMaxQuantity,
                        onChanged: (value) => sortingController.setBarsQuantity = value,
                      ),
                      MySlider(
                        title: 'Sorting Speed',
                        label: sortingController.speedLabel,
                        value: sortingController.speedValue,
                        min: 1,
                        max: 4,
                        onChanged: (speed) => sortingController.setSpeedFromValue = speed,
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
                              child: MenuButton(
                                title: 'Shuffle',
                                onTap: sortingController.startShuffling,
                              ),
                            ),
                            Expanded(
                              child: MenuButton(
                                title: 'Reverse',
                                onTap: sortingController.reverseOrder,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MenuButton(
                          title: sortingController.hasStopped() ? 'Start' : 'Stop',
                          onTap: () async {
                            sortingController.hasStopped()
                                ? sortingController.startSorting()
                                : await sortingController.stopSorting();
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  // algo buttons
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        AlgoButton(title: 'Bubble Sort', sortingController: sortingController),
                        AlgoButton(title: 'Merge Sort', sortingController: sortingController),
                        AlgoButton(title: 'Selection Sort', sortingController: sortingController),
                        AlgoButton(title: 'Insertion Sort', sortingController: sortingController),
                        AlgoButton(title: 'Quick Sort', sortingController: sortingController),
                        AlgoButton(title: 'Shell Sort', sortingController: sortingController),
                        AlgoButton(title: 'Heap Sort', sortingController: sortingController),
                        AlgoButton(title: 'Radix Sort', sortingController: sortingController),
                        AlgoButton(
                            title: 'Cocktail Shaker Sort', sortingController: sortingController),
                        AlgoButton(title: 'Gnome Sort', sortingController: sortingController),
                        AlgoButton(title: 'Bitonic Sort', sortingController: sortingController),
                        AlgoButton(title: 'Bogo Sort', sortingController: sortingController),
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
