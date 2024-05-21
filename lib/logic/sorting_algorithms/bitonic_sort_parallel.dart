import 'package:algorithm_visualizer/widgets/bar.dart';

Future<void> parallelBitonic(
  List<Bar> bars,
  Future<void> Function(List<Bar> newBars) updateBarsGraph,
  void Function() registerOperation,
  bool Function() hasStopped,
) async {
// List<int> parallelBitonic(List<int> list) {
//   void bitonicMerge(List<int> arr, int low, int cnt, bool dir) {
//     if (cnt > 1) {
//       int k = cnt ~/ 2;
//       for (int i = low; i < low + k; i++) {
//         if (dir == (arr[i] > arr[i + k])) {
//           // Swap elements
//           int temp = arr[i];
//           arr[i] = arr[i + k];
//           arr[i + k] = temp;
//         }
//       }
//       bitonicMerge(arr, low, k, dir);
//       bitonicMerge(arr, low + k, k, dir);
//     }
//   }

//   void bitonicSort(List<int> arr, int low, int cnt, bool dir) {
//     if (cnt > 1) {
//       int k = cnt ~/ 2;

//       // Sort first half in ascending order and second half in descending order
//       bitonicSort(arr, low, k, true);
//       bitonicSort(arr, low + k, k, false);

//       // Merge the entire sequence in ascending or descending order
//       bitonicMerge(arr, low, cnt, dir);
//     }
//   }

//   void sort(List<int> arr, int n, bool up) {
//     bitonicSort(arr, 0, n, up);
//   }

//   sort(list, list.length, true);

//   return list;
// }
}
