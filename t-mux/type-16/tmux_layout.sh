#!/bin/bash

# Gemini Squad Type-16 Tmux Layout Script
# Creates a 16-pane enterprise-scale layout for comprehensive analysis

# Source common environment
source "../common/load_env.sh"
source "../common/tmux_utils.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-16"
LAYOUT_TYPE="type-16"
TOTAL_PANES=16

# Pane roles and assignments (sh compatible)
get_pane_role() {
    case "$1" in
        0) echo "President" ;;
        1) echo "Technical Boss" ;;
        2) echo "System Architect" ;;
        3) echo "Lead Developer" ;;
        4) echo "DevOps Engineer" ;;
        5) echo "Security Specialist" ;;
        6) echo "Data Architect" ;;
        7) echo "Quality Engineer" ;;
        8) echo "Business Boss" ;;
        9) echo "Strategy Director" ;;
        10) echo "Market Analyst" ;;
        11) echo "Finance Director" ;;
        12) echo "Operations Manager" ;;
        13) echo "Product Manager" ;;
        14) echo "Customer Success" ;;
        15) echo "Compliance Officer" ;;
        *) echo "Unknown" ;;
    esac
}

# =============================================================================
# LAYOUT FUNCTIONS
# =============================================================================

# Create the 16-pane layout
create_type16_layout() {
    print_header "Creating Type-16 Enterprise Layout (16 panes)"
    
    # Create new session with first pane
    tmux new-session -d -s "$SESSION_NAME" -x 200 -y 50
    
    print_info "📋 Creating 4x4 grid layout..."
    
    # Create additional panes to reach 16 total
    # Row 1: Split horizontally 3 times (panes 0,1,2,3)
    tmux split-window -h -t "$SESSION_NAME:0.0"
    tmux split-window -h -t "$SESSION_NAME:0.1"
    tmux split-window -h -t "$SESSION_NAME:0.2"
    
    # Row 2: Split pane 0 vertically, then split horizontally 3 times (panes 4,5,6,7)
    tmux split-window -v -t "$SESSION_NAME:0.0"
    tmux split-window -h -t "$SESSION_NAME:0.4"
    tmux split-window -h -t "$SESSION_NAME:0.5"
    tmux split-window -h -t "$SESSION_NAME:0.6"
    
    # Row 3: Split pane 4 vertically, then split horizontally 3 times (panes 8,9,10,11)
    tmux split-window -v -t "$SESSION_NAME:0.4"
    tmux split-window -h -t "$SESSION_NAME:0.8"
    tmux split-window -h -t "$SESSION_NAME:0.9"
    tmux split-window -h -t "$SESSION_NAME:0.10"
    
    # Row 4: Split pane 8 vertically, then split horizontally 3 times (panes 12,13,14,15)
    tmux split-window -v -t "$SESSION_NAME:0.8"
    tmux split-window -h -t "$SESSION_NAME:0.12"
    tmux split-window -h -t "$SESSION_NAME:0.13"
    tmux split-window -h -t "$SESSION_NAME:0.14"
    
    # Adjust pane sizes for better visibility
    tmux select-layout -t "$SESSION_NAME" tiled
    
    print_success "✅ 16-pane layout created successfully"
    
    return 0
}

# Initialize all panes with their roles
init_panes() {
    print_header "Initializing Panes with Roles"
    
    pane_id=0
    while [ $pane_id -le 15 ]; do
        role=$(get_pane_role $pane_id)
        print_info "📤 Initializing Pane $pane_id: $role"
        
        # Clear pane and set title
        tmux send-keys -t "$SESSION_NAME:0.$pane_id" "clear" Enter
        
        # Send initialization script path
        local script_path="$SCRIPT_DIR/startup_scripts_template/run_${pane_id}.sh"
        
        # Check if startup script exists, if not use generic initialization
        if [ -f "$script_path" ]; then
            tmux send-keys -t "$SESSION_NAME:0.$pane_id" "bash '$script_path'" Enter
        else
            # Generic initialization
            tmux send-keys -t "$SESSION_NAME:0.$pane_id" "echo '=== $role (Pane $pane_id) ==='" Enter
            tmux send-keys -t "$SESSION_NAME:0.$pane_id" "echo 'Ready for enterprise-scale analysis'" Enter
            tmux send-keys -t "$SESSION_NAME:0.$pane_id" "echo 'Waiting for instructions...'" Enter
        fi
        
        # Set pane title
        tmux select-pane -t "$SESSION_NAME:0.$pane_id" -T "$role"
        
        pane_id=$((pane_id + 1))
    done
    
    print_success "✅ All panes initialized"
    return 0
}

# Display layout information
show_layout_info() {
    print_header "Type-16 Enterprise Layout Information"
    
    echo "📊 Layout Structure (4x4 Grid):"
    echo ""
    echo "   ┌─────────────┬─────────────┬─────────────┬─────────────┐"
    echo "   │ President   │ Tech Boss   │ Sys Arch    │ Lead Dev    │"
    echo "   │    (0)      │    (1)      │    (2)      │    (3)      │"
    echo "   ├─────────────┼─────────────┼─────────────┼─────────────┤"
    echo "   │ DevOps Eng  │ Security    │ Data Arch   │ Quality Eng │"
    echo "   │    (4)      │    (5)      │    (6)      │    (7)      │"
    echo "   ├─────────────┼─────────────┼─────────────┼─────────────┤"
    echo "   │ Biz Boss    │ Strategy    │ Market      │ Finance     │"
    echo "   │    (8)      │    (9)      │   (10)      │   (11)      │"
    echo "   ├─────────────┼─────────────┼─────────────┼─────────────┤"
    echo "   │ Operations  │ Product Mgr │ Customer    │ Compliance  │"
    echo "   │   (12)      │   (13)      │   (14)      │   (15)      │"
    echo "   └─────────────┴─────────────┴─────────────┴─────────────┘"
    echo ""
    
    echo "🏗️  Technical Division (Panes 1-7):"
    echo "   1️⃣  Technical Boss: Technical leadership and coordination"
    echo "   2️⃣  System Architect: Enterprise architecture and design"
    echo "   3️⃣  Lead Developer: Development leadership and standards"
    echo "   4️⃣  DevOps Engineer: Infrastructure and deployment"
    echo "   5️⃣  Security Specialist: Security architecture and compliance"
    echo "   6️⃣  Data Architect: Data strategy and architecture"
    echo "   7️⃣  Quality Engineer: Quality assurance and testing"
    echo ""
    
    echo "💼 Business Division (Panes 8-15):"
    echo "   8️⃣  Business Boss: Business leadership and coordination"
    echo "   9️⃣  Strategy Director: Strategic planning and execution"
    echo "   🔟 Market Analyst: Market research and competitive analysis"
    echo "   1️⃣1️⃣ Finance Director: Financial planning and analysis"
    echo "   1️⃣2️⃣ Operations Manager: Operations and process optimization"
    echo "   1️⃣3️⃣ Product Manager: Product strategy and roadmap"
    echo "   1️⃣4️⃣ Customer Success: Customer experience and retention"
    echo "   1️⃣5️⃣ Compliance Officer: Regulatory compliance and risk"
    echo ""
    
    echo "🎛️  Navigation (Ctrl+b, q, [number]):"
    echo "   President: 0 | Technical: 1-7 | Business: 8-15"
    echo ""
    
    echo "📋 Available Commands:"
    echo "   ./ask_tree.sh \"question\"  - Hierarchical analysis (Boss → Workers)"
    echo "   ./ask_flat.sh \"question\"  - Flat coordination (President → All)"
    echo "   ../ask_simple.sh \"question\" - Broadcast to all panes"
    echo ""
    
    echo "🎯 Enterprise Use Cases:"
    echo "   • Large-scale digital transformation projects"
    echo "   • Complex system architecture decisions"
    echo "   • Multi-domain strategic planning"
    echo "   • Comprehensive risk and compliance assessment"
    echo "   • Enterprise-wide technology adoption"
    echo ""
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    print_warning "⚠️  Session '$SESSION_NAME' already exists"
    echo ""
    echo "Options:"
    echo "  1. Attach to existing session: tmux attach-session -t $SESSION_NAME"
    echo "  2. Kill existing session: tmux kill-session -t $SESSION_NAME"
    echo "  3. Use session manager: ../session_manager.sh"
    echo ""
    exit 1
fi

# Validate API keys (commented out - function not available)
# if ! validate_api_keys "$LAYOUT_TYPE"; then
#     print_error "❌ API key validation failed"
#     echo ""
#     echo "Please configure your API keys:"
#     echo "  export GEMINI_API_KEY_TYPE16='your-api-key-here'"
#     echo ""
#     echo "Or use the session manager to configure:"
#     echo "  ../session_manager.sh config"
#     exit 1
# fi

print_header "Gemini Squad Type-16 Enterprise Layout Setup"
print_info "Session: $SESSION_NAME"
print_info "Layout: 16-pane enterprise structure (4x4 grid)"
print_info "Architecture: President + Technical Division (7) + Business Division (8)"
echo ""

# Create layout
if ! create_type16_layout; then
    print_error "❌ Failed to create layout"
    exit 1
fi

# Initialize panes
if ! init_panes; then
    print_error "❌ Failed to initialize panes"
    tmux kill-session -t "$SESSION_NAME" 2>/dev/null
    exit 1
fi

# Focus on President pane
tmux select-pane -t "$SESSION_NAME:0.0"

print_success "🚀 Type-16 Enterprise layout ready!"
echo ""

# Show layout information
show_layout_info

echo "🎯 To attach to the session:"
echo "   tmux attach-session -t $SESSION_NAME"
echo ""

echo "📚 For help and commands:"
echo "   ../session_manager.sh help"
echo ""

# Log session creation (commented out - function not available)
# log_activity "$SESSION_NAME" "Session created with Type-16 enterprise layout" "INFO"

echo "✅ Setup complete! Ready for enterprise-scale analysis."