import 'package:flutter/widgets.dart';

import '../../../core/utils/base_path.dart';
import 'i_navigation_arguments_driver.dart';

///
/// Interface for navigation
///
abstract class INavigationDriver {
  /// Returns the [INavigationArgumentsDriver] instance
  INavigationArgumentsDriver get args;

  /// Set the new [INavigationArgumentsDriver] instance
  void setArgs(Object value);

  /// value is '/';
  String get initialRoute;

  ///
  /// Current context
  ///
  BuildContext? get context;

  ///
  /// Current path
  ///
  BasePath get basePath;

  ///
  /// Push a named route to the stack
  ///
  Future<T?> pushNamed<T extends Object?>(
    Object path, {
    Object? arguments,
    bool forRoot = true,
  });

  ///
  /// Push and replace a named route
  ///
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    Object path, {
    Object? arguments,
    bool forRoot = true,
  });

  ///
  /// Pop Until or Push and replace a named route
  ///
  Future<T?>
      popUntilOrPushReplacementNamed<T extends Object?, TO extends Object?>(
    Object path, {
    Object? arguments,
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Pop Until or Push a named route
  ///
  Future<T?> popUntilOrPushNamed<T extends Object?, TO extends Object?>(
    Object path, {
    Object? arguments,
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Push a named route and remove routes according to [predicate]
  ///
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    Object path,
    bool Function(Route) predicate, {
    Object? arguments,
    bool forRoot = true,
  });

  ///
  /// Pop until and Push a named route
  ///
  Future<T?> popUntilAndPushNamed<T extends Object?>(
    Object firstPath,
    Object secondpath, {
    Object? arguments,
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Pop until and Push and replace a named route
  ///
  Future<T?> popUntilAndPushReplacementNamed<T extends Object?>(
    Object firstPath,
    Object secondpath, {
    Object? arguments,
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Removes all previous routes and navigate to a route.
  ///
  void navigate(Object path, {dynamic arguments});

  ///
  /// Pop the current route out of the stack
  ///
  void pop<T extends Object?>({T? response, BuildContext? context});

  ///
  /// Calls pop repeatedly on the navigator until the predicate returns true.
  ///
  void popUntil(
    Object path, {
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Verify if can pop until path.
  ///
  bool canPopUntil<T extends Object?>(Object path);

  /// Navigate to a new screen.
  ///
  /// ```
  /// Modular.to.push(MaterialPageRoute(builder: (context) => HomePage()),);
  /// ```
  Future<T?> push<T extends Object?>(Route<T> route);

  ///
  /// Return true if route can pop
  ///
  bool canPop(BuildContext context);

  /// Pop the current route off the navigator and navigate to a route
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    Object routeName, {
    TO? result,
    Object? arguments,
    bool forRoot = true,
  });

  /// Pop the current route off the navigator and replace a named route
  Future<T?> popAndPushReplacementNamed<T extends Object?, TO extends Object?>(
    Object path, {
    TO? result,
    Object? arguments,
    bool forRoot = true,
    BuildContext? context,
  });

  ///
  /// Consults the current route's [Route] method, and acts accordingly,
  /// potentially popping the route as a result;
  /// returns whether the pop request should be considered handled.
  ///
  Future<bool> maybePop<T extends Object?>([T? result]);

  /// Register a closure to be called when the object notifies its listeners.
  void addListener(VoidCallback listener);

  /// Remove a previously registered closure from the list of closures that the
  /// object notifies.
  void removeListener(VoidCallback listener);

  ///
  /// Current navigation history
  ///
  List<String> get history;
}
