#!/bin/bash

# Gemini Squad Main Launcher
# Interactive launcher for all tmux layouts

# Source environment and session manager
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/load_env.sh" --quiet
source "$SCRIPT_DIR/session_manager.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

VERSION="1.0.0"
DEFAULT_LAYOUT="type-08"

# =============================================================================
# UI FUNCTIONS
# =============================================================================

# Display banner
show_banner() {
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                           🎯 GEMINI SQUAD LAUNCHER                          ║
║                        Advanced AI Team Collaboration                       ║
╚══════════════════════════════════════════════════════════════════════════════╝
EOF
    echo "Version: $VERSION | Root: $(basename "$GEMINI_SQUAD_ROOT")"
    echo ""
}

# Display layout information
show_layout_info() {
    cat << 'EOF'
📊 Available Layouts:

┌─────────────┬───────┬─────────────────────────────────────────────────────────┐
│ Layout      │ Panes │ Description                                             │
├─────────────┼───────┼─────────────────────────────────────────────────────────┤
│ type-04     │   4   │ Basic: President + 3 Specialists                       │
│ type-06     │   6   │ Extended: President + 2 Bosses + 3 Workers             │
│ type-08     │   8   │ Dual-Axis: President + 2 Bosses + 5 Workers            │
│ type-16     │  16   │ Full Org: Complete hierarchical structure              │
└─────────────┴───────┴─────────────────────────────────────────────────────────┘

🎯 Recommended for beginners: type-08 (Balanced complexity and capability)
EOF
}

# Display current status
show_current_status() {
    echo "📊 Current Status:"
    echo ""
    
    # Check active sessions
    local active_sessions=0
    for layout in "${AVAILABLE_LAYOUTS[@]}"; do
        local session_name=$(get_session_name "$layout")
        if session_exists "$session_name"; then
            local pane_count=$(tmux list-panes -t "$session_name" | wc -l)
            echo "  ✅ $layout: Running ($pane_count panes)"
            ((active_sessions++))
        fi
    done
    
    if [ $active_sessions -eq 0 ]; then
        echo "  ❌ No active sessions"
    fi
    
    echo ""
    
    # Check API key configuration
    local configured_keys=0
    for letter in A B C D E F G H; do
        key_name="GEMINI_API_KEY_$letter"
        key_value="${!key_name}"
        if [ -n "$key_value" ] && [ "$key_value" != "your-api-key-here" ]; then
            ((configured_keys++))
        fi
    done
    
    echo "🔑 API Keys: $configured_keys/8 basic keys configured"
    
    if [ $configured_keys -lt 4 ]; then
        echo "  ⚠️  Warning: Configure at least 4 API keys for basic operation"
        echo "  📝 Edit: $SCRIPT_DIR/load_env.sh"
    fi
    
    echo ""
}

# Interactive menu
show_menu() {
    cat << 'EOF'
🎛️  Main Menu:

  1) 🚀 Quick Start (type-08)     - Start recommended layout
  2) 📋 Create Session            - Choose layout and create
  3) 🔗 Attach to Session         - Connect to existing session
  4) 📊 Show Status               - View detailed status
  5) 🔧 Manage Sessions           - Advanced session management
  6) 🔑 Configure API Keys        - Edit environment settings
  7) 📚 Help & Documentation      - View help information
  8) 🚪 Exit                      - Quit launcher

EOF
}

# =============================================================================
# INTERACTIVE FUNCTIONS
# =============================================================================

# Quick start with default layout
quick_start() {
    echo "🚀 Quick Start: Creating $DEFAULT_LAYOUT session..."
    echo ""
    
    # Check if session already exists
    local session_name=$(get_session_name "$DEFAULT_LAYOUT")
    if session_exists "$session_name"; then
        echo "✅ Session '$session_name' already exists!"
        read -p "Do you want to attach to it? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            attach_session "$DEFAULT_LAYOUT"
            return
        fi
    fi
    
    # Create new session
    create_session "$DEFAULT_LAYOUT"
}

# Interactive session creation
interactive_create() {
    echo "📋 Create New Session"
    echo ""
    
    show_layout_info
    echo ""
    
    while true; do
        read -p "Select layout (type-04/type-06/type-08/type-16) [default: $DEFAULT_LAYOUT]: " layout
        
        # Use default if empty
        if [ -z "$layout" ]; then
            layout="$DEFAULT_LAYOUT"
        fi
        
        if is_valid_layout "$layout"; then
            break
        else
            echo "❌ Invalid layout. Please choose from: ${AVAILABLE_LAYOUTS[*]}"
        fi
    done
    
    echo ""
    create_session "$layout"
}

# Interactive session attachment
interactive_attach() {
    echo "🔗 Attach to Existing Session"
    echo ""
    
    # List active sessions
    local active_layouts=()
    for layout in "${AVAILABLE_LAYOUTS[@]}"; do
        local session_name=$(get_session_name "$layout")
        if session_exists "$session_name"; then
            active_layouts+=("$layout")
        fi
    done
    
    if [ ${#active_layouts[@]} -eq 0 ]; then
        echo "❌ No active sessions found."
        read -p "Do you want to create a new session? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            interactive_create
        fi
        return
    fi
    
    echo "Active sessions:"
    for i in "${!active_layouts[@]}"; do
        local layout="${active_layouts[$i]}"
        local session_name=$(get_session_name "$layout")
        local pane_count=$(tmux list-panes -t "$session_name" | wc -l)
        echo "  $((i+1))) $layout ($pane_count panes)"
    done
    echo ""
    
    while true; do
        read -p "Select session (1-${#active_layouts[@]}): " choice
        
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#active_layouts[@]} ]; then
            local selected_layout="${active_layouts[$((choice-1))]}"
            attach_session "$selected_layout"
            break
        else
            echo "❌ Invalid choice. Please enter a number between 1 and ${#active_layouts[@]}."
        fi
    done
}

# Session management menu
session_management() {
    while true; do
        echo ""
        echo "🔧 Session Management"
        echo ""
        echo "  1) List all sessions"
        echo "  2) Kill specific session"
        echo "  3) Kill all sessions"
        echo "  4) Validate API keys"
        echo "  5) Cleanup old files"
        echo "  6) Back to main menu"
        echo ""
        
        read -p "Select option (1-6): " choice
        
        case $choice in
            1)
                echo ""
                list_sessions
                read -p "Press Enter to continue..." -r
                ;;
            2)
                echo ""
                echo "Active sessions:"
                local active_layouts=()
                for layout in "${AVAILABLE_LAYOUTS[@]}"; do
                    local session_name=$(get_session_name "$layout")
                    if session_exists "$session_name"; then
                        active_layouts+=("$layout")
                        echo "  ${#active_layouts[@]}) $layout"
                    fi
                done
                
                if [ ${#active_layouts[@]} -eq 0 ]; then
                    echo "  No active sessions found."
                else
                    echo ""
                    read -p "Select session to kill (1-${#active_layouts[@]}): " kill_choice
                    if [[ "$kill_choice" =~ ^[0-9]+$ ]] && [ "$kill_choice" -ge 1 ] && [ "$kill_choice" -le ${#active_layouts[@]} ]; then
                        local selected_layout="${active_layouts[$((kill_choice-1))]}"
                        kill_session "$selected_layout"
                    else
                        echo "❌ Invalid choice."
                    fi
                fi
                read -p "Press Enter to continue..." -r
                ;;
            3)
                echo ""
                read -p "Are you sure you want to kill ALL sessions? (y/N): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    kill_all_sessions
                else
                    echo "Operation cancelled."
                fi
                read -p "Press Enter to continue..." -r
                ;;
            4)
                echo ""
                echo "Select layout to validate:"
                for i in "${!AVAILABLE_LAYOUTS[@]}"; do
                    echo "  $((i+1))) ${AVAILABLE_LAYOUTS[$i]}"
                done
                echo ""
                read -p "Select layout (1-${#AVAILABLE_LAYOUTS[@]}): " validate_choice
                if [[ "$validate_choice" =~ ^[0-9]+$ ]] && [ "$validate_choice" -ge 1 ] && [ "$validate_choice" -le ${#AVAILABLE_LAYOUTS[@]} ]; then
                    local selected_layout="${AVAILABLE_LAYOUTS[$((validate_choice-1))]}"
                    echo ""
                    validate_keys "$selected_layout"
                else
                    echo "❌ Invalid choice."
                fi
                read -p "Press Enter to continue..." -r
                ;;
            5)
                echo ""
                cleanup_files
                read -p "Press Enter to continue..." -r
                ;;
            6)
                break
                ;;
            *)
                echo "❌ Invalid choice. Please enter a number between 1 and 6."
                ;;
        esac
    done
}

# Configure API keys
configure_api_keys() {
    echo "🔑 Configure API Keys"
    echo ""
    echo "API keys are stored in: $SCRIPT_DIR/load_env.sh"
    echo ""
    echo "You can:"
    echo "  1) Edit the file manually with your preferred editor"
    echo "  2) Use nano editor (if available)"
    echo "  3) View current configuration status"
    echo ""
    
    read -p "Select option (1-3): " choice
    
    case $choice in
        1)
            echo ""
            echo "📝 Please edit the following file:"
            echo "   $SCRIPT_DIR/load_env.sh"
            echo ""
            echo "Look for lines starting with 'export GEMINI_API_KEY_' and replace"
            echo "'your-api-key-here' with your actual API keys."
            echo ""
            echo "💡 You can get API keys from: https://makersuite.google.com/app/apikey"
            ;;
        2)
            if command -v nano >/dev/null 2>&1; then
                echo "🔧 Opening nano editor..."
                nano "$SCRIPT_DIR/load_env.sh"
            else
                echo "❌ nano editor not available. Please edit manually:"
                echo "   $SCRIPT_DIR/load_env.sh"
            fi
            ;;
        3)
            echo ""
            echo "🔍 Current API Key Status:"
            for letter in A B C D E F G H I J K L M N O P; do
                key_name="GEMINI_API_KEY_$letter"
                key_value="${!key_name}"
                if [ -n "$key_value" ] && [ "$key_value" != "your-api-key-here" ]; then
                    echo "   ✅ $key_name: Configured"
                else
                    echo "   ❌ $key_name: Not configured"
                fi
            done
            ;;
        *)
            echo "❌ Invalid choice."
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..." -r
}

# Show help and documentation
show_help_menu() {
    echo "📚 Help & Documentation"
    echo ""
    echo "🎯 Gemini Squad is an advanced AI team collaboration system using tmux."
    echo ""
    echo "📋 Key Concepts:"
    echo "   • Layouts: Different organizational structures (4, 6, 8, or 16 panes)"
    echo "   • Sessions: Tmux sessions containing all team members"
    echo "   • Roles: Each pane represents a specialized AI team member"
    echo "   • Hierarchy: President → Bosses → Workers structure"
    echo ""
    echo "🚀 Getting Started:"
    echo "   1. Configure API keys in load_env.sh"
    echo "   2. Use 'Quick Start' to create a type-08 session"
    echo "   3. Use ask_tree.sh to execute hierarchical tasks"
    echo ""
    echo "🎛️  Tmux Navigation:"
    echo "   • Ctrl+b, q, <number>: Switch to pane number"
    echo "   • Ctrl+b, d: Detach from session"
    echo "   • Ctrl+b, ?: Show tmux help"
    echo ""
    echo "📊 Layout Comparison:"
    echo "   • type-04: Simple, good for basic tasks"
    echo "   • type-06: Balanced, adds specialization"
    echo "   • type-08: Recommended, dual-axis analysis"
    echo "   • type-16: Advanced, full organizational structure"
    echo ""
    echo "🔧 Troubleshooting:"
    echo "   • Check API keys if sessions fail to start"
    echo "   • Use 'tmux list-sessions' to see active sessions"
    echo "   • Use session manager for advanced operations"
    echo ""
    echo "📝 Files:"
    echo "   • load_env.sh: Environment and API key configuration"
    echo "   • session_manager.sh: Advanced session management"
    echo "   • tmux_layout.sh: Layout-specific session creation"
    echo "   • ask_tree.sh: Hierarchical task execution"
    echo ""
    
    read -p "Press Enter to continue..." -r
}

# =============================================================================
# MAIN LOOP
# =============================================================================

# Main interactive loop
main_loop() {
    while true; do
        clear
        show_banner
        show_current_status
        show_menu
        
        read -p "Select option (1-8): " choice
        
        case $choice in
            1)
                echo ""
                quick_start
                if [ $? -eq 0 ]; then
                    # If successful, exit the launcher
                    exit 0
                fi
                read -p "Press Enter to continue..." -r
                ;;
            2)
                echo ""
                interactive_create
                read -p "Press Enter to continue..." -r
                ;;
            3)
                echo ""
                interactive_attach
                if [ $? -eq 0 ]; then
                    # If successful, exit the launcher
                    exit 0
                fi
                read -p "Press Enter to continue..." -r
                ;;
            4)
                echo ""
                show_status
                read -p "Press Enter to continue..." -r
                ;;
            5)
                session_management
                ;;
            6)
                echo ""
                configure_api_keys
                ;;
            7)
                echo ""
                show_help_menu
                ;;
            8)
                echo ""
                echo "👋 Thank you for using Gemini Squad!"
                echo "🚀 Happy collaborating!"
                exit 0
                ;;
            *)
                echo ""
                echo "❌ Invalid choice. Please enter a number between 1 and 8."
                read -p "Press Enter to continue..." -r
                ;;
        esac
    done
}

# =============================================================================
# SCRIPT ENTRY POINT
# =============================================================================

# Check if tmux is available
if ! command -v tmux >/dev/null 2>&1; then
    echo "❌ Error: tmux is not installed or not in PATH"
    echo "Please install tmux first:"
    echo "  Ubuntu/Debian: sudo apt-get install tmux"
    echo "  macOS: brew install tmux"
    echo "  Windows WSL: sudo apt-get install tmux"
    exit 1
fi

# Handle command line arguments
if [ $# -gt 0 ]; then
    case $1 in
        --help|-h)
            show_help_menu
            exit 0
            ;;
        --version|-v)
            echo "Gemini Squad Launcher v$VERSION"
            exit 0
            ;;
        --quick|-q)
            quick_start
            exit $?
            ;;
        --status|-s)
            show_status
            exit 0
            ;;
        *)
            echo "❌ Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
fi

# Start main interactive loop
main_loop