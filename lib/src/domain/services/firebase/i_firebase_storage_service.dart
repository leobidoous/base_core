import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, QuerySnapshot;

import '../../../domain/entities/query_snapshot_filters_entity.dart';
import '../../../domain/interfaces/either.dart';


abstract class IFirebaseStorageService {

  Future<Either<Exception, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCollectionStream({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, QuerySnapshot<Map<String, dynamic>>>> getCollection({
    required QuerySnapshotFiltersEntity filters,
  });

  Future<Either<Exception, Unit>> docSet({
    required String collectionDoc,
    required Map<String, dynamic> data,
    String? id,
  });

  Future<Either<Exception, DocumentSnapshot<Map<String, dynamic>>>> docGet({
    required String doc,
    required String collection,
  });

  Future<Either<Exception, Unit>> docUpdate({
    required String collectionDoc,
    required String id,
    required Map<String, dynamic> data,
  });

  Future<Either<Exception, Unit>> docDelete({
    required String collection,
    required String id,
  });
}
