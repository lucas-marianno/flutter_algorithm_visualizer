void main() {
  final a = [3, 7, 9, 6, 5, 4, 2, 8, 1];
  // final b = [1, 2, 3, 4, 5, 7, 9, 6, 8];

  blah(a);
}

blah(List<int> list) {
  printer(
    List<int> smaller,
    List<int> equal,
    List<int> larger,
  ) {
    const String reset = '\u001b[0m';
    const String green = '\u001b[32m';
    const String yellow = '\u001b[33m';
    const String blue = '\u001b[34m';
    final a = '$blue $smaller $reset';
    final b = '$yellow $equal $reset';
    final c = '$green $larger $reset';
    print('$a$b$c');
  }

  List<int> sort(List<int> barsList, {List<int>? pre, List<int>? pos}) {
    pre = pre ?? [];
    pos = pos ?? [];
    // print('pre: $pre | list: $barsList | pos: $pos');
    if (barsList.isEmpty) return barsList;

    List<int> smaller = [];
    List<int> equal = [];
    List<int> larger = [];

    int pivotIndex = barsList.length ~/ 2;
    int pivotValue = barsList[pivotIndex];

    while (barsList.isNotEmpty) {
      // print('pivot: $pivotValue | [0]: ${barsList[0]}');
      printer(pre + smaller, barsList, larger + pos);
      if (barsList[0] < pivotValue) {
        smaller.add(barsList[0]);
      } else if (barsList[0] > pivotValue) {
        larger.add(barsList[0]);
      } else {
        equal.add(barsList[0]);
      }

      barsList.removeAt(0);
      // printer(pre + smaller, equal, larger + pos);
    }

    //sort smaller
    smaller = sort(smaller, pre: pre, pos: equal + larger + pos);
    // sort larger
    larger = sort(larger, pre: pre + smaller + equal, pos: pos);
    return smaller + equal + larger;
  }

  print(sort([...list]));
}
