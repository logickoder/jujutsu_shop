abstract class Copyable<T> {
  T copy();
}

extension StringExtension on String? {
  bool get isBlank {
    return this == null || this?.isEmpty == true;
  }
}
