void main() {
  // List<int> a = [12, 3, 7, 9, 6, 5, 0, 4, 2, 8, 1];
  List<int> b = [12, 443, 27, 9, 66, 588, 454, 2, 81, 1];
  // final b = [1, 2, 3, 4, 5, 7, 9, 6, 8];

  // print(countSort(a, 1));
  // print(452.toString().length);
  // print(radix(b));
  print(b);

  b = radix(b);
  print(b);
}

List<int> radix(List<int> list) {
  void countSort(int lookAt) {
    List<int> counts10 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    // count
    for (int n in list) {
      String number = n.toString();
      int dig =
          (number.length - 1 - lookAt) < 0 ? 0 : int.parse(number[number.length - 1 - lookAt]);
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

  int max = 0;
  for (int n in list) {
    int digits = n.toString().length;
    if (digits > max) {
      max = digits;
    }
  }
  for (int i = 0; i < max; i++) {
    countSort(i);
  }
  return list;
}

// List<int> radix(List<int> list) {
//   void bucketSort(int lookAt) {
//     List<List<int>> buckets = [[], [], [], [], [], [], [], [], [], []];

//     for (int n in list) {
//       String number = n.toString();
//       int dig =
//           (number.length - 1 - lookAt) < 0 ? 0 : int.parse(number[number.length - 1 - lookAt]);

//       buckets[dig].add(int.parse(number));
//     }
//     List<int> nl = [];
//     for (int b = 0; b < buckets.length; b++) {
//       for (int q = 0; q < buckets[b].length; q++) {
//         nl.add(buckets[b][q]);
//       }
//     }
//     list = [...nl];
//   }

//   int max = 0;
//   for (int n in list) {
//     int digits = n.toString().length;
//     if (digits > max) {
//       max = digits;
//     }
//   }

//   for (int i = 0; i < max; i++) {
//     bucketSort(i);
//   }
//   return list;
// }
