# Bitonic sort

- Bitonic mergesort is a parallel algorithm for sorting. It is also used as a construction method for building a sorting network.
- This makes it a popular choice for sorting large numbers of elements on an architecture which itself contains a large number of parallel execution units running in lockstep, such as a typical GPU.
- Bitonic sort only works with arrays where the number of elements are a power of two. To sort arrays whose lengths are not a power of 2 using Bitonic Sort, the array must be padded with a high-value element (like infinity) to the next power of 2. After sorting, you can then remove the padding elements.

## Time complexity

- O(n log^2 n)

## Brief algorithm description

- The algorithm divides the list into two halves, sorts one half in ascending order and the other half in descending order to create a bitonic sequence. It then merges the sequence by comparing and swapping elements to form a sorted sequence. This process is repeated, dividing the sequence into smaller bitonic sequences and merging them.
- This version of the bitonic sorting algorithm uses sequential processing in order to promote easier visualization.

## Implementations in Dart

### Sequencial processing (Recursion-free)

```Dart
void sequencialBitonicSort(List<int> list) {
  int nextPowerOf2(int n) {
    int power = 1;
    while (power < n) {
      power *= 2;
    }
    return power;
  }
  
  // padding to the next power of two
  int originalLength = list.length;
  int n = nextPowerOf2(originalLength);
  list.addAll(List.filled(n - originalLength, 1 << 31 - 1));

  // sorting
  int n = list.length;
  for (int k = 2; k <= n; k = 2 * k) {
    for (int j = k ~/ 2; j > 0; j = j ~/ 2) {
      for (int i = 0; i < n; i++) {
        int l = i ^ j;
        if (l > i) {
          if (((i & k) == 0 && list[i] > list[l]) || ((i & k) != 0 && list[i] < list[l])) {
            int temp = list[i];
            list[i] = list[j];
            list[j] = temp;
          }
        }
      }
    }
  }

  // Remove the padding elements
  list.removeRange(originalLength, n);
}
```
