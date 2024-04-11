import '../../../base_core.dart';

abstract class ILocationDriver {
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition();
}
