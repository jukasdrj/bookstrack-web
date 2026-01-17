import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router_web.dart';
import 'theme.dart';

/// Web-specific BooksTrack app
///
/// Simplified version for web deployment that only includes search functionality.
/// Uses Firestore for data storage instead of local SQLite database.
class BooksAppWeb extends ConsumerWidget {
  const BooksAppWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'BooksTrack - Book Search',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
