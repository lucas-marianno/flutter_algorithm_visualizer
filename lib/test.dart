void mergeSort(List<int> list) {
  if (list.length <= 1) return;

  int mid = list.length ~/ 2;
  List<int> left = list.sublist(0, mid);
  List<int> right = list.sublist(mid);

  mergeSort(left);
  mergeSort(right);

  _merge(list, left, right);
}

void _merge(List<int> list, List<int> left, List<int> right) {
  int i = 0;
  while (left.isNotEmpty && right.isNotEmpty) {
    if (left[0] <= right[0]) {
      list[i] = left.removeAt(0);
    } else {
      list[i] = right.removeAt(0);
    }
    i++;
  }
  while (left.isNotEmpty) {
    list[i] = left.removeAt(0);
    i++;
  }
  while (right.isNotEmpty) {
    list[i] = right.removeAt(0);
    i++;
  }
}
