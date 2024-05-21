// void main() {
//   List<int> a = [12, 3, 7, 9, 6, 5, 0, 4, 2, 8, 1];
//   List<int> b = [12, 443, 27, 9, 66, 588, 454, 2];
//   // final b = [1, 2, 3, 4, 5, 7, 9, 6, 8];

//   print(b);

//   cocktailShakerSort(b);

//   print(b);
// }

// void cocktailShakerSort(List<int> list) {
//   bool swapped = true;
//   int start = 0;
//   int end = list.length;

//   while (swapped) {
//     swapped = false;

//     // Forward pass
//     for (int i = start; i < end - 1; i++) {
//       if (list[i] > list[i + 1]) {
//         int temp = list[i];
//         list[i] = list[i + 1];
//         list[i + 1] = temp;
//         swapped = true;
//       }
//     }

//     if (!swapped) break;

//     swapped = false;
//     end--;

//     // Backward pass
//     for (int i = end - 1; i > start; i--) {
//       if (list[i] < list[i - 1]) {
//         int temp = list[i];
//         list[i] = list[i - 1];
//         list[i - 1] = temp;
//         swapped = true;
//       }
//     }

//     start++;
//   }
// }
