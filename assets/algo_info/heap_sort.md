# Heap Sort

Heap Sort is a comparison-based sorting algorithm that uses a binary heap data structure. It first builds a max-heap from the input data and then repeatedly extracts the maximum element from the heap, placing it at the end of the sorted array.

## Usage

Heap Sort is useful for applications requiring guaranteed O(n log n) time complexity and in-place sorting without additional memory overhead, such as in embedded systems and real-time applications.

### Real-world Use Cases

- **Priority Queues**: Used to implement priority queues where quick access to the largest (or smallest) element is needed.
- **Scheduling Algorithms**: Helps in CPU scheduling algorithms where tasks with higher priority need to be processed first.
- **Real-time Systems**: Suitable for real-time systems where predictable time complexity is crucial.

Heap Sort is an efficient and reliable sorting algorithm suitable for various practical applications due to its predictable performance and in-place sorting capability.

## Time complexity

Worst-case | Best-case
--- | ---
O(n log n) | O(n log n)

Heap Sort always maintains a time complexity of O(n log n) regardless of the initial order of elements, making it highly predictable.

## Algorithm description

1. **Build a Max-Heap**: Rearrange the array into a max-heap.
2. **Extract Elements**: Repeatedly extract the maximum element from the heap and adjust the heap structure.
3. **Heapify**: Restore the heap property after each extraction.
4. Repeat the process until all elements are sorted.

## Implementation in Dart

```Dart
void heapSort(List<int> list) {
  int n = list.length;

  for (int i = n ~/ 2 - 1; i >= 0; i--) {
    _heapify(list, n, i);
  }

  for (int i = n - 1; i > 0; i--) {
    _swap(list, 0, i);

    _heapify(list, i, 0);
  }
}

void _heapify(List<int> list, int n, int i) {
  int largest = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;

  if (left < n && list[left] > list[largest]) {
    largest = left;
  }

  if (right < n && list[right] > list[largest]) {
    largest = right;
  }

  if (largest != i) {
    _swap(list, i, largest);

    _heapify(list, n, largest);
  }
}

void _swap(List<int> list, int i, int j) {
  int temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
```

### Explanation

- **Heap Construction**: The array is converted into a max-heap by calling `_heapify` for all non-leaf nodes starting from the last non-leaf node up to the root.
- **Element Extraction**: The maximum element (root of the heap) is repeatedly swapped with the last element of the array, then the heap size is reduced, and `_heapify` is called to restore the heap property.
- **Heapify Function**: Ensures that the subtree rooted at a given index `i` obeys the max-heap property by comparing the node with its children and swapping them if necessary.
