# Merge sort

Merge Sort is a divide-and-conquer algorithm that splits the list into smaller sublists, sorts them, and then merges them back together.

## Usage

Merge Sort is useful in scenarios where stable sorting and guaranteed O(n log n) time complexity are important, such as in sorting linked lists and large datasets.

## Time complexity

Worst-case | Best-case
---|---
O(n log n) | O(n log n) (merge sort has no advantage for pre-sorted data)

## Algorithm description

Divides the array in half in each iteration until it reaches the smallest unit, then compares the first item in the first array with the first item in the second array and position them accordingly in a new sorted array. Keeps comparing each item with the next until the array is sorted.

1. **Divide:** Recursively divide the unsorted list into sub-lists containing a single element each.
2. **Conquer:** Merge the sub-lists back together by comparing elements from the two sub-lists and inserting the smaller element into the new merged list.
3. **Merge:** Repeat step 2 (merge) until a single sorted list is obtained.

## Implementation in Dart

```Dart
List<int> mergeSort(List<int> list) {
  if (list.length == 1) return list;

  List<int> merged = [];
  List<int> left = list.sublist(0, list.length ~/ 2);
  List<int> right = list.sublist(list.length ~/ 2);

  // divide
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
