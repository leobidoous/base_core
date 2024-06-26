import '../../../domain/interfaces/either.dart';
import '../i_app_tracking_driver.dart';

abstract class IFirebaseAnalyticsDriver extends IAppTrackingDriver {
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params});
  Future<Either<Exception, Unit>> login({
    String? loginMethod,
    required String name,
    required String value,
    Map<String, Object>? params,
  });
}
