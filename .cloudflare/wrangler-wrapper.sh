#!/bin/bash
# Wrangler Wrapper Script
# Ensures always using latest Cloudflare Wrangler version
#
# Usage: ./.cloudflare/wrangler-wrapper.sh [wrangler commands]
# Example: ./.cloudflare/wrangler-wrapper.sh pages deploy build/web

set -e

# Check if wrangler is installed globally
if command -v wrangler &> /dev/null; then
    # Use global wrangler (already at latest 4.59.2)
    wrangler "$@"
else
    # Fallback to npx with explicit @latest
    npx wrangler@latest "$@"
fi
