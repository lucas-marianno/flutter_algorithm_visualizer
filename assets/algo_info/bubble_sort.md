# Bubble sort

## Time complexity

- O(n²) - O(n)

## Brief algorithm description

Compares each item with the next item in the array, if the first item is larger than the next, switches their positions, otherwise moves on to the next pair. Rinse and repeat.

```Dart
void bubbleSort(List<int> bars, int steps) {
  if (steps <= 1) return;
  bool isSorted = true;
  for (int i = 0; i < steps - 1; i++) {
    if (bars[i] > bars[i + 1]) {
      isSorted = false;
      final int tempBar = bars[i];
      bars[i] = bars[i + 1];
      bars[i + 1] = tempBar;
    }
  }
  if (isSorted) return;
  bubbleSort(bars, steps--);
}
```
