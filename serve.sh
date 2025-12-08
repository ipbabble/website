#!/bin/bash
# Local development server for AI Templates documentation

export PATH="/opt/homebrew/bin:$PATH"

# Always kill any existing Hugo servers first
echo "Killing any existing Hugo servers..."
pkill -9 -f "hugo server" 2>/dev/null
sleep 2

# Clear caches for clean rebuild
echo "Clearing caches..."
rm -rf public/ resources/ 2>/dev/null

echo "Starting Hugo server for AI Templates documentation..."
echo "Site will be available at: http://localhost:1313/"
echo ""

# Run Hugo with local baseURL override
hugo server \
  --buildDrafts \
  --buildFuture \
  --bind 0.0.0.0 \
  --baseURL "http://localhost:1313/"

