#!/bin/bash
# Bootstrap script for tmux sessions
# Run this once to set up your sessions, then tmux-continuum will maintain them

BONFIRE_DIR="$HOME/src/bonfire-pit"
TEMP_DIR="$HOME/temp"

# Ensure temp directory and scratch files exist
mkdir -p "$TEMP_DIR"
touch "$TEMP_DIR/scratch.rb" "$TEMP_DIR/scratch.sql"

# =============================================================================
# Session 1: rails
# 3 windows: psql, rails console, rails server
# =============================================================================
tmux new-session -d -s rails -c "$BONFIRE_DIR" -n "pgcli"
tmux send-keys -t rails:1 "pgcli -d bonfire_pit_dev" Enter

tmux new-window -t rails -c "$BONFIRE_DIR" -n "console"
tmux send-keys -t rails:2 "rails console" Enter

tmux new-window -t rails -c "$BONFIRE_DIR" -n "server"
tmux send-keys -t rails:3 "rails server" Enter

# Select first window
tmux select-window -t rails:1

# =============================================================================
# Session 2: local
# 1 window: nvim with scratch.rb and scratch.sql buffers
# =============================================================================
tmux new-session -d -s local -c "$HOME" -n "scratch"
tmux send-keys -t local:1 "nvim $TEMP_DIR/scratch.rb $TEMP_DIR/scratch.sql" Enter

# =============================================================================
# Session 3: agent
# 3 windows: terminal, cursor-agent, nvim
# =============================================================================
tmux new-session -d -s agent -c "$BONFIRE_DIR" -n "terminal"

tmux new-window -t agent -c "$BONFIRE_DIR" -n "cursor"
tmux send-keys -t agent:2 "cursor-agent" Enter

tmux new-window -t agent -c "$BONFIRE_DIR" -n "nvim"
tmux send-keys -t agent:3 "nvim" Enter

# Select first window
tmux select-window -t agent:1

echo "✅ Tmux sessions bootstrapped!"
echo ""
echo "Sessions created:"
tmux list-sessions
echo ""
echo "Now open WezTerm and it will attach to these sessions."
