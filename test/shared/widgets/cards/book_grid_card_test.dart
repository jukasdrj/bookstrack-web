import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/shared/widgets/cards/book_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock WorkWithLibraryStatus since we can't easily instantiate the full database structure
// For this test, we just need a class that looks like it
class MockWorkWithLibraryStatus implements WorkWithLibraryStatus {
  @override
  final ReadingStatus? status;

  @override
  Work get work => throw UnimplementedError(); // Not needed for status dot test

  @override
  Edition? get edition => null;

  @override
  UserLibraryEntry? get libraryEntry => null;

  @override
  String get displayAuthor => "Author";

  @override
  String get id => "1";

  @override
  String get title => "Title";

  @override
  String? get subtitle => null;

  @override
  String? get author => "Author";

  @override
  String? get coverImageURL => null;

  @override
  String? get thumbnailURL => null;

  @override
  double? get readingProgress => null;

  const MockWorkWithLibraryStatus({this.status});
}

void main() {
  testWidgets('BookGridCard status dot has semantic label and tooltip',
      (WidgetTester tester) async {
    // Arrange
    const status = ReadingStatus.reading;
    const workData = MockWorkWithLibraryStatus(status: status);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookGridCard(bookData: workData),
        ),
      ),
    );

    // Act
    final semanticsFinder = find.byWidgetPredicate((widget) {
      if (widget is Semantics) {
        return widget.label == 'Status: Reading';
      }
      return false;
    });

    final tooltipFinder = find.byWidgetPredicate((widget) {
      if (widget is Tooltip) {
        return widget.message == 'Reading';
      }
      return false;
    });

    // Assert
    expect(semanticsFinder, findsOneWidget);
    expect(tooltipFinder, findsOneWidget);
  });
}
