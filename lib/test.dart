// void main() {
//   List<int> a = List.generate(10, (index) => index + 1);

//   List<int> shuffled = a.toList();
//   shuffled.shuffle();

//   print(a);
//   print(selectionSort(shuffled));
//   print(a == selectionSort(shuffled));

//   // List<int> b = [];
//   // print(b);
//   // b.add(2);
//   // print(b);
// }

// List<int> selectionSort(List<int> list) {
//   List<int> sorted = [];

//   List<int> sort(List<int> unSorted) {
//     if (unSorted.isEmpty) return sorted;

//     int smallest = unSorted[0];

//     for (int i = 1; i < unSorted.length; i++) {
//       if (unSorted[i] < smallest) {
//         smallest = unSorted[i];
//       }
//     }
//     sorted.add(smallest);
//     unSorted.remove(smallest);
//     return sort(unSorted);
//   }

//   return sort(list);
// }
