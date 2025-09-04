#!/bin/bash

# Load environment variables
source "../common/load_env.sh"

# Check if tmux is available
check_tmux_available || exit 1

echo "Setting up Gemini Squad Type-08 (8-pane hierarchical layout)..."
echo "Architecture: President -> 2 Bosses (Technical & Business) -> 5 Workers"
echo ""

# Session name
SESSION_NAME="gemini-squad-8"

# Kill existing session if it exists
tmux kill-session -t $SESSION_NAME 2>/dev/null

# Create new session with first pane (President-a)
tmux new-session -d -s $SESSION_NAME -n "gemini-squad" -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.0 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.0 "./run_a.sh" Enter

# Split to create Boss-b (Technical Boss) - right side
tmux split-window -h -t $SESSION_NAME:0.0 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.1 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.1 "./run_b.sh" Enter

# Split Boss-b vertically to create Worker-c (System Design)
tmux split-window -v -t $SESSION_NAME:0.1 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.2 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.2 "./run_c.sh" Enter

# Split Worker-c horizontally to create Worker-d (Implementation)
tmux split-window -h -t $SESSION_NAME:0.2 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.3 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.3 "./run_d.sh" Enter

# Split Worker-d vertically to create Worker-e (Quality Assurance)
tmux split-window -v -t $SESSION_NAME:0.3 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.4 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.4 "./run_e.sh" Enter

# Split President-a vertically to create Boss-f (Business Boss)
tmux split-window -v -t $SESSION_NAME:0.0 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.5 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.5 "./run_f.sh" Enter

# Split Boss-f horizontally to create Worker-g (Market Analysis)
tmux split-window -h -t $SESSION_NAME:0.5 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.6 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.6 "./run_g.sh" Enter

# Split Worker-g vertically to create Worker-h (Business Strategy)
tmux split-window -v -t $SESSION_NAME:0.6 -c "$(pwd)"
tmux send-keys -t $SESSION_NAME:0.7 "cd $(pwd)/startup_scripts_template && chmod +x *.sh" Enter
tmux send-keys -t $SESSION_NAME:0.7 "./run_h.sh" Enter

# Set pane titles
tmux select-pane -t $SESSION_NAME:0.0 -T "President-a"
tmux select-pane -t $SESSION_NAME:0.1 -T "TechBoss-b"
tmux select-pane -t $SESSION_NAME:0.2 -T "SysDesign-c"
tmux select-pane -t $SESSION_NAME:0.3 -T "Implement-d"
tmux select-pane -t $SESSION_NAME:0.4 -T "Quality-e"
tmux select-pane -t $SESSION_NAME:0.5 -T "BizBoss-f"
tmux select-pane -t $SESSION_NAME:0.6 -T "Market-g"
tmux select-pane -t $SESSION_NAME:0.7 -T "Strategy-h"

# Adjust layout for better visibility
tmux select-layout -t $SESSION_NAME tiled

# Select President pane as default
tmux select-pane -t $SESSION_NAME:0.0

echo "✅ Gemini Squad Type-08 session created successfully!"
echo ""
echo "📋 Pane Layout:"
echo "  ┌─────────────┬─────────────┐"
echo "  │ President-a │ TechBoss-b  │"
echo "  ├─────────────┼─────┬───────┤"
echo "  │ BizBoss-f   │ Sys │ Impl  │"
echo "  ├─────┬───────┤ Des │ ement │"
echo "  │ Mkt │ Strat ├─────┼───────┤"
echo "  │ -g  │ -h    │ -c  │ Qual-e│"
echo "  └─────┴───────┴─────┴───────┘"
echo ""
echo "🎯 Hierarchy:"
echo "  President-a (Strategic Decision)"
echo "  ├── TechBoss-b (Technical Group Leader)"
echo "  │   ├── SysDesign-c (System Architecture)"
echo "  │   ├── Implement-d (Development)"
echo "  │   └── Quality-e (QA & Testing)"
echo "  └── BizBoss-f (Business Group Leader)"
echo "      ├── Market-g (Market Analysis)"
echo "      └── Strategy-h (Business Strategy)"
echo ""
echo "🚀 To attach to the session:"
echo "   tmux attach-session -t $SESSION_NAME"
echo ""
echo "📝 To start hierarchical task execution:"
echo "   ./ask_tree.sh \"Your question here\""
echo ""
echo "⌨️  Navigation shortcuts:"
echo "   Ctrl+b + arrow keys: Move between panes"
echo "   Ctrl+b + q: Show pane numbers"
echo "   Ctrl+b + z: Zoom current pane"
echo "   Ctrl+b + d: Detach from session"