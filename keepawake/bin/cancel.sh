#!/bin/sh
# Stop the keep-awake loop; the normal sleep timeout resumes automatically.
PIDFILE=/tmp/keepawake.pid
if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
fi
