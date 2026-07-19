#!/bin/sh
# Keep the Kindle awake for N seconds (default 900 = 15 min).
# Duration is passed from menu.json via params.
DURATION="${1:-900}"
PIDFILE=/tmp/keepawake.pid

# Stop any existing keep-awake loop first.
if [ -f "$PIDFILE" ]; then
    kill "$(cat "$PIDFILE")" 2>/dev/null
    rm -f "$PIDFILE"
fi

# Background loop: poke powerd every 4 minutes until the deadline,
# then stop so the normal sleep timeout resumes on its own.
(
    END=$(( $(date +%s) + DURATION ))
    while [ "$(date +%s)" -lt "$END" ]; do
        lipc-set-prop -i com.lab126.powerd touchScreenSaverTimeout 1
        sleep 240
    done
    rm -f "$PIDFILE"
) &

echo $! > "$PIDFILE"
