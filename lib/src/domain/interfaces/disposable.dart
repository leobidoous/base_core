/// A class which implements [Disposable] can be disposed automatically
/// once user leaves a Module
//ignore:one_member_abstracts
mixin Disposable {
  /// Disposes controllers, streams, etc.
  void dispose();
}
