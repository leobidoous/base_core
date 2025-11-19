import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseFirestore, Query, QuerySnapshot;

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';

class FirebaseStorageDriver extends IFirebaseStorageDriver {
  FirebaseStorageDriver({required this.crashLog});

  final CrashLog crashLog;

  FirebaseFirestore get instance {
    try {
      return FirebaseFirestore.instance;
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, Stream<QuerySnapshot<Map<String, dynamic>>>>>
  getCollectionStream({required QuerySnapshotFiltersEntity filters}) async {
    try {
      Query<Map<String, dynamic>> instance = this.instance.collection(
        filters.collection,
      );

      if (filters.whereFieldIsEqualTo != null) {
        filters.whereFieldIsEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsNotEqualTo != null) {
        filters.whereFieldIsNotEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isNotEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThan != null) {
        filters.whereFieldIsGreaterThan?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThan: e.value);
        });
      }

      if (filters.whereFieldIsLessThan != null) {
        filters.whereFieldIsLessThan?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThan: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsLessThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIn != null) {
        filters.whereFieldIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereIn: e.value);
        });
      }

      if (filters.whereFieldNotIn != null) {
        filters.whereFieldNotIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereNotIn: e.value);
        });
      }

      if (filters.orderByField.isNotEmpty) {
        instance = instance.orderBy(
          filters.orderByField,
          descending: filters.orderDescending,
        );
      }

      if (filters.limit != null) {
        instance = instance.limit(filters.limit!);
      }

      return Right(instance.snapshots());
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required QuerySnapshotFiltersEntity filters,
  }) async {
    try {
      Query<Map<String, dynamic>> instance = this.instance.collection(
        filters.collection,
      );

      if (filters.whereFieldIsEqualTo != null) {
        filters.whereFieldIsEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsNotEqualTo != null) {
        filters.whereFieldIsNotEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isNotEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThan != null) {
        filters.whereFieldIsGreaterThan?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThan: e.value);
        });
      }

      if (filters.whereFieldIsLessThan != null) {
        filters.whereFieldIsLessThan?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThan: e.value);
        });
      }

      if (filters.whereFieldIsGreaterThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isGreaterThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIsLessThanOrEqualTo != null) {
        filters.whereFieldIsGreaterThanOrEqualTo?.entries.forEach((e) {
          instance = instance.where(e.key, isLessThanOrEqualTo: e.value);
        });
      }

      if (filters.whereFieldIn != null) {
        filters.whereFieldIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereIn: e.value);
        });
      }

      if (filters.whereFieldNotIn != null) {
        filters.whereFieldNotIn?.entries.forEach((e) {
          instance = instance.where(e.key, whereNotIn: e.value);
        });
      }

      if (filters.orderByField.isNotEmpty) {
        instance = instance.orderBy(
          filters.orderByField,
          descending: filters.orderDescending,
        );
      }

      if (filters.limit != null) {
        instance = instance.limit(filters.limit!);
      }

      return Right(await instance.get());
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docSet({
    required Map<String, dynamic> data,
    required String collection,
    String? id,
  }) async {
    try {
      await instance.collection(collection).doc(id).set(data);
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, DocumentSnapshot<Map<String, dynamic>>>> docGet({
    required String collection,
    required String doc,
  }) async {
    try {
      final response = await instance.collection(collection).doc(doc).get();
      return Right(response);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docUpdate({
    required Map<String, dynamic> data,
    required String collection,
    required String id,
  }) async {
    try {
      await instance.collection(collection).doc(id).update(data);
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> docDelete({
    required String collection,
    required String id,
  }) async {
    try {
      await instance.collection(collection).doc(id).delete();
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }
}
