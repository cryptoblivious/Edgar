/// Capitalizes the first letter of each word in the given [input] string.
/// If [firstWordOnly] is `true`, only the first word is capitalized, and the rest are left unchanged.
///
/// Returns the capitalized string.
String capitalize(String input, {bool firstWordOnly = false}) {
  if (input.isEmpty) return input;

  List<String> words = input.split(' ');
  List<String> capitalizedWords = [];

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (word.isNotEmpty) {
      String capitalizedWord = word[0].toUpperCase() + word.substring(1);

      if (firstWordOnly && i > 0) {
        capitalizedWords.add(word);
      } else {
        capitalizedWords.add(capitalizedWord);
      }
    }
  }
  return capitalizedWords.join(' ');
}
