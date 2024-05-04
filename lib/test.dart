void main() {
  List<int> a = List.generate(10, (index) => index + 1);

  List<int> shuffled = a.toList();
  shuffled.shuffle();

  print(a);
  print(selecSort(shuffled));
  print(a == selecSort(shuffled));

  // List<int> b = [];
  // print(b);
  // b.add(2);
  // print(b);
}

List<int> selecSort(List<int> list) {
  int length = list.length;

  for (int i = 0; i < length - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < length; j++) {
      if (list[j] < list[minIndex]) {
        minIndex = j;
      }
    }
    if (minIndex != i) {
      int temp = list[minIndex];
      list[minIndex] = list[i];
      list[i] = temp;
    }
  }

  return list;
}
