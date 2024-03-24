import '../../../core.dart';

abstract class ILocationService {
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition();
}
