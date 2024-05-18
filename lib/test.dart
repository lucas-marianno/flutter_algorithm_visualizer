// void main() {
//   // List<int> a = [12, 3, 7, 9, 6, 5, 0, 4, 2, 8, 1];
//   List<int> b = [12, 443, 27, 9, 66, 588, 454, 2, 81, 1];
//   // final b = [1, 2, 3, 4, 5, 7, 9, 6, 8];

//   // print(countSort(a, 1));
//   // print(452.toString().length);
//   // print(radix(b));
//   print(b);

//   b = gnomeSort(b);
//   print(b);
// }


// List<int> gnomeSort(List<int> list) {
//   int pos = 0;
//   while (pos < list.length) {
//     if (pos == 0 || list[pos] >= list[pos - 1]) {
//       pos++;
//     } else {
//       // swap
//       int temp = list[pos];
//       list[pos] = list[pos - 1];
//       list[pos - 1] = temp;
//       pos--;
//     }
//   }
//   return list;
// }
