#!/bin/bash
# Wait for a tmux session to exist, then attach
# Usage: tmux-attach-wait.sh <session-name>

SESSION="${1:-local}"
TMUX="/opt/homebrew/bin/tmux"

# Wait up to 30 seconds for session to exist
for i in {1..30}; do
    if $TMUX has-session -t "$SESSION" 2>/dev/null; then
        exec $TMUX attach-session -t "$SESSION"
    fi
    sleep 1
done

echo "Timeout waiting for tmux session '$SESSION'"
echo "You can manually run: tmux attach-session -t $SESSION"
exec /opt/homebrew/bin/fish -l
