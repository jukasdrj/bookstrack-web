import 'package:books_tracker/core/data/database/database.dart';

extension ReadingStatusDisplay on ReadingStatus {
  String get label {
    switch (this) {
      case ReadingStatus.wishlist:
        return 'Wishlist';
      case ReadingStatus.toRead:
        return 'To Read';
      case ReadingStatus.reading:
        return 'Reading';
      case ReadingStatus.read:
        return 'Read';
    }
  }
}
