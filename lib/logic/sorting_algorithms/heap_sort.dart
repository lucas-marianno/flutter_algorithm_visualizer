import 'package:algorithm_visualizer/widgets/bar.dart';
import 'package:flutter/material.dart';

Future<void> heap(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBar) updateBarsGraph,
  void Function() registerOperation,
) async {
  Future<void> colorize(List<int> index, {Color? color = Colors.amber}) async {
    for (int i in index) {
      bars[i] = Bar(bars[i].value, color: color);
    }
    await updateBarsGraph(bars);
    for (int i in index) {
      bars[i] = Bar(bars[i].value);
    }
    updateBarsGraph(bars);
  }

  Future<void> heapify(List<Bar> arr, int n, int i) async {
    await colorize([i]);
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // left = 2*i + 1
    int right = 2 * i + 2; // right = 2*i + 2

    // If left child is larger than root
    if (left < n && arr[left].value > arr[largest].value) {
      largest = left;
    }

    // If right child is larger than largest so far
    if (right < n && arr[right].value > arr[largest].value) {
      largest = right;
    }

    // If largest is not root
    if (largest != i) {
      Bar swap = arr[i];
      arr[i] = arr[largest];
      arr[largest] = swap;
      // Recursively heapify the affected sub-tree
      await heapify(arr, n, largest);
    }
    registerOperation();
  }

  Future<List<Bar>> sort(List<Bar> arr) async {
    int n = arr.length;

    // Build heap (rearrange array)
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      heapify(arr, n, i);
      await colorize([i]);
      registerOperation();
    }

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
      // Move current root to end
      Bar temp = arr[0];
      arr[0] = arr[i];
      arr[i] = temp;

      // call max heapify on the reduced heap
      await heapify(arr, i, 0);
      await colorize([i]);
      registerOperation();
    }
    return arr;
  }

  updateBarsGraph(await sort(bars));
}
