import 'dart:developer' show log;

import 'package:flutter/material.dart' show NavigatorObserver, Route;

class RouterObserver extends NavigatorObserver {

  final List<Route<dynamic>?> _routeStack = List.empty(growable: true);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);
    log('didPush: ${_routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_routeStack.isNotEmpty) _routeStack.removeLast();
    log('didPop: ${_routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (_routeStack.isNotEmpty) _routeStack.removeLast();
    log('didRemove: ${_routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (_routeStack.isNotEmpty) _routeStack.removeLast();
    _routeStack.add(newRoute);
    log('didReplace: ${_routeStack.map((route) => route?.settings.name)}');
  }

  List<String?> get getNavigateHistory {
    return _routeStack.map((e) => e?.settings.name).toList();
  }
}
