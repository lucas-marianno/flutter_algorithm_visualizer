# Shell sort

Improved insertion sort

## Usage

* Shell sort is a good choice for situations where a balance between simplicity and efficiency is desired.
* It performs better than insertion sort for larger datasets and has a time complexity that can be better than bubble sort or selection sort in certain scenarios.

## Time complexity

Worst-case | Best-case
---------|------
O(n²) | O(n log n) (for certain gap sequences)

## Algorithm description

1. Start with a gap value, typically half the length of the list, and reduce this gap size in each iteration.
2. Compare elements that are 'gap' distance apart and swap them if necessary to put them in the correct order.
3. Continue this process with decreasing gap sizes until the gap becomes 1, at which point the algorithm behaves like an insertion sort.
4. Finally, perform a normal insertion sort on the entire list.

## Implementation in Dart

This implementation uses Pratt's sequence. (The gap value starts with approximately half the list length and then keeps getting divided by 2 in subsequent iterations.)

```Dart
void shellSort(List<int> list) {
  int n = list.length;

  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < n; i++) {
      int temp = list[i];

      int j;
      for (j = i; j >= gap && list[j - gap] > temp; j -= gap) {
        list[j] = list[j - gap];
      }

      list[j] = temp;
    }
  }
}
```
