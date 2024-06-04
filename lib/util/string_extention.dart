extension StringExtention on String {
  String toTitleCase() {
    String newS = '';
    for (String s in split(' ')) {
      newS += '${s[0].toUpperCase()}${s.substring(1).toLowerCase()} ';
    }
    return newS;
  }
}
