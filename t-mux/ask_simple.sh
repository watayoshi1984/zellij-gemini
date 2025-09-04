#!/bin/bash

# Gemini Squad Simple Ask Script
# Direct question to all panes without hierarchy

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

USAGE="Usage: $0 <session_name> \"Your question here\""
EXAMPLE="Example: $0 gemini-squad-4 \"Analyze the market potential for AI-powered tools\""

# =============================================================================
# MAIN FUNCTION
# =============================================================================

# Simple ask - send question to all panes
simple_ask() {
    local session_name="$1"
    local question="$2"
    
    print_header "Simple Ask Mode: Broadcasting to All Panes"
    print_info "Session: $session_name"
    print_info "Question: $question"
    echo ""
    
    # Validate session
    if ! check_session_exists "$session_name"; then
        print_error "Session '$session_name' does not exist"
        print_info "Available sessions:"
        tmux list-sessions 2>/dev/null | grep "gemini-squad" || print_warning "No Gemini Squad sessions found"
        return 1
    fi
    
    # Get pane count
    local pane_count=$(get_pane_count "$session_name")
    print_success "Found $pane_count panes in session '$session_name'"
    
    # Generate question ID for tracking
    local question_id=$(generate_question_id)
    print_info "Question ID: $question_id"
    
    # Initialize log
    local log_file="$GEMINI_SQUAD_LOGS/simple_ask_${session_name}_${question_id}.log"
    init_log_file "$log_file" "$session_name" "$question"
    
    print_step "Broadcasting question to all panes..."
    
    # Send question to all panes
    for ((pane=0; pane<pane_count; pane++)); do
        if check_pane_exists "$session_name" "$pane"; then
            print_info "Sending to pane $pane..."
            
            # Clear pane and send question
            send_to_pane "$session_name" "$pane" "" true
            send_to_pane "$session_name" "$pane" "# SIMPLE ASK MODE - Question ID: $question_id" true
            send_to_pane "$session_name" "$pane" "# Question: $question" true
            send_to_pane "$session_name" "$pane" "# Please provide your analysis from your specialized perspective." true
            send_to_pane "$session_name" "$pane" "" true
            
            # Log the action
            append_to_log "$log_file" "Question sent to pane $pane" "INFO"
            
            show_progress $((pane+1)) "$pane_count" "Broadcasting..."
            sleep 0.5
        else
            print_warning "Pane $pane does not exist, skipping"
            append_to_log "$log_file" "Pane $pane does not exist" "WARNING"
        fi
    done
    
    echo ""
    print_success "Question broadcasted to all $pane_count panes!"
    
    # Focus on first pane
    focus_pane "$session_name" "0"
    
    print_info "Navigation Guide:"
    print_info "  • Ctrl+b, q, <number>: Switch to pane <number>"
    print_info "  • Ctrl+b, d: Detach from session"
    print_info "  • Each pane will analyze from their specialized perspective"
    
    echo ""
    print_header "Session Information:"
    print_info "  Session: $session_name"
    print_info "  Panes: $pane_count"
    print_info "  Question ID: $question_id"
    print_info "  Log: $log_file"
    
    # Final log entry
    append_to_log "$log_file" "Simple ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "Ready! Switch between panes to see different perspectives."
    
    return 0
}

# =============================================================================
# SCRIPT ENTRY POINT
# =============================================================================

# Initialize environment
if ! init_common_env; then
    print_error "Failed to initialize environment"
    exit 1
fi

# Check arguments
if [ $# -ne 2 ]; then
    print_error "Invalid number of arguments"
    echo ""
    echo "$USAGE"
    echo "$EXAMPLE"
    echo ""
    print_info "Available sessions:"
    tmux list-sessions 2>/dev/null | grep "gemini-squad" || print_warning "No Gemini Squad sessions found"
    exit 1
fi

SESSION_NAME="$1"
QUESTION="$2"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

# Execute simple ask
simple_ask "$SESSION_NAME" "$QUESTION"
exit $?