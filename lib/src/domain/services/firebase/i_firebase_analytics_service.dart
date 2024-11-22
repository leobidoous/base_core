import '../../../domain/interfaces/either.dart';
import '../i_app_tracking_service.dart';

abstract class IFirebaseAnalyticsService extends IAppTrackingService {
  Future<Either<Exception, Unit>> login({
    String? loginMethod,
    required String name,
    required String value,
    Map<String, Object>? params,
  });
  Future<Either<Exception, Unit>> setUserProperty({
    required String name,
    required String value,
  });
}
