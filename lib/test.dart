void main() {
  // List<int> a = [12, 3, 7, 9, 6, 5, 0, 4, 2, 8, 1];
  List<int> b = [12, 443, 27, 9, 66, 588, 454, 2];
  // final b = [1, 2, 3, 4, 5, 7, 9, 6, 8];

  print(b);

  // b = bitonic(b);

  print(b);
}

// List<int> bitonic(List<int> list) {
//   // given an array arr of length n, this code sorts it in place
//   // all indices run from 0 to n-1
//   int n = list.length;
//   // k is doubled every iteration
//   for (int k = 2; k <= n; k *= 2) {
//     // j is halved at every iteration, with truncation of fractional parts
//     for (int j = k ~/ 2; j > 0; j ~/= 2) {
//       for (int i = 0; i < n; i++) {
//         int l = i ^ j; // in C-like languages this is "i ^ j"
//         if (l > i) {
//           if ((i & k == 0 && list[i] > list[l]) || (i & k != 0 && list[i] < list[l])) {
//             int temp = list[i];
//             list[i] = list[l];
//             list[l] = temp;
//           }
//         }
//       }
//     }
//   }
//   return list;
// }

// List<int> bitonic(List<int> list) {
//   int n = list.length;
//   for (int k = 2; k <= n; k *= 2) {
//     for (int j = k ~/ 2; j > 0; j ~/= 2) {
//       for (int i = 0; i < n; i++) {
//         int l = i ^ j;
//         if (l > i) {
//           if ((i & k == 0 && list[i] > list[l]) || (i & k != 0 && list[i] < list[l])) {
//             int temp = list[i];
//             list[i] = list[l];
//             list[l] = temp;
//             print(list);
//           }
//         }
//       }
//     }
//   }
//   return list;
// }
