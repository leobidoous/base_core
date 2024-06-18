
import '../../../domain/interfaces/either.dart';
import '../i_app_tracking_driver.dart';

abstract class IFirebaseAnalyticsDriver extends IAppTrackingDriver {
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params});
}
