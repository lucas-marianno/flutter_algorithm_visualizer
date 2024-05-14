# Quick sort

## Time complexity

- O(n²) - O(n log n)

## Brief algorithm description

- Divide and conquer style algorithm.
- Functions similarly to how merge sort works, but it uses a pivot. Pick a number in the unsorted array to be the pivot, then all the other numbers are compared to it and two new arrays are created, one with smaller than pivot, and another one with larger than pivot. Then each new array is iterated the same way, a new pivot is chosen, two new arrays are created containing numbers smaller and larger than it. Rinse and repeat until all of the arrays are one unit long, which means that the sorting is completed. The main catch of this algorithm is how you choose your pivot point, the most reliable method is to pick three random sample numbers and choose the median number, just to get an idea of what you might find in the array and avoid worst-case scenario.

## Implementation in Dart

```Dart
List<int> quickSort(List<int> barsList) {
  if (barsList.isEmpty) return barsList;

  List<int> smaller = [];
  List<int> equal = [];
  List<int> larger = [];

  int pivot = barsList[barsList.length ~/ 2];

  while (barsList.isNotEmpty) {
    if (barsList[0] < pivot) {
      smaller.add(barsList[0]);
    } else if (barsList[0] > pivot) {
      larger.add(barsList[0]);
    } else {
      equal.add(barsList[0]);
    }

    barsList.removeAt(0);
  }
  smaller = quickSort(smaller);
  larger = quickSort(larger);
  barsList.addAll([...smaller, ...equal, ...larger]);
  return barsList;
}
```
