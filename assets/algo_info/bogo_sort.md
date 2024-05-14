#	Bogo sort

### Space-time complexity:
- O((n+1)!) - O(1)

### Brief algorithm description:

- Also known as permutation sort or stupid sort, is a highly inefficient sorting algorithm. It randomly permutes the elements of the list until the list is sorted. There is no guarantee of when (or if) the algorithm will terminate, making it unsuitable for practical use.
- It's the only sorting algorithm with a theoretically possible O(1) time complexity hence there's a probability of sorting the array first try.

### Implementation in Dart:

```
List<int> bogo(List<int> arr) {
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
  return arr;
}
```