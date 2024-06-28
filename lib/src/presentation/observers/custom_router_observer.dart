import '../../domain/interfaces/router_observer.dart';

class CustomRouterObserver extends RouterObserver {
  factory CustomRouterObserver() => _instance;

  CustomRouterObserver._internal();
  static final CustomRouterObserver _instance =
      CustomRouterObserver._internal();
}
