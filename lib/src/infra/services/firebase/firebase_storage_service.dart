import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, QuerySnapshot;

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_storage_service.dart';
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';

class FirebaseStorageService extends IFirebaseStorageService {
  FirebaseStorageService({required this.firebaseStorageDriver});

  final IFirebaseStorageDriver firebaseStorageDriver;

  @override
  Future<Either<Exception, Unit>> docDelete({
    required String collection,
    required String id,
  }) {
    return firebaseStorageDriver.docDelete(collection: collection, id: id);
  }

  @override
  Future<Either<Exception, DocumentSnapshot<Map<String, dynamic>>>> docGet({
    required String doc,
    required String collection,
  }) {
    return firebaseStorageDriver.docGet(doc: doc, collection: collection);
  }

  @override
  Future<Either<Exception, Unit>> docSet({
    required String collectionDoc,
    required Map<String, dynamic> data,
    String? id,
  }) {
    return firebaseStorageDriver.docSet(
      collection: collectionDoc,
      id: id,
      data: data,
    );
  }

  @override
  Future<Either<Exception, Unit>> docUpdate({
    required String collectionDoc,
    required String id,
    required Map<String, dynamic> data,
  }) {
    return firebaseStorageDriver.docUpdate(
      collection: collectionDoc,
      id: id,
      data: data,
    );
  }

  @override
  Future<Either<Exception, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required QuerySnapshotFiltersEntity filters,
  }) {
    return firebaseStorageDriver.getCollection(filters: filters);
  }

  @override
  Future<Either<Exception, Stream<QuerySnapshot<Map<String, dynamic>>>>>
  getCollectionStream({required QuerySnapshotFiltersEntity filters}) {
    return firebaseStorageDriver.getCollectionStream(filters: filters);
  }
}
