import 'package:books_tracker/core/data/database/database.dart';
import 'package:books_tracker/core/providers/database_provider.dart';
import 'package:books_tracker/features/review_queue/providers/review_queue_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewQueueScreen extends ConsumerWidget {
  const ReviewQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueAsync = ref.watch(reviewQueueProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Queue'),
        actions: [
          // Debug button to seed data
          IconButton(
            icon: const Icon(Icons.bug_report),
            tooltip: 'Seed Debug Items',
            onPressed: () async {
              await ref.read(databaseProvider).seedDebugItems();
              ref.invalidate(reviewQueueProvider);
            },
          ),
        ],
      ),
      body: queueAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: theme.colorScheme.tertiary,
                  ),
                  const SizedBox(height: 16),
                  Text('All caught up!', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'No items pending review.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _ReviewCard(item: item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _ReviewCard extends ConsumerWidget {
  final DetectedItem item;

  const _ReviewCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isHighConfidence = item.confidence > 0.8;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isHighConfidence
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(item.confidence * 100).toInt()}% Confidence',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isHighConfidence ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Scanned just now', // Placeholder for relative time
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              item.titleGuess,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.authorGuess ?? 'Unknown Author',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(reviewQueueProvider.notifier).rejectItem(item);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  child: const Text('Reject'),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () {
                    ref.read(reviewQueueProvider.notifier).acceptItem(item);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Add to Library'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
