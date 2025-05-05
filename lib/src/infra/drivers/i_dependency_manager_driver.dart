///
/// Utility class to manage dependencies
///
// ignore: one_member_abstracts
abstract class IDependencyManagerDriver {
  ///
  /// Get an instance of type T from the DM
  ///
  T get<T extends Object>({String? key});

  /// Disposes an object of type T from the DM
  bool dispose<T extends Object>({String? key});
}
