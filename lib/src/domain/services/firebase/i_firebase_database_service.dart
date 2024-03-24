import 'package:firebase_database/firebase_database.dart';

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';

abstract class IFirebaseDatabaseService {
  Future<Either<Exception, Stream<DatabaseEvent>>> getDocumentStream({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, DataSnapshot>> getDocument({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, Unit>> docSet({
    required Map<String, dynamic> data,
    required String document,
    String? id,
  });

  Future<Either<Exception, DataSnapshot>> docGet({
    required String doc,
    required String document,
  });

  Future<Either<Exception, Unit>> docUpdate({
    required String id,
    required String document,
    required Map<String, dynamic> data,
  });

  Future<Either<Exception, Unit>> docDelete({
    required String document,
    required String id,
  });
}
