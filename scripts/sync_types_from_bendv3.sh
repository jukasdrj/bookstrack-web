#!/bin/bash
# Sync canonical TypeScript types from BendV3 to Flutter project
#
# Usage:
#   ./scripts/sync_types_from_bendv3.sh
#
# This creates a TypeScript reference copy in test/fixtures/
# that can be used for documentation and validation

set -e

BENDV3_PATH="${BENDV3_PATH:-../bendv3}"
OUTPUT_DIR="test/fixtures/bendv3_types"

if [ ! -d "$BENDV3_PATH" ]; then
  echo "❌ BendV3 not found at: $BENDV3_PATH"
  echo "Set BENDV3_PATH environment variable or clone bendv3 to ../bendv3"
  exit 1
fi

echo "🔄 Syncing TypeScript types from BendV3..."

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Copy canonical types
cp "$BENDV3_PATH/src/types/canonical.ts" "$OUTPUT_DIR/canonical.ts"
cp "$BENDV3_PATH/src/types/enums.ts" "$OUTPUT_DIR/enums.ts"
cp "$BENDV3_PATH/src/api-v3/schemas/book.ts" "$OUTPUT_DIR/book-schema.ts"

# Add warning header
for file in "$OUTPUT_DIR"/*.ts; do
  echo "/**
 * SYNCED FROM BENDV3 - DO NOT EDIT
 *
 * Source: $BENDV3_PATH
 * Synced: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
 *
 * This is a reference copy for documentation and validation.
 * Run './scripts/sync_types_from_bendv3.sh' to update.
 */
$(cat "$file")" > "$file"
done

echo "✅ Synced TypeScript types to: $OUTPUT_DIR"
echo ""
echo "📝 Files synced:"
ls -lh "$OUTPUT_DIR"
