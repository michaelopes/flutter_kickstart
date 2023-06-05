class NestedJsonParser {
  static T? resolve<T>(
      {Map<String, dynamic>? json, required String path, T? defaultValue}) {
    var value = path.split('.').fold(json, (dynamic previous, index) {
      if (previous != null) {
        return previous[index];
      }
      return null;
    });

    return (value as T?) ?? defaultValue;
  }
}
