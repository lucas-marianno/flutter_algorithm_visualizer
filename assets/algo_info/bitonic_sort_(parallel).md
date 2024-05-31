# Bitonic sort

- Bitonic mergesort is a parallel algorithm for sorting. It is also used as a construction method for building a sorting network.
- This makes it a popular choice for sorting large numbers of elements on an architecture which itself contains a large number of parallel execution units running in lockstep, such as a typical GPU.
- Bitonic sort only works with arrays where the number of elements are a power of two. To sort arrays whose lengths are not a power of 2 using Bitonic Sort, the array must be padded with a high-value element (like infinity) to the next power of 2. After sorting, you can then remove the padding elements.

## Time complexity

- O(n log^2 n)

## Brief algorithm description

- The algorithm divides the list into two halves, sorts one half in ascending order and the other half in descending order to create a bitonic sequence. It then merges the sequence by comparing and swapping elements to form a sorted sequence. This process is repeated, dividing the sequence into smaller bitonic sequences and merging them.
- This implementation uses async to demonstrate parallelization. A true parallel implementation would require the use of isolates, where each isolate runs independently on separate threads or cores.

## Implementation in Dart

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
        _swap(list, i, i + k);
      }
    }
    await Future.wait([
      _bitonicMerge(list, low, k, dir),
      _bitonicMerge(list, low + k, k, dir),
    ]);
  }
}

void _swap(List<int> list, int i, int j) {
  int tempValue = list[i];
  list[i] = list[j];
  list[j] = tempValue;
}

int _nextPowerOf2(int n) {
  int power = 1;
  while (power < n) {
    power *= 2;
  }
  return power;
}
```
