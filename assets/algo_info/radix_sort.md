# Radix sort

## Time complexity

- O(n * k) - n is the number of elements in the list and k is the number of digits in the largest number.

## Brief algorithm description

- Non-comparative style algorithm.
- Sor the numbers based on their least significant digit, then the next digit, and so on, until all digits have been processed.
- Radix sort can be implemented using a stable sorting algorithm (usually counting sort) for each digit position. The stability ensures that the relative order of elements with the same digit value remains unchanged after sorting.
- After processing all digits, the list will be sorted in ascending order

## Implementation in Dart

```Dart

List<int> radix(List<int> list) {
  int max = 0;
  for (int n in list) {
    int digits = n.toString().length;
    if (digits > max) {
      max = digits;
    }
  }

  for (int i = 0; i < max; i++) {
    list = countSort(list, i);
  }
  return list;
}

List<int> countSort(List<int> l, int lookAt) {
  List<List<int>> buckets = [[], [], [], [], [], [], [], [], [], []];
  
  for (int n in l) {
    String number = n.toString();
    int dig = (number.length - 1 - lookAt) < 0 ? 0 : int.parse(number[number.length - 1 - lookAt]);
    
    buckets[dig].add(int.parse(number));
  }
  List<int> nl = [];
  for (int b = 0; b < buckets.length; b++) {
    for (int q = 0; q < buckets[b].length; q++) {
      nl.add(buckets[b][q]);
    }
  }

  return nl;
}
```
