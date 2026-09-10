#!/bin/bash

# Set the port number
PORT=2403

# Check if Node.js or Python is installed
if command -v node >/dev/null 2>&1; then
    EXEC="npx http-server -p $PORT -c-1"
elif command -v python3 >/dev/null 2>&1; then
    EXEC="python3 -m http.server $PORT"
elif command -v python >/dev/null 2>&1; then
    EXEC="python -m http.server $PORT"
else
    echo "No supported HTTP servers installed. Please install Node.js or Python."
    exit 1
fi

cd "$(dirname "$0")" || exit 1
echo "Starting web server on port $PORT..."
$EXEC &
sleep 1

# Open the default web browser with the demo data
if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "http://localhost:$PORT/site"
elif command -v open >/dev/null 2>&1; then
    open "http://localhost:$PORT/site" # For macOS compatibility
else
    echo "Server running. Please open http://localhost:$PORT/site in your browser."
fi

wait
