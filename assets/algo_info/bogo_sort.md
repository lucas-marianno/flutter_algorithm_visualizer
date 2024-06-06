# Bogo sort

Also known as permutation sort or stupid sort, is a highly inefficient sorting algorithm. It randomly permutes the elements of the list until the list is sorted. There is no guarantee of when (or if) the algorithm will terminate, making it unsuitable for practical use.

It's the only sorting algorithm with a theoretically possible O(1) time complexity hence there's a probability of sorting the array first try.

## Usage

Bogo Sort is mostly used for educational purposes to illustrate inefficient algorithms. It can also be used as a humorous example of a brute force approach to sorting.

## Time complexity

Worst-case | Best-case
------- | --------
O(n!) | O(n) (when the list is already sorted)

## Algorithm description

1. Check if the list is sorted.
2. If the list is sorted, stop.
3. If the list is not sorted, randomly shuffle the elements.
4. Repeat steps 1-3 until the list is ~~hopefully~~ sorted.

## Implementation in Dart

```Dart
void bogo(List<int> arr) {
  bool isSorted() {
    for (int i = 1; i < arr.length; i++) {
      if (arr[i - 1] > arr[i]) {
        return false;
      }
    }
    return true;
  }

  while (!isSorted()) {
    arr.shuffle();
  }
}
```
