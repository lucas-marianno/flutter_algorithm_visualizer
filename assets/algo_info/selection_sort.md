# Selection Sort

Selection sort iterates through the list, finding the minimum (or maximum) element and placing it in its correct position. This process repeats until the entire list is sorted.

## Usage

* Selection sort is useful for educational purposes due to its simplicity.
* It can be beneficial for small datasets where simplicity outweighs efficiency.

## Time complexity

Worst-case | Best-case
------- | --------
O(n²) | O(n²) (selection sort has no advantage for pre-sorted data)

## Algorithm description

1. Iterate through the list.
2. Set the minimum (or maximum) index to the current position (i).
3. Iterate through the remaining unsorted part of the list (from i+1 to the end).
4. If a smaller (or larger) element is found, update the minimum (or maximum) index.
5. Swap the element at the current position (i) with the element at the minimum (or maximum) index.
6. Repeat steps 1-5 until the entire list is sorted.

## Implementation in Dart

```Dart
void selectionSort(List<int> list) {
  int n = list.length;
  for (int i = 0; i < n - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < n; j++) {
      if (list[j] < list[minIndex]) {
        minIndex = j;
      }
    }
    int temp = list[i];
    list[i] = list[minIndex];
    list[minIndex] = temp;
  }
}
```
