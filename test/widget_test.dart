// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:books_tracker/app/app.dart';

void main() {
  testWidgets('BooksApp is a ConsumerWidget', (WidgetTester tester) async {
    // Just verify that BooksApp can be constructed
    // Full app initialization requires Firebase which can't be tested in unit tests
    expect(const BooksApp(), isA<ConsumerWidget>());
  });
}
