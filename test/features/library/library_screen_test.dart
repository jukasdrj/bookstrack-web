import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:books_tracker/features/library/screens/library_screen.dart';
import 'package:books_tracker/features/library/providers/library_providers.dart';
import 'package:books_tracker/core/data/database/database.dart';

void main() {
  testWidgets('LibraryScreen displays empty state when no works', (
    WidgetTester tester,
  ) async {
    // Mock the provider to return empty list
    final container = ProviderContainer(
      overrides: [
        watchLibraryWorksProvider.overrideWith((ref) => Stream.value([])),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: LibraryScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Check that the empty state is displayed
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Your library is empty'), findsOneWidget);
    expect(
      find.text('Start adding books to track your reading journey'),
      findsOneWidget,
    );
  });

  testWidgets('LibraryScreen shows loading indicator', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        watchLibraryWorksProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: LibraryScreen()),
      ),
    );

    // Should show loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
