import 'package:firebase_database/firebase_database.dart';

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_database_service.dart';
import '../../drivers/firebase/i_firebase_database_driver.dart';

class FirebaseDatabaseService extends IFirebaseDatabaseService {
  FirebaseDatabaseService({required this.firebaseDatabaseDriver});

  final IFirebaseDatabaseDriver firebaseDatabaseDriver;

  @override
  Future<Either<Exception, Unit>> docDelete({
    required String document,
    required String id,
  }) {
    return firebaseDatabaseDriver.docDelete(document: document, id: id);
  }

  @override
  Future<Either<Exception, DataSnapshot>> docGet({
    required String doc,
    required String document,
  }) {
    return firebaseDatabaseDriver.docGet(doc: doc, document: document);
  }

  @override
  Future<Either<Exception, Unit>> docSet({
    required Map<String, dynamic> data,
    required String document,
    String? id,
  }) {
    return firebaseDatabaseDriver.docSet(data: data, document: document);
  }

  @override
  Future<Either<Exception, Unit>> docUpdate({
    required String id,
    required String document,
    required Map<String, dynamic> data,
  }) {
    return firebaseDatabaseDriver.docUpdate(
      id: id,
      document: document,
      data: data,
    );
  }

  @override
  Future<Either<Exception, DataSnapshot>> getDocument({
    required QuerySnapshotFiltersEntity filters,
  }) {
    return firebaseDatabaseDriver.getDocument(filters: filters);
  }

  @override
  Future<Either<Exception, Stream<DatabaseEvent>>> getDocumentStream({
    required QuerySnapshotFiltersEntity filters,
  }) {
    return firebaseDatabaseDriver.getDocumentStream(filters: filters);
  }
}
