#!/bin/bash

# Gemini Squad Session Manager
# Centralized tmux session management for all layouts

# Source environment configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/load_env.sh" --quiet

# =============================================================================
# CONFIGURATION
# =============================================================================

AVAILABLE_LAYOUTS=("type-04" "type-06" "type-08" "type-16")
DEFAULT_LAYOUT="type-08"

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Display help information
show_help() {
    cat << EOF
🎯 Gemini Squad Session Manager

USAGE:
    $0 [COMMAND] [OPTIONS]

COMMANDS:
    list                    List all active Gemini Squad sessions
    create <layout>         Create a new session with specified layout
    attach <layout>         Attach to existing session
    kill <layout>           Kill specified session
    kill-all               Kill all Gemini Squad sessions
    status                 Show status of all layouts
    validate <layout>      Validate API keys for layout
    cleanup                Clean up old logs and temp files

LAYOUTS:
    type-04                4-pane layout (President + 3 specialists)
    type-06                6-pane layout (President + 2 bosses + 3 workers)
    type-08                8-pane layout (President + 2 bosses + 5 workers)
    type-16                16-pane layout (Full hierarchical organization)

EXAMPLES:
    $0 create type-08      Create Type-08 session
    $0 attach type-08      Attach to Type-08 session
    $0 list                List all active sessions
    $0 status              Show status of all layouts
    $0 validate type-08    Check API keys for Type-08

OPTIONS:
    -h, --help             Show this help message
    -v, --verbose          Enable verbose output
    -q, --quiet            Suppress non-essential output

EOF
}

# Get session name for layout
get_session_name() {
    local layout="$1"
    case "$layout" in
        "type-04") echo "gemini-squad-4" ;;
        "type-06") echo "gemini-squad-6" ;;
        "type-08") echo "gemini-squad-8" ;;
        "type-16") echo "gemini-squad-16" ;;
        *) echo "" ;;
    esac
}

# Check if layout is valid
is_valid_layout() {
    local layout="$1"
    for valid_layout in "${AVAILABLE_LAYOUTS[@]}"; do
        if [ "$layout" = "$valid_layout" ]; then
            return 0
        fi
    done
    return 1
}

# Check if session exists
session_exists() {
    local session_name="$1"
    tmux has-session -t "$session_name" 2>/dev/null
}

# Get layout directory
get_layout_dir() {
    local layout="$1"
    echo "$SCRIPT_DIR/$layout"
}

# =============================================================================
# MAIN FUNCTIONS
# =============================================================================

# List all Gemini Squad sessions
list_sessions() {
    echo "🔍 Active Gemini Squad Sessions:"
    echo ""
    
    local found_sessions=0
    
    for layout in "${AVAILABLE_LAYOUTS[@]}"; do
        local session_name=$(get_session_name "$layout")
        if session_exists "$session_name"; then
            local pane_count=$(tmux list-panes -t "$session_name" | wc -l)
            local created=$(tmux display-message -t "$session_name" -p '#{session_created}')
            local created_readable=$(date -d "@$created" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -r "$created" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "Unknown")
            
            echo "  ✅ $layout ($session_name)"
            echo "     Panes: $pane_count | Created: $created_readable"
            ((found_sessions++))
        else
            echo "  ❌ $layout ($session_name) - Not running"
        fi
    done
    
    echo ""
    if [ $found_sessions -eq 0 ]; then
        echo "No active Gemini Squad sessions found."
    else
        echo "Found $found_sessions active session(s)."
    fi
}

# Create new session
create_session() {
    local layout="$1"
    
    if ! is_valid_layout "$layout"; then
        echo "❌ Error: Invalid layout '$layout'"
        echo "Available layouts: ${AVAILABLE_LAYOUTS[*]}"
        return 1
    fi
    
    local session_name=$(get_session_name "$layout")
    local layout_dir=$(get_layout_dir "$layout")
    
    if session_exists "$session_name"; then
        echo "⚠️  Session '$session_name' already exists."
        read -p "Do you want to kill and recreate it? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            kill_session "$layout"
        else
            echo "Operation cancelled."
            return 1
        fi
    fi
    
    # Validate API keys
    echo "🔑 Validating API keys for $layout..."
    if ! validate_layout_keys "$layout"; then
        echo "❌ API key validation failed. Please configure your keys in load_env.sh"
        return 1
    fi
    
    # Check if layout directory exists
    if [ ! -d "$layout_dir" ]; then
        echo "❌ Error: Layout directory not found: $layout_dir"
        return 1
    fi
    
    # Check if tmux_layout.sh exists
    if [ ! -f "$layout_dir/tmux_layout.sh" ]; then
        echo "❌ Error: tmux_layout.sh not found in $layout_dir"
        return 1
    fi
    
    echo "🚀 Creating $layout session..."
    
    # Change to layout directory and execute
    cd "$layout_dir" || return 1
    
    # Make script executable
    chmod +x tmux_layout.sh
    
    # Execute layout script
    if ./tmux_layout.sh; then
        echo "✅ Session '$session_name' created successfully!"
        log_session_activity "$layout" "Session created"
        
        # Ask if user wants to attach
        read -p "Do you want to attach to the session now? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            attach_session "$layout"
        fi
    else
        echo "❌ Failed to create session '$session_name'"
        return 1
    fi
}

# Attach to existing session
attach_session() {
    local layout="$1"
    
    if ! is_valid_layout "$layout"; then
        echo "❌ Error: Invalid layout '$layout'"
        return 1
    fi
    
    local session_name=$(get_session_name "$layout")
    
    if ! session_exists "$session_name"; then
        echo "❌ Session '$session_name' does not exist."
        read -p "Do you want to create it? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            create_session "$layout"
        fi
        return
    fi
    
    echo "🔗 Attaching to session '$session_name'..."
    log_session_activity "$layout" "Session attached"
    tmux attach-session -t "$session_name"
}

# Kill specific session
kill_session() {
    local layout="$1"
    
    if ! is_valid_layout "$layout"; then
        echo "❌ Error: Invalid layout '$layout'"
        return 1
    fi
    
    local session_name=$(get_session_name "$layout")
    
    if ! session_exists "$session_name"; then
        echo "⚠️  Session '$session_name' does not exist."
        return 1
    fi
    
    echo "🔥 Killing session '$session_name'..."
    tmux kill-session -t "$session_name"
    log_session_activity "$layout" "Session killed"
    echo "✅ Session '$session_name' killed."
}

# Kill all Gemini Squad sessions
kill_all_sessions() {
    echo "🔥 Killing all Gemini Squad sessions..."
    
    local killed_count=0
    
    for layout in "${AVAILABLE_LAYOUTS[@]}"; do
        local session_name=$(get_session_name "$layout")
        if session_exists "$session_name"; then
            tmux kill-session -t "$session_name"
            log_session_activity "$layout" "Session killed (kill-all)"
            echo "  ✅ Killed $session_name"
            ((killed_count++))
        fi
    done
    
    if [ $killed_count -eq 0 ]; then
        echo "No active Gemini Squad sessions found."
    else
        echo "✅ Killed $killed_count session(s)."
    fi
}

# Show status of all layouts
show_status() {
    echo "📊 Gemini Squad Status Report"
    echo "============================="
    echo ""
    
    # Environment status
    echo "🔧 Environment:"
    echo "   Root: $GEMINI_SQUAD_ROOT"
    echo "   Logs: $GEMINI_SQUAD_LOGS"
    echo "   Model: $GEMINI_MODEL"
    echo ""
    
    # Session status
    echo "🎯 Sessions:"
    for layout in "${AVAILABLE_LAYOUTS[@]}"; do
        local session_name=$(get_session_name "$layout")
        if session_exists "$session_name"; then
            local pane_count=$(tmux list-panes -t "$session_name" | wc -l)
            echo "   ✅ $layout: Running ($pane_count panes)"
        else
            echo "   ❌ $layout: Not running"
        fi
    done
    echo ""
    
    # API key status
    echo "🔑 API Keys:"
    local configured_keys=0
    local total_keys=16
    
    for letter in A B C D E F G H I J K L M N O P; do
        key_name="GEMINI_API_KEY_$letter"
        key_value="${!key_name}"
        if [ -n "$key_value" ] && [ "$key_value" != "your-api-key-here" ]; then
            ((configured_keys++))
        fi
    done
    
    echo "   Configured: $configured_keys/$total_keys keys"
    
    if [ $configured_keys -lt 4 ]; then
        echo "   ⚠️  Warning: Minimum 4 keys needed for basic operation"
    fi
    
    echo ""
    
    # Log files
    echo "📝 Recent Activity:"
    if [ -d "$GEMINI_SQUAD_LOGS" ]; then
        local log_count=$(find "$GEMINI_SQUAD_LOGS" -name "*.log" | wc -l)
        echo "   Log files: $log_count"
        
        # Show recent activity from all logs
        local recent_logs=$(find "$GEMINI_SQUAD_LOGS" -name "*.log" -mtime -1 2>/dev/null)
        if [ -n "$recent_logs" ]; then
            echo "   Recent activity (last 24h):"
            tail -n 3 $recent_logs 2>/dev/null | head -n 5 | sed 's/^/     /'
        else
            echo "   No recent activity"
        fi
    else
        echo "   No log directory found"
    fi
}

# Validate API keys for layout
validate_keys() {
    local layout="$1"
    
    if ! is_valid_layout "$layout"; then
        echo "❌ Error: Invalid layout '$layout'"
        return 1
    fi
    
    validate_layout_keys "$layout"
}

# Cleanup old files
cleanup_files() {
    echo "🧹 Cleaning up old files..."
    
    # Clean logs older than 7 days
    cleanup_logs 7
    
    # Clean temp files
    if [ -d "$GEMINI_SQUAD_TEMP" ]; then
        find "$GEMINI_SQUAD_TEMP" -type f -mtime +1 -delete
        echo "🗑️  Cleaned temporary files"
    fi
    
    echo "✅ Cleanup completed"
}

# =============================================================================
# MAIN SCRIPT
# =============================================================================

# Parse command line arguments
VERBOSE=false
QUIET=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        list)
            list_sessions
            exit 0
            ;;
        create)
            if [ -z "$2" ]; then
                echo "❌ Error: Layout not specified"
                echo "Usage: $0 create <layout>"
                exit 1
            fi
            create_session "$2"
            exit $?
            ;;
        attach)
            if [ -z "$2" ]; then
                echo "❌ Error: Layout not specified"
                echo "Usage: $0 attach <layout>"
                exit 1
            fi
            attach_session "$2"
            exit $?
            ;;
        kill)
            if [ -z "$2" ]; then
                echo "❌ Error: Layout not specified"
                echo "Usage: $0 kill <layout>"
                exit 1
            fi
            kill_session "$2"
            exit $?
            ;;
        kill-all)
            kill_all_sessions
            exit 0
            ;;
        status)
            show_status
            exit 0
            ;;
        validate)
            if [ -z "$2" ]; then
                echo "❌ Error: Layout not specified"
                echo "Usage: $0 validate <layout>"
                exit 1
            fi
            validate_keys "$2"
            exit $?
            ;;
        cleanup)
            cleanup_files
            exit 0
            ;;
        *)
            echo "❌ Error: Unknown command '$1'"
            echo "Use '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

# If no command provided, show help
show_help