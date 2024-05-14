# Heap Sort

## Time complexity

- O(n log n)

## Brief algorithm description

- Similar to selection sort, but with the “correct” data structure
- Heap sort is a comparison-based sorting algorithm that uses a binary heap data structure to sort elements. It divides its input into a sorted and an unsorted region, and it repeatedly shrinks the unsorted region by extracting the largest element from it and inserting it into the sorted region.
- Build a max heap from the input data. A max heap is a binary tree where the parent node is greater than or equal to its child nodes. Swap the root node (which contains the largest element) with the last node in the heap.
Reduce the size of the heap by one. Restore the heap property by calling heapify on the reduced heap.
Repeat steps 2-4 until the heap is empty. The sorted array is obtained by repeatedly extracting the maximum element from the heap and placing it at the end of the array.

## Implementation in Dart

```Dart
void heapSort(List arr) {
  int n = arr.length;
  
  for (int i = n ~/ 2 - 1; i >= 0; i--) {
    heapify(arr, n, i);
  }
  
  for (int i = n - 1; i >= 0; i--) {
    int temp = arr[0];
    arr[0] = arr[i];
    arr[i] = temp;
  
    heapify(arr, i, 0);
  }
}

void heapify(List arr, int n, int i) {
  int largest = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;
  
  if (left < n && arr[left] > arr[largest]) {
    largest = left;
  }
  
  if (right < n && arr[right] > arr[largest]) {
    largest = right;
  }
  
  if (largest != i) {
    int swap = arr[i];
    arr[i] = arr[largest];
    arr[largest] = swap;
  
    heapify(arr, n, largest);
  }
}

```
