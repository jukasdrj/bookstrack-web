import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/data/models/dtos/book_dto.dart';

/// Card displaying a single search result for a book
class BookSearchResultCard extends StatelessWidget {
  final BookDTO book;
  final VoidCallback? onTap;
  final VoidCallback? onAddToLibrary;

  const BookSearchResultCard({
    super.key,
    required this.book,
    this.onTap,
    this.onAddToLibrary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Book Cover
              _buildCover(colorScheme),
              const SizedBox(width: 12),

              // Book Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      book.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (book.authors.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      // Authors
                      Text(
                        _formatAuthors(book.authors),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    // Edition Details
                    if (book.publishedDate != null ||
                        book.publisher != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (book.publishedDate != null)
                            Text(
                              _formatPublishedDate(book.publishedDate!),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          if (book.publishedDate != null &&
                              book.publisher != null)
                            Text(' • ', style: theme.textTheme.bodySmall),
                          if (book.publisher != null)
                            Expanded(
                              child: Text(
                                book.publisher!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ],

                    if (book.isbn.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'ISBN: ${book.isbn}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Add to Library Button
              if (onAddToLibrary != null) ...[
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: onAddToLibrary,
                  icon: const Icon(Icons.add),
                  iconSize: 20,
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                  ),
                  tooltip: 'Add to Library',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCover(ColorScheme colorScheme) {
    // Use coverUrls.small for thumbnails if available, otherwise fall back to coverUrl
    final coverUrl =
        book.coverUrls?.small ?? book.coverUrl ?? book.thumbnailUrl;

    return Container(
      width: 60,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: colorScheme.surfaceContainerHighest,
      ),
      clipBehavior: Clip.antiAlias,
      child: coverUrl != null
          ? CachedNetworkImage(
              imageUrl: coverUrl,
              fit: BoxFit.cover,
              // Bolt: Only set width to preserve aspect ratio and avoid distortion
              memCacheWidth: 120, // 60 * 2 for 2x displays
              // Bolt: Use static placeholder to improve scroll performance
              placeholder: (context, url) => Container(
                color: colorScheme.surfaceContainerHighest,
              ),
              errorWidget: (context, url, error) =>
                  _buildPlaceholder(colorScheme),
            )
          : _buildPlaceholder(colorScheme),
    );
  }

  Widget _buildPlaceholder(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.book_outlined,
          color: colorScheme.onSurfaceVariant,
          size: 24,
        ),
      ),
    );
  }

  String _formatAuthors(List<String> authors) {
    if (authors.isEmpty) return 'Unknown Author';
    if (authors.length == 1) return authors.first;
    if (authors.length == 2) {
      return '${authors.first} & ${authors.last}';
    }
    return '${authors.first} & ${authors.length - 1} others';
  }

  String _formatPublishedDate(String dateString) {
    // Handle partial dates like "1998" or full ISO dates like "1998-09-01"
    if (dateString.length == 4) {
      return dateString; // Just the year
    }

    try {
      final date = DateTime.parse(dateString);
      return '${date.year}';
    } catch (_) {
      return dateString; // Return as-is if parsing fails
    }
  }
}
