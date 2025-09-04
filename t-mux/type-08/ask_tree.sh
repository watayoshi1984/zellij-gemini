#!/bin/bash

# Check if question is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your question here\""
    echo "Example: $0 \"Analyze the feasibility of developing a new SaaS platform\""
    exit 1
fi

QUESTION="$1"
SESSION_NAME="gemini-squad-8"

echo "🎯 Starting hierarchical task execution for Type-08 (8-pane layout)..."
echo "Question: $QUESTION"
echo ""

# Check if tmux session exists
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
    echo "❌ Error: Tmux session '$SESSION_NAME' not found."
    echo "Please run './tmux_layout.sh' first to create the session."
    exit 1
fi

echo "✅ Found tmux session: $SESSION_NAME"
echo ""
echo "🏛️  As President (a), I will coordinate dual-axis analysis:"
echo "   📋 Technical Group (Boss B → Workers C, D, E)"
echo "   📋 Business Group (Boss F → Workers G, H)"
echo ""

# Navigate to Technical Boss (b) and give instruction
echo "📤 Instructing Technical Boss (b)..."
tmux select-pane -t $SESSION_NAME:0.1
tmux send-keys -t $SESSION_NAME:0.1 "" C-m
tmux send-keys -t $SESSION_NAME:0.1 "# Technical Boss B: Analyze technical feasibility" C-m
tmux send-keys -t $SESSION_NAME:0.1 "# Question: $QUESTION" C-m
tmux send-keys -t $SESSION_NAME:0.1 "" C-m
tmux send-keys -t $SESSION_NAME:0.1 "Please coordinate with your technical team to analyze:" C-m
tmux send-keys -t $SESSION_NAME:0.1 "1. System Design (c): Architecture and technical specifications" C-m
tmux send-keys -t $SESSION_NAME:0.1 "2. Implementation (d): Development approach and effort estimation" C-m
tmux send-keys -t $SESSION_NAME:0.1 "3. Quality Assurance (e): Testing strategy and quality planning" C-m
tmux send-keys -t $SESSION_NAME:0.1 "" C-m
tmux send-keys -t $SESSION_NAME:0.1 "Provide integrated technical feasibility report to President." C-m

# Navigate to Business Boss (f) and give instruction
echo "📤 Instructing Business Boss (f)..."
tmux select-pane -t $SESSION_NAME:0.5
tmux send-keys -t $SESSION_NAME:0.5 "" C-m
tmux send-keys -t $SESSION_NAME:0.5 "# Business Boss F: Analyze business viability" C-m
tmux send-keys -t $SESSION_NAME:0.5 "# Question: $QUESTION" C-m
tmux send-keys -t $SESSION_NAME:0.5 "" C-m
tmux send-keys -t $SESSION_NAME:0.5 "Please coordinate with your business team to analyze:" C-m
tmux send-keys -t $SESSION_NAME:0.5 "1. Market Analysis (g): Market opportunity and competitive landscape" C-m
tmux send-keys -t $SESSION_NAME:0.5 "2. Business Strategy (h): Business model and financial viability" C-m
tmux send-keys -t $SESSION_NAME:0.5 "" C-m
tmux send-keys -t $SESSION_NAME:0.5 "Provide integrated business viability report to President." C-m

# Return to President pane
echo "🏛️  Returning to President (a) pane..."
tmux select-pane -t $SESSION_NAME:0.0
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "# PRESIDENT COORDINATION INITIATED" C-m
tmux send-keys -t $SESSION_NAME:0.0 "# Question: $QUESTION" C-m
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "✅ Instructions sent to both Boss groups:" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   🔧 Technical Boss (b): Technical feasibility analysis" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   💼 Business Boss (f): Business viability analysis" C-m
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "📋 Monitoring dual-axis analysis progress..." C-m
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "🎛️  Navigation Guide:" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   • Ctrl+b, q, 1: Check Technical Boss (b) progress" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   • Ctrl+b, q, 5: Check Business Boss (f) progress" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   • Ctrl+b, q, 2-4: Monitor Technical Workers (c,d,e)" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   • Ctrl+b, q, 6-7: Monitor Business Workers (g,h)" C-m
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "⏳ Awaiting integrated reports from both Boss groups..." C-m
tmux send-keys -t $SESSION_NAME:0.0 "" C-m
tmux send-keys -t $SESSION_NAME:0.0 "📊 Final Decision Process:" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   1. Review Technical Boss integrated report" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   2. Review Business Boss integrated report" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   3. Synthesize dual perspectives" C-m
tmux send-keys -t $SESSION_NAME:0.0 "   4. Make strategic decision" C-m

echo ""
echo "✅ Hierarchical task execution initiated!"
echo ""
echo "📊 Current Process Flow:"
echo "   President (a) → Technical Boss (b) → Workers (c,d,e)"
echo "                → Business Boss (f) → Workers (g,h)"
echo ""
echo "🎛️  To monitor progress:"
echo "   tmux attach-session -t $SESSION_NAME"
echo ""
echo "📋 Expected Workflow:"
echo "   1. Technical Boss delegates to System Design, Implementation, QA"
echo "   2. Business Boss delegates to Market Analysis, Business Strategy"
echo "   3. Workers analyze and report to their respective Bosses"
echo "   4. Bosses integrate reports and provide recommendations to President"
echo "   5. President synthesizes dual perspectives for final decision"
echo ""
echo "🚀 Dual-axis hierarchical analysis in progress!"