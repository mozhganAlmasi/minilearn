
class LocalDataException implements Exception {
  final String message;
  LocalDataException([this.message = "Local data error"]);
}

/// Exception عمومی
class UnknownException implements Exception {
  final String message;
  UnknownException([this.message = "Unknown error occurred"]);
}
