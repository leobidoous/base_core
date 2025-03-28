import 'package:firebase_database/firebase_database.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_database_driver.dart';

class FirebaseDatabaseDriver extends IFirebaseDatabaseDriver {
  FirebaseDatabaseDriver({required this.crashLog});

  final CrashLog crashLog;

  FirebaseDatabase get instance {
    try {
      return FirebaseDatabase.instance;
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, Unit>> docDelete({
    required String document,
    required String id,
  }) async {
    try {
      final ref = instance.ref(document).child(document);
      await ref.remove();
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, DataSnapshot>> docGet({
    required String doc,
    required String document,
  }) async {
    try {
      final ref = instance.ref(doc).child(document);
      final value = await ref.get();
      return Right(value);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docSet({
    required Map<String, dynamic> data,
    required String document,
    String? id,
  }) async {
    try {
      final ref = instance.ref(document).child(document);
      await ref.set(data);
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docUpdate({
    required String id,
    required String document,
    required Map<String, dynamic> data,
  }) async {
    try {
      final ref = instance.ref(document).child(document);
      await ref.update(data);
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, DataSnapshot>> getDocument({
    required QuerySnapshotFiltersEntity filters,
  }) async {
    try {
      final ref = instance.ref(filters.collection);
      return Right(await ref.get());
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Stream<DatabaseEvent>>> getDocumentStream({
    required QuerySnapshotFiltersEntity filters,
  }) async {
    try {
      final ref = instance.ref(filters.collection);
      return Right(ref.onValue);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }
}
