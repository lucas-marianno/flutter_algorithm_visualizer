# Quick Sort

Quick Sort is a highly efficient sorting algorithm that uses a divide-and-conquer approach to sort elements. It works by selecting a 'pivot' element and partitioning the array into two sub-arrays according to whether elements are less than or greater than the pivot. This process is repeated recursively for each sub-array.

## Usage

Quick Sort is commonly used in applications that require efficient sorting and can tolerate O(n²) worst-case performance, which is rare due to average performance being O(n log n). It's widely used in systems where memory space is tight as it is an in-place sort (does not require additional storage).

### Real-world Use Cases

- **Search Algorithms**: Quick Sort is used in search algorithms where quick sorting of elements is needed.
- **Database Systems**: It is used in database systems for efficient querying and indexing.
- **General Purpose Sorting**: Due to its average-case efficiency and in-place nature, Quick Sort is often used in various general-purpose sorting tasks in software applications.

## Time complexity

Worst-case | Best-case
--- | ---
O(n²) | O(n log n)

Quick Sort can perform poorly in the worst case if the pivot selections are poor (e.g., always the smallest or largest element), leading to unbalanced partitions. However, this can be mitigated by using techniques like random pivot selection or median-of-three.

## Algorithm description

1. Choose a pivot element from the array.
2. Partition the array into two sub-arrays:
   - Elements less than the pivot.
   - Elements greater than the pivot.
3. Recursively apply the above steps to the sub-arrays.
4. Combine the sub-arrays and the pivot to get the sorted array.

## Implementation in Dart

```Dart
void quickSort(List<int> list, int left, int right) {
  if (left < right) {
    int pivotIndex = _partition(list, left, right);
    quickSort(list, left, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, right);
  }
}

int _partition(List<int> list, int left, int right) {
  int pivot = list[right];
  int i = left - 1;

  for (int j = left; j < right; j++) {
    if (list[j] < pivot) {
      i++;
      _swap(list, i, j);
    }
  }

  _swap(list, i + 1, right);
  return i + 1;
}

void _swap(List<int> list, int i, int j) {
  int temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
```
