class Capitalize {
  String firstWord(String word) {
    if (word.isEmpty) {
      return "";
    }
    return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
  }
}
