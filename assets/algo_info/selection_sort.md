# Selection sort

## Time complexity

- O(n²) – O(n²)

## Brief algorithm description

Goes through the entire array, finds the smallest item, and places it first. Rinse and repeat.

## Implementation in Dart

```Dart
List<int> selectionSort(List<int> list) {
  for (int sorted = 0; sorted < list.length; sorted++) {
    int indexOfSmallest = sorted;

    for (int i = sorted + 1; i < list.length; i++) {
      if (list[i] < list[indexOfSmallest]) {
        indexOfSmallest = i;
      }
    }
    int temp = list[sorted];
    list[sorted] = list[indexOfSmallest];
    list[indexOfSmallest] = temp;
  }
  return list;
}
```
