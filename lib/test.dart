void main() {
  List<int> a = List.generate(10, (index) => index + 1);

  List<int> shuffled = a.toList();
  shuffled.shuffle();

  print(a);
  quickSort(shuffled);
}

Future<void> quickSort(List<int> bars) async {
  //logic
  //startIndex and endIndex only use is to accurately display graphics
  List<int> sort(List<int> barsList) {
    print(barsList);
    if (barsList.length <= 1) return barsList;

    int pivot = barsList[barsList.length ~/ 2];

    List<int> smaller = [];
    List<int> larger = [];

    while (barsList.isNotEmpty) {
      if (barsList[0] <= pivot) {
        smaller.add(barsList[0]);
      } else {
        larger.add(barsList[0]);
      }
      barsList.removeAt(0);
    }
    // smaller = sort(smaller);
    // larger = sort(larger);

    return sort(smaller) + [pivot] + sort(larger);
  }

  print('here');
  bars = sort(bars);
  print(bars);
}
