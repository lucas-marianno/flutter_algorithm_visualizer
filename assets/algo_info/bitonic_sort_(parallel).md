# Bitonic sort

Bitonic sort is a parallel sorting algorithm. It sorts by first converting the list into a specific order called a "bitonic sequence" and then uses comparisons to achieve the final sorted output.

## Usage

- It is also used as a construction method for building a sorting network.
- It excels in environments where multiple processors can work on the data simultaneously.
- It is a popular choice for sorting large numbers of elements on an architecture which itself contains a large number of parallel execution units running in lockstep, such as a typical GPU.
- Bitonic sort only works with arrays where the number of elements are a power of two. To sort arrays whose lengths are not a power of 2 using Bitonic Sort, the array must be padded with a high-value element (like infinity) to the next power of 2. After sorting, you can then remove the padding elements.

## Time complexity

Worst-case | Best-case
------- | --------
O(n log² n) | not applicable

## Algorithm description

1. Bitonic Split: The algorithm divides the list into two halves, sorts one half in ascending order and the other half in descending order to create a bitonic sequence.
2. Bitonic Merge: The algorithm then merges the sequence by comparing and swapping elements to form a sorted sequence. This process is repeated, dividing the sequence into smaller bitonic sequences and merging them.

## Implementation in Dart

This implementation uses async to demonstrate parallelization. A true parallel implementation would require the use of [isolates](https://dart.dev/language/isolates), where each isolate runs independently on separate threads or cores.

### Parallel bitonic (recursion)

```Dart
Future<void> parallelBitonicSort(List<int> list) async {
  // pad to the next power of two
  int originalLength = list.length;
  int n = _nextPowerOf2(originalLength);
  list.addAll(List.filled(n - originalLength, 1 << 31 - 1));

  // sort
  await _bitonicSort(list, 0, list.length, true);

  // remove the padding elements
  list.removeRange(originalLength, n);
}

Future<void> _bitonicSort(List<int> list, int low, int count, bool dir) async {
  if (count > 1) {
    int k = count ~/ 2;

    await Future.wait([
      _bitonicSort(list, low, k, true),
      _bitonicSort(list, low + k, k, false),
    ]);
    await _bitonicMerge(list, low, count, dir);
  }
}

Future<void> _bitonicMerge(List<int> list, int low, int count, bool dir) async {
  if (count > 1) {
    int k = count ~/ 2;
    for (int i = low; i < low + k; i++) {
      if (dir == (list[i] > list[i + k])) {
        int temp = list[i];
        list[i] = list[i + k];
        list[i + k] = temp;
      }
    }
    await Future.wait([
      _bitonicMerge(list, low, k, dir),
      _bitonicMerge(list, low + k, k, dir),
    ]);
  }
}

int _nextPowerOf2(int n) {
  int power = 1;
  while (power < n) {
    power *= 2;
  }
  return power;
}
```
