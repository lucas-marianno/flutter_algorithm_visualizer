# Insertion Sort

Similar to how humans sort a deck of cards.
Insertion sort iterates through the list, treating the first element as sorted. For each unsorted element, it inserts it into its correct position within the sorted sub-list at the beginning of the list.

## Usage

* Insertion sort is efficient for small datasets or when the data is partially sorted.
* It's also a stable sorting algorithm, meaning elements with equal values retain their relative order. This can be useful in specific situations.

## Time complexity

| worst-case | best-case |
|---|---|
| O(n²) | O(n) (when the list is already sorted) |

## Algorithm description

1. Iterate through the list starting from the second element (index 1).
2. Pick the current element (at index i).
3. Compare the current element with the element before it (at index i-1).
4. If the current element is smaller, shift the greater elements one position to the right until a position for the current element is found.
5. Insert the current element into the vacated position.
6. Repeat steps 2-5 for all unsorted elements (until the end of the list).

## Implementation in Dart

```Dart
void selectionSort(List<int> list) {
  for (int i = 1; i < list.length; i++) {
    int j = i - 1;
    while (j >= 0 && list[j] > list[j + 1]) {
      int temp = list[j];
      list[j] = list[j + 1];
      list[j + 1] = temp;
      j--;
    }
  }
}
```
