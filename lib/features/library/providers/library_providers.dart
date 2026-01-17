import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:books_tracker/core/data/database/database.dart';

import '../../../core/providers/database_provider.dart';

part 'library_providers.g.dart';

/// Sort options for library
enum SortBy { recentlyAdded, title, author, recentlyRead, rating }

/// Filter by reading status - Riverpod 3.x Notifier
@riverpod
class LibraryFilter extends _$LibraryFilter {
  @override
  ReadingStatus? build() => null;

  void setFilter(ReadingStatus? status) => state = status;
  void clearFilter() => state = null;
}

/// Sort option for library
@riverpod
class LibrarySortOption extends _$LibrarySortOption {
  @override
  SortBy build() => SortBy.recentlyAdded;

  void setSortBy(SortBy sortBy) => state = sortBy;
}

/// Search query for library
@riverpod
class LibrarySearchQuery extends _$LibrarySearchQuery {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
  void clearQuery() => state = '';
}

/// Watch library works with filtering, sorting, and search
@riverpod
Stream<List<WorkWithLibraryStatus>> watchLibraryWorks(Ref ref) {
  final database = ref.watch(databaseProvider);
  final filter = ref.watch(libraryFilterProvider);
  final sortBy = ref.watch(librarySortOptionProvider);
  final searchQuery = ref.watch(librarySearchQueryProvider);

  return database
      .watchLibrary(filterStatus: filter, searchQuery: searchQuery)
      .map((works) => _sortWorks(works, sortBy));
}

/// Helper function to sort works
List<WorkWithLibraryStatus> _sortWorks(
  List<WorkWithLibraryStatus> works,
  SortBy sortBy,
) {
  final sorted = List<WorkWithLibraryStatus>.from(works);

  switch (sortBy) {
    case SortBy.recentlyAdded:
      sorted.sort((a, b) {
        final aDate = a.libraryEntry?.createdAt;
        final bDate = b.libraryEntry?.createdAt;
        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return bDate.compareTo(aDate);
      });
    case SortBy.title:
      sorted.sort((a, b) => a.work.title.compareTo(b.work.title));
    case SortBy.author:
      sorted.sort((a, b) => a.displayAuthor.compareTo(b.displayAuthor));
    case SortBy.recentlyRead:
      sorted.sort((a, b) {
        final aDate = a.libraryEntry?.finishedAt;
        final bDate = b.libraryEntry?.finishedAt;
        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return bDate.compareTo(aDate);
      });
    case SortBy.rating:
      sorted.sort((a, b) {
        final aRating = a.libraryEntry?.personalRating ?? 0;
        final bRating = b.libraryEntry?.personalRating ?? 0;
        return bRating.compareTo(aRating);
      });
  }

  return sorted;
}
