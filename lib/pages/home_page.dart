import 'package:algovis/pages/algo_info_page.dart';
import 'package:algovis/widgets/algo_button.dart';
import 'package:algovis/widgets/bars.dart';
import 'package:algovis/widgets/menu_button.dart';
import 'package:algovis/widgets/custom_slider.dart';
import 'package:algovis/logic/sorting_controller.dart';
import 'package:flutter/material.dart';
import 'package:algovis/util/string_extention.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SortingController sortCtrl;

  void selectAlgorithm(String algo) {
    setState(() {
      sortCtrl.setAlgorithm = algo;
    });
  }

  @override
  void initState() {
    sortCtrl = SortingController(stateCallBack: () => setState(() {}));
    sortCtrl.init();

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
                  Bars(sortCtrl: sortCtrl),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AlgoInfoPage(sortCtrl.algorithm)),
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
                        Text(sortCtrl.algorithm.toTitleCase()),
                        Text('${sortCtrl.barsQuantity} array elements'),
                        Text('${sortCtrl.delayMs}ms delay / loop'),
                        Text('${sortCtrl.nOfOperations} operations'),
                        Text(sortCtrl.elapsedTime.toString())
                      ],
                    ),
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
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MySlider(
                                title: 'Quantity',
                                label: sortCtrl.barsQuantity.toString(),
                                value: sortCtrl.barsQuantity,
                                min: sortCtrl.barsMinQuantity,
                                max: sortCtrl.barsMaxQuantity,
                                onChanged: (value) => sortCtrl.setBarsQuantity = value,
                              ),
                              MySlider(
                                title: 'Sorting Speed',
                                label: sortCtrl.speedLabel,
                                value: sortCtrl.speedValue,
                                min: 1,
                                max: 4,
                                onChanged: (speed) => sortCtrl.setSpeedFromValue = speed,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: MenuButton(
                                        title: 'Shuffle',
                                        onTap: sortCtrl.startShuffling,
                                      ),
                                    ),
                                    Expanded(
                                      child: MenuButton(
                                        title: 'Reverse',
                                        onTap: sortCtrl.reverseOrder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: MenuButton(
                                  title: sortCtrl.hasStopped() ? 'Start' : 'Stop',
                                  onTap: () async {
                                    sortCtrl.hasStopped()
                                        ? sortCtrl.startSorting()
                                        : await sortCtrl.stopSorting();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // algo buttons
                  Expanded(
                    flex: 3,
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: [
                        // comparative
                        AlgoButton(title: 'Bubble Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Selection Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Insertion Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Bitonic Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Bitonic Sort (Parallel)', sortingController: sortCtrl),
                        // mixed
                        AlgoButton(title: 'Shell Sort', sortingController: sortCtrl),
                        // divide and conquer
                        AlgoButton(title: 'Merge Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Quick Sort', sortingController: sortCtrl),
                        // non comparative
                        AlgoButton(title: 'Heap Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Radix Sort', sortingController: sortCtrl),
                        // stupid
                        AlgoButton(title: 'Cocktail Shaker Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Gnome Sort', sortingController: sortCtrl),
                        AlgoButton(title: 'Bogo Sort', sortingController: sortCtrl),
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
