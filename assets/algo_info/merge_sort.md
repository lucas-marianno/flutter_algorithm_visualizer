# Merge sort

## Time complexity

- O(n log n) - Ω(n log n) both in their best and worst-case scenarios, the complexity is n log n.

## Brief algorithm description

- Divide and conquer style algorithm.
- Divides the array in half in each iteration until it reaches the smallest unit, then compares the first item in the first array with the first item in the second array and position them accordingly in a new sorted array. Keeps comparing each item with the next until the array is sorted.

## Implementation in Dart

```Dart
List<int> mergeSort(List<int> list) {
  if (list.length == 1) return list;

  List<int> merged = [];
  List<int> left = list.sublist(0, list.length ~/ 2);
  List<int> right = list.sublist(list.length ~/ 2);

  left = mergeSort(left);
  right = mergeSort(right);

  while (left.isNotEmpty && right.isNotEmpty) {
    if (left[0] < right[0]) {
      merged.add(left[0]);
      left.removeAt(0);
    } else {
      merged.add(right[0]);
      right.removeAt(0);
    }
  }

  while (left.isNotEmpty) {
    merged.add(left[0]);
    left.removeAt(0);
  }
  while (right.isNotEmpty) {
    merged.add(right[0]);
    right.removeAt(0);
  }

  return merged;
}
```
