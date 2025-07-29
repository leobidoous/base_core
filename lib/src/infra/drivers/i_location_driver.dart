import '../../domain/entities/position_entity.dart' show PositionEntity;
import '../../domain/failures/i_location_failure.dart' show ILocationFailure;
import '../../domain/interfaces/either.dart' show Either;

abstract class ILocationDriver {
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition();
}
