import '../entities/position_entity.dart' show PositionEntity;
import '../failures/i_location_failure.dart' show ILocationFailure;
import '../interfaces/either.dart' show Either;

abstract class ILocationService {
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition();
}
