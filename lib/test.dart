// void main() {
//   List<int> a = List.generate(10, (index) => index + 1);

//   List<int> shuffled = a.toList();
//   shuffled.shuffle();

//   print(a);
//   print(insertion(shuffled));
//   print(a == insertion(shuffled));

//   // List<int> b = [];
//   // print(b);
//   // b.add(2);
//   // print(b);
// }

// List<int> insertion(List<int> list) {
//   for (int i = 1; i < list.length; i++) {
//     int key = list[i];
//     int j = i - 1;

//     // Move elements of list[0..i-1], that are greater than key,
//     // to one position ahead of their current position
//     while (j >= 0 && list[j] > key) {
//       list[j + 1] = list[j];
//       j--;
//     }
//     list[j + 1] = key;
//   }
//   return list;
// }
