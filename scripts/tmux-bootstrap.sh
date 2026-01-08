#!/bin/bash
# Bootstrap script for tmux sessions
# Run this once to set up your sessions, then tmux-continuum will maintain them

PIT_DIR="$HOME/src/bonfire-pit"
WOOD_DIR="$HOME/src/firewood-rack"
KINDLE_DIR="$HOME/src/bonfire-kindle"
TEMP_DIR="$HOME/temp"

ensure_fresh_session() {
  local session_name=$1

  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux kill-session -t "$session_name"
  fi
}

create_three_window_session() {
  local session_name=$1
  local session_dir=$2

  ensure_fresh_session "$session_name"

  tmux new-session -d -s "$session_name" -c "$session_dir" -n "terminal"

  tmux new-window -t "$session_name" -c "$session_dir" -n "cursor"
  tmux send-keys -t "$session_name":2 "cursor-agent" Enter

  tmux new-window -t "$session_name" -c "$session_dir" -n "nvim"
  tmux send-keys -t "$session_name":3 "nvim" Enter

  tmux select-window -t "$session_name":1
}

# Ensure temp directory and scratch files exist
mkdir -p "$TEMP_DIR"
touch "$TEMP_DIR/scratch.rb" "$TEMP_DIR/scratch.sql"

# =============================================================================
# Session 1: rails
# 3 windows: psql, rails console, rails server
# =============================================================================
ensure_fresh_session "rails"

tmux new-session -d -s rails -c "$PIT_DIR" -n "pgcli"
tmux send-keys -t rails:1 "pgcli -d bonfire_pit_dev" Enter

tmux new-window -t rails -c "$PIT_DIR" -n "console"
tmux send-keys -t rails:2 "rails console" Enter

tmux new-window -t rails -c "$PIT_DIR" -n "server"
tmux send-keys -t rails:3 "rails server" Enter

# Select first window
tmux select-window -t rails:1

# =============================================================================
# Session 2: local
# 1 window: nvim with scratch.rb and scratch.sql buffers
# =============================================================================
ensure_fresh_session "local"

tmux new-session -d -s local -c "$TEMP_DIR" -n "scratch"
tmux send-keys -t local:1 "nvim scratch.sql scratch.rb" Enter

# =============================================================================
# Session 3: pit
# 3 windows: terminal, cursor-agent, nvim
# =============================================================================
create_three_window_session "pit" "$PIT_DIR"

# =============================================================================
# Session 4: wood
# 3 windows: terminal, cursor-agent, nvim
# =============================================================================
create_three_window_session "wood" "$WOOD_DIR"

# =============================================================================
# Session 5: kindle
# 3 windows: terminal, cursor-agent, nvim
# =============================================================================
create_three_window_session "kindle" "$KINDLE_DIR"

echo "✅ Tmux sessions bootstrapped!"
echo ""
echo "Sessions created:"
tmux list-sessions
echo ""
echo "Now open WezTerm and it will attach to these sessions."
