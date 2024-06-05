# Gnome sort

Gnome sort (originally stupid sort) is a variation of the insertion sort sorting algorithm that does not use nested loops.

## Usage

Gnome Sort has no use in practice due to its inefficiency compared to other sorting algorithms. It's mainly used for educational purposes.

## Time complexity

Worst-case | Best-case
------- | --------
O(n²) | O(n) (when the list is already sorted)

## Brief algorithm description

- Gnome sort works by building a sorted list one element at a time, getting each item to the proper place in a series of swaps.
- Start at the first element of the list. Compare the current element with the previous element. If the current element is greater than or equal to the previous element, move to the next element. If the current element is smaller than the previous element, swap them and move one step back. Repeat until the end of the list is reached

## Implementation in Dart

```Dart
List<int> gnomeSort(List<int> list) {
  int pos = 0;
  while (pos < list.length) {
    if (pos == 0 || list[pos] >= list[pos - 1]) {
      pos++;
    } else {
      int temp = list[pos];
      list[pos] = list[pos - 1];
      list[pos - 1] = temp;
      pos--;
    }
  }
  return list;
}

```
