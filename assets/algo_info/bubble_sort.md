# Bubble Sort

Bubble sort is a simple sorting algorithm that repeatedly iterates through the list, compares adjacent elements, and swaps them if they are in the wrong order. Larger elements "bubble" up to the end of the list with each pass.

## Usage

* Selection sort is useful for educational purposes due to its simplicity.
* Bubble sort is not ideal for large datasets due to its high time complexity.
* In special cases, it can be useful for small data sets or when the data is nearly sorted already.

## Time complexity

Worst-case | Best-case
------- | --------
O(n²) | O(n) (when the list is already sorted)

## Algorithm description

1. Iterate through the list.
2. Compare adjacent elements.
3. If the elements are in the wrong order (larger element comes first), swap them.
4. Repeat steps 1-3 for the entire list.
5. Since the largest element has "bubbled" to the end, reduce the list size by 1 and repeat steps 1-4 until the entire list is sorted.

## Implementations in Dart

### Interactive implementation

```Dart
void bubbleSort(List<int> list) {
  int n = list.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
}
```

### Recursive implementation

```Dart
void bubbleSort(List<int> list, int steps) {
  if (steps <= 1) return;
  bool isSorted = true;
  for (int i = 0; i < steps - 1; i++) {
    if (list[i] > list[i + 1]) {
      isSorted = false;
      int tempBar = list[i];
      list[i] = list[i + 1];
      list[i + 1] = tempBar;
    }
  }
  if (isSorted) return;
  bubbleSort(list, steps--);
}
```
