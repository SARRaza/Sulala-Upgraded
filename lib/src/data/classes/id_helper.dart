class IdHelper {
  /// Converts a string of letters to a unique index number.
  /// Assumes letters are in ASCII range.
  static int lettersToIndex(String letters) {
    return letters.codeUnits.fold(
        0, (int result, unit) => result * 26 + (unit - 'A'.codeUnitAt(0) + 1));
  }
}
