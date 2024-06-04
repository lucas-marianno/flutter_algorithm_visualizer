Future<void> parallelBitonicSort(List<int> list) async {
  // padding to the next power of two
  int originalLength = list.length;
  int n = _nextPowerOf2(originalLength);
  list.addAll(List.filled(n - originalLength, 1 << 31 - 1));

  await _bitonicSort(list, 0, list.length, true);

  // Remove the padding elements
  list.removeRange(originalLength, n);
}

Future<void> _bitonicSort(List<int> list, int low, int count, bool dir) async {
  if (count > 1) {
    int k = count ~/ 2;

    await Future.wait([
      // Sort first half in ascending order
      _bitonicSort(list, low, k, true),
      // Sort second half in descending order
      _bitonicSort(list, low + k, k, false),
    ]);
    // Merge the entire sequence in ascending or descending order
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

void shellSort(List<int> list) {
  int n = list.length;

  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < n; i++) {
      int temp = list[i];

      int j;
      for (j = i; j >= gap && list[j - gap] > temp; j -= gap) {
        list[j] = list[j - gap];
      }

      list[j] = temp;
    }
  }
}
