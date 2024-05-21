# Cocktail Shaker Sort

- Also known as bidirectional bubble sort. The algorithm extends bubble sort by operating in two directions. While it improves on bubble sort by more quickly moving items to the beginning of the list, it provides only marginal performance improvements

## Time complexity

- O(n²) - O(n) (when already sorted)

## Brief algorithm description

- Initialization: Start at the beginning of the list.
- Forward Pass: Compare each pair of adjacent elements. If the elements are out of order (the first element is greater than the second), swap them. Continue this process until the end of the list is reached.
- Backward Pass: After completing the forward pass, move backward through the list.
Compare each pair of adjacent elements. If the elements are out of order, swap them.
Continue this process until the beginning of the list is reached.
- Repeat the forward and backward passes until no swaps are needed, indicating that the list is sorted.

## Implementation in Dart

```Dart
void cocktailShakerSort(List<int> list) {
  bool swapped = true;
  int start = 0;
  int end = list.length;

  while (swapped) {
    swapped = false;

    // Forward pass
    for (int i = start; i < end - 1; i++) {
      if (list[i] > list[i + 1]) {
        int temp = list[i];
        list[i] = list[i + 1];
        list[i + 1] = temp;
        swapped = true;
      }
    }

    if (!swapped) break;

    swapped = false;
    end--;

    // Backward pass
    for (int i = end - 1; i > start; i--) {
      if (list[i] < list[i - 1]) {
        int temp = list[i];
        list[i] = list[i - 1];
        list[i - 1] = temp;
        swapped = true;
      }
    }

    start++;
  }
}
```
