# Shell sort

## Time complexity

- O(n²) - O(n log n)

## Brief algorithm description

- Start with a gap value, typically half the length of the list, and reduce this gap size in each iteration. Compare elements that are 'gap' distance apart and swap them if necessary to put them in the correct order. Continue this process with decreasing gap sizes until the gap becomes 1, at which point the algorithm behaves like an insertion sort. Finally, perform a normal insertion sort on the entire list.
- Improved insertion sort

## Implementation in Dart

```Dart
void shellSort(List arr) {
  int n = arr.length;
  
  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < n; i += 1) {
      int temp = arr[i];
  
      int j;
      for (j = i; j >= gap && arr[j - gap] > temp; j -= gap) {
        arr[j] = arr[j - gap];
      }
  
      arr[j] = temp;
    }
  }
}
```
