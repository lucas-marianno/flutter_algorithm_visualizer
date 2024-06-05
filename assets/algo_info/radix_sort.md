# Radix sort (Base 10)

Radix Sort is a non-comparative integer sorting algorithm that processes individual digits of the numbers. It sorts numbers digit by digit, starting from the least significant digit to the most significant digit using a stable sorting algorithm.

## Usage

Radix Sort is ideal for sorting large lists of integers where the range of values is not significantly larger than the number of items.

### Real-world Use Cases

- **Large Datasets**: Efficient for sorting large lists of numbers where the range of the numbers is not significantly larger than the list size.
- **Database and File Systems**: Useful in scenarios where fixed-length keys are used, such as sorting strings or fixed-length records.

Radix Sort is a powerful algorithm for specific cases where its linear time complexity can outperform more general comparison-based algorithms. Its efficiency depends on the number of digits in the largest number, making it highly suitable for certain types of data.

## Time complexity

Worst-case | Best-case
--- | ---
O(nk) | O(nk)

Where \( n \) is the number of elements and \( k \) is the number of digits in the largest number.

## Algorithm description

- Sor the numbers based on their least significant digit, then the next digit, and so on, until all digits have been processed.
- Radix sort can be implemented using a stable sorting algorithm (usually counting sort) for each digit position. The stability ensures that the relative order of elements, with the same digit value, remains unchanged after sorting.
- After processing all digits, the list will be sorted in ascending order

## Implementations in Dart

### Bucket sort approach

- This is the version used in this app. Although being less efficient due to the creation of many lists to handle the buckets (it can be memory-intensive, especially if the list is large and there are many digits to sort by), it is an easier approach to generate the graphics and animations.

```Dart
List<int> radix(List<int> list) {
  void bucketSort(int lookAt) {
    List<List<int>> buckets = [[], [], [], [], [], [], [], [], [], []];

    // fill buckets
    for (int n in list) {
      final String number = n.toString();
      final int index = number.length - 1 - lookAt;
      final int dig = index < 0 ? 0 : int.parse(number[index]);

      buckets[dig].add(int.parse(number));
    }

    // rebuild from buckets
    List<int> nl = [];
    for (int b = 0; b < buckets.length; b++) {
      for (int q = 0; q < buckets[b].length; q++) {
        nl.add(buckets[b][q]);
      }
    }
    list = [...nl];
  }

  // find max length
  int max = 0;
  for (int n in list) {
    int digits = n.toString().length;
    if (digits > max) {
      max = digits;
    }
  }

  // sort for each digit
  for (int i = 0; i < max; i++) {
    bucketSort(i);
  }
  return list;
}

```

### Counting sort approach

- This uses a fixed-size counting array (of size 10 for decimal digits), which is more memory efficient compared to the bucket approach. The count sort approach involves additional steps such as computing [prefix sums](https://en.wikipedia.org/wiki/Prefix_sum) and rebuilding the list, which can be more complex to implement and understand.

```Dart
void radix(List<int> list) {
  void countSort(int lookAt) {
    List<int> counts10 = List.generate(10, (index) => 0);

    // count
    for (int n in list) {
      final String number = n.toString();
      final int index = number.length - 1 - lookAt;
      final int dig = index < 0 ? 0 : int.parse(number[index]);
      counts10[dig]++;
    }

    // prefix sum
    for (int i = 1; i < counts10.length; i++) {
      counts10[i] += counts10[i - 1];
    }

    // rebuild
    List<int> nl = List.generate(list.length, (index) => 0);
    for (int i = list.length - 1; i >= 0; i--) {
      final String number = list[i].toString();
      final int index = number.length - 1 - lookAt;
      final int dig = index < 0 ? 0 : int.parse(number[index]);

      counts10[dig]--;
      nl[counts10[dig]] = list[i];
    }
    list = [...nl];
  }

  // find max length
  int max = 0;
  for (int n in list) {
    int digits = n.toString().length;
    if (digits > max) {
      max = digits;
    }
  }

  // sort for each digit
  for (int i = 0; i < max; i++) {
    countSort(i);
  }
}

```
