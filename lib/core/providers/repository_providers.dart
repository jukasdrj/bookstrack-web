import 'package:books_tracker/core/data/repositories/firestore_library_repository.dart';
import 'package:books_tracker/core/domain/repositories/library_repository.dart';
import 'package:books_tracker/core/providers/database_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Firestore instance provider
@riverpod
FirebaseFirestore firestore(FirestoreRef ref) {
  return FirebaseFirestore.instance;
}

/// Library repository provider (Firestore-backed with offline support)
@riverpod
LibraryRepository libraryRepository(LibraryRepositoryRef ref) {
  final database = ref.watch(databaseProvider);
  final firestore = ref.watch(firestoreProvider);

  return FirestoreLibraryRepository(
    localDb: database,
    firestore: firestore,
  );
}
