#!/bin/bash
# Local development server for AI Templates documentation

export PATH="/opt/homebrew/bin:$PATH"

# Kill any existing Hugo servers
echo "Checking for existing Hugo servers..."
if pgrep -f "hugo server" > /dev/null; then
    echo "Killing existing Hugo server..."
    pkill -9 -f "hugo server"
    sleep 2
fi

echo "Starting Hugo server for AI Templates documentation..."
echo "Site will be available at: http://localhost:1313/"
echo ""

# Run Hugo with local baseURL override
hugo server \
  --buildDrafts \
  --buildFuture \
  --bind 0.0.0.0 \
  --baseURL "http://localhost:1313/"

