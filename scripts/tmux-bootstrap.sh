#!/bin/bash
# Bootstrap script for tmux sessions
# Called automatically by WezTerm on startup to create fresh sessions

# Use full path to tmux since wezterm's os.execute may not have /opt/homebrew/bin in PATH
TMUX="/opt/homebrew/bin/tmux"

PIT_DIR="$HOME/src/bonfire-pit"
WOOD_DIR="$HOME/src/firewood-rack"
KINDLE_DIR="$HOME/src/bonfire-kindle"
FEDERAL_DIR="$HOME/src/bonfire-pit-federal"
TEMP_DIR="$HOME/temp"

ensure_fresh_session() {
  local session_name=$1

  if $TMUX has-session -t "$session_name" 2>/dev/null; then
    $TMUX kill-session -t "$session_name"
  fi
}

# Ensure temp directory and scratch files exist
mkdir -p "$TEMP_DIR"
touch "$TEMP_DIR/scratch.rb" "$TEMP_DIR/scratch.sql"

# =============================================================================
# Session 1: rails
# 3 windows: psql, rails console, rails server
# =============================================================================
ensure_fresh_session "rails"

$TMUX new-session -d -s rails -c "$PIT_DIR" -n "pgcli"
$TMUX send-keys -t rails:1 "pgcli -d bonfire_pit_dev" Enter

$TMUX new-window -t rails -c "$PIT_DIR" -n "console"
$TMUX send-keys -t rails:2 "rails console" Enter

$TMUX new-window -t rails -c "$PIT_DIR" -n "server"
$TMUX send-keys -t rails:3 "rails server" Enter

# Select first window
$TMUX select-window -t rails:1

# =============================================================================
# Session 2: local
# 6 windows: terminal, scratch files, then nvim for each project
# =============================================================================
ensure_fresh_session "local"

# Window 1: terminal at home
$TMUX new-session -d -s local -c "$HOME" -n "terminal"

# Window 2: scratch files
$TMUX new-window -t local -c "$TEMP_DIR" -n "scratch"
$TMUX send-keys -t local:2 "nvim scratch.sql scratch.rb" Enter

# Window 3: bonfire-pit
$TMUX new-window -t local -c "$PIT_DIR" -n "pit"
$TMUX send-keys -t local:3 "nvim" Enter

# Window 4: firewood-rack
$TMUX new-window -t local -c "$WOOD_DIR" -n "wood"
$TMUX send-keys -t local:4 "nvim" Enter

# Window 5: bonfire-kindle
$TMUX new-window -t local -c "$KINDLE_DIR" -n "kindle"
$TMUX send-keys -t local:5 "nvim" Enter

# Window 6: bonfire-pit-federal
$TMUX new-window -t local -c "$FEDERAL_DIR" -n "federal"
$TMUX send-keys -t local:6 "nvim" Enter

# Select first window
$TMUX select-window -t local:1

# Reload config to ensure TPM plugins (powerkit) initialize properly
$TMUX source-file ~/.tmux.conf 2>/dev/null || true
