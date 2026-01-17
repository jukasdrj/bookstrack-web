import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/search/screens/search_screen.dart';

part 'router_web.g.dart';

/// Web-specific router with simplified navigation
///
/// **Only includes Search feature** - Library, Scanner, and Insights
/// require local database which isn't available on web.
///
/// Users can search for books and view results, but can't save to library yet.
/// Future: Add Firestore-only library management on web.
@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/search',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      // Redirect all other paths to search
      GoRoute(path: '/', redirect: (context, state) => '/search'),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('BooksTrack')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go('/search'),
              child: const Text('Go to Search'),
            ),
          ],
        ),
      ),
    ),
  );
}
