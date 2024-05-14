# Insertion sort

## Time complexity

- O(n²) - O(n)

## Brief algorithm description

- Similar to how humans sort a deck of cards.
- Creates two arrays, a sorted and an unsorted array, goes through each element in the unsorted array and determines where in the sorted list it should go to by iterating through every pair in the sorted list to see if the number is between them.

## Implementation in Dart

```Dart
List<int> insertion(List<int> list) {
  for (int i = 1; i < list.length; i++) {
    int j = i - 1;
    while (j >= 0 && list[j] > list[j + 1]) {
      int temp = list[j];
      list[j] = list[j + 1];
      list[j + 1] = temp;
      j--;
    }
  }

  return list;
}
```
