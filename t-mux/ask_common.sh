#!/bin/bash

# Gemini Squad Common Ask Functions
# Shared utilities for all ask scripts

# =============================================================================
# CONFIGURATION
# =============================================================================

# Default settings
DEFAULT_TIMEOUT=300  # 5 minutes
DEFAULT_RETRY_COUNT=3
DEFAULT_RETRY_DELAY=2

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Print colored output
print_color() {
    local color="$1"
    local message="$2"
    echo -e "${color}${message}${NC}"
}

# Print status messages
print_info() { print_color "$BLUE" "ℹ️  $1"; }
print_success() { print_color "$GREEN" "✅ $1"; }
print_warning() { print_color "$YELLOW" "⚠️  $1"; }
print_error() { print_color "$RED" "❌ $1"; }
print_header() { print_color "$CYAN" "🎯 $1"; }
print_step() { print_color "$MAGENTA" "📋 $1"; }

# Get timestamp
get_timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Log message with timestamp
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(get_timestamp)
    echo "[$timestamp] [$level] $message"
}

# =============================================================================
# TMUX UTILITY FUNCTIONS
# =============================================================================

# Check if tmux session exists
check_session_exists() {
    local session_name="$1"
    tmux has-session -t "$session_name" 2>/dev/null
}

# Get pane count for session
get_pane_count() {
    local session_name="$1"
    if check_session_exists "$session_name"; then
        tmux list-panes -t "$session_name" | wc -l
    else
        echo "0"
    fi
}

# Check if pane exists
check_pane_exists() {
    local session_name="$1"
    local pane_id="$2"
    tmux list-panes -t "$session_name" -F '#{pane_index}' 2>/dev/null | grep -q "^$pane_id$"
}

# Send command to pane with error handling
send_to_pane() {
    local session_name="$1"
    local pane_id="$2"
    local command="$3"
    local send_enter="${4:-true}"
    
    if ! check_session_exists "$session_name"; then
        print_error "Session '$session_name' does not exist"
        return 1
    fi
    
    if ! check_pane_exists "$session_name" "$pane_id"; then
        print_error "Pane $pane_id does not exist in session '$session_name'"
        return 1
    fi
    
    # Send the command
    if [ "$send_enter" = "true" ]; then
        tmux send-keys -t "$session_name:0.$pane_id" "$command" C-m
    else
        tmux send-keys -t "$session_name:0.$pane_id" "$command"
    fi
    
    return 0
}

# Send multiple lines to pane
send_multiline_to_pane() {
    local session_name="$1"
    local pane_id="$2"
    shift 2
    local lines=("$@")
    
    for line in "${lines[@]}"; do
        send_to_pane "$session_name" "$pane_id" "$line" true
        sleep 0.1  # Small delay between lines
    done
}

# Clear pane content
clear_pane() {
    local session_name="$1"
    local pane_id="$2"
    
    send_to_pane "$session_name" "$pane_id" "clear" true
}

# Focus on specific pane
focus_pane() {
    local session_name="$1"
    local pane_id="$2"
    
    if check_pane_exists "$session_name" "$pane_id"; then
        tmux select-pane -t "$session_name:0.$pane_id"
        return 0
    else
        print_error "Cannot focus on pane $pane_id in session '$session_name'"
        return 1
    fi
}

# =============================================================================
# QUESTION PROCESSING FUNCTIONS
# =============================================================================

# Validate question input
validate_question() {
    local question="$1"
    
    if [ -z "$question" ]; then
        print_error "Question cannot be empty"
        return 1
    fi
    
    if [ ${#question} -lt 10 ]; then
        print_warning "Question is very short (${#question} characters). Consider providing more detail."
    fi
    
    if [ ${#question} -gt 1000 ]; then
        print_warning "Question is very long (${#question} characters). Consider breaking it down."
    fi
    
    return 0
}

# Format question for display
format_question() {
    local question="$1"
    local max_width="${2:-80}"
    
    # Simple word wrapping
    echo "$question" | fold -s -w "$max_width"
}

# Generate question ID
generate_question_id() {
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local random=$(shuf -i 1000-9999 -n 1 2>/dev/null || echo $((RANDOM % 9000 + 1000)))
    echo "q_${timestamp}_${random}"
}

# =============================================================================
# ROLE-BASED INSTRUCTION FUNCTIONS
# =============================================================================

# Get role-specific instruction prefix
get_role_instruction() {
    local role="$1"
    local question="$2"
    
    case "$role" in
        "president")
            echo "# PRESIDENTIAL DIRECTIVE"
            echo "# Strategic Question: $question"
            echo "# Your Role: Coordinate overall analysis and make final strategic decision"
            echo "# Process: 1) Delegate to appropriate teams 2) Review integrated reports 3) Synthesize final decision"
            ;;
        "technical_boss")
            echo "# TECHNICAL LEADERSHIP DIRECTIVE"
            echo "# Question: $question"
            echo "# Your Role: Lead technical analysis team"
            echo "# Process: 1) Delegate to technical workers 2) Integrate technical reports 3) Report to President"
            ;;
        "business_boss")
            echo "# BUSINESS LEADERSHIP DIRECTIVE"
            echo "# Question: $question"
            echo "# Your Role: Lead business analysis team"
            echo "# Process: 1) Delegate to business workers 2) Integrate business reports 3) Report to President"
            ;;
        "system_design")
            echo "# SYSTEM DESIGN ANALYSIS"
            echo "# Question: $question"
            echo "# Your Role: Analyze technical architecture and system design aspects"
            echo "# Focus: Architecture, scalability, technology stack, technical feasibility"
            ;;
        "implementation")
            echo "# IMPLEMENTATION ANALYSIS"
            echo "# Question: $question"
            echo "# Your Role: Analyze development approach and implementation strategy"
            echo "# Focus: Development effort, timeline, resources, technical implementation"
            ;;
        "quality")
            echo "# QUALITY ASSURANCE ANALYSIS"
            echo "# Question: $question"
            echo "# Your Role: Analyze quality, testing, and risk aspects"
            echo "# Focus: Testing strategy, quality metrics, risk assessment, compliance"
            ;;
        "market_analysis")
            echo "# MARKET ANALYSIS"
            echo "# Question: $question"
            echo "# Your Role: Analyze market opportunity and competitive landscape"
            echo "# Focus: Market size, competition, customer needs, market trends"
            ;;
        "business_strategy")
            echo "# BUSINESS STRATEGY ANALYSIS"
            echo "# Question: $question"
            echo "# Your Role: Analyze business model and financial viability"
            echo "# Focus: Business model, revenue streams, ROI, growth strategy"
            ;;
        *)
            echo "# ANALYSIS REQUEST"
            echo "# Question: $question"
            echo "# Your Role: Provide specialized analysis"
            ;;
    esac
}

# =============================================================================
# WORKFLOW COORDINATION FUNCTIONS
# =============================================================================

# Wait for user input with timeout
wait_for_input() {
    local prompt="$1"
    local timeout="${2:-$DEFAULT_TIMEOUT}"
    local default_response="${3:-}"
    
    print_info "$prompt"
    if [ -n "$default_response" ]; then
        print_info "Default response after ${timeout}s: $default_response"
    fi
    
    if read -t "$timeout" -r response; then
        echo "$response"
    else
        if [ -n "$default_response" ]; then
            print_warning "Timeout reached, using default response: $default_response"
            echo "$default_response"
        else
            print_warning "Timeout reached, no response"
            return 1
        fi
    fi
}

# Progress indicator
show_progress() {
    local current="$1"
    local total="$2"
    local description="$3"
    
    local percentage=$((current * 100 / total))
    local bar_length=20
    local filled_length=$((percentage * bar_length / 100))
    
    printf "\r📊 Progress: ["
    for ((i=0; i<filled_length; i++)); do printf "█"; done
    for ((i=filled_length; i<bar_length; i++)); do printf "░"; done
    printf "] %d%% (%d/%d) %s" "$percentage" "$current" "$total" "$description"
    
    if [ "$current" -eq "$total" ]; then
        echo ""  # New line when complete
    fi
}

# =============================================================================
# ERROR HANDLING AND RETRY FUNCTIONS
# =============================================================================

# Retry function with exponential backoff
retry_with_backoff() {
    local max_attempts="${1:-$DEFAULT_RETRY_COUNT}"
    local delay="${2:-$DEFAULT_RETRY_DELAY}"
    local command="${3}"
    
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        print_info "Attempt $attempt/$max_attempts: $command"
        
        if eval "$command"; then
            print_success "Command succeeded on attempt $attempt"
            return 0
        else
            if [ $attempt -eq $max_attempts ]; then
                print_error "Command failed after $max_attempts attempts"
                return 1
            fi
            
            local wait_time=$((delay * attempt))
            print_warning "Attempt $attempt failed, retrying in ${wait_time}s..."
            sleep $wait_time
            ((attempt++))
        fi
    done
}

# Validate session state
validate_session_state() {
    local session_name="$1"
    local expected_panes="$2"
    
    if ! check_session_exists "$session_name"; then
        print_error "Session '$session_name' does not exist"
        return 1
    fi
    
    local actual_panes=$(get_pane_count "$session_name")
    if [ "$actual_panes" -ne "$expected_panes" ]; then
        print_error "Expected $expected_panes panes, found $actual_panes in session '$session_name'"
        return 1
    fi
    
    print_success "Session '$session_name' validated ($actual_panes panes)"
    return 0
}

# =============================================================================
# LOGGING AND REPORTING FUNCTIONS
# =============================================================================

# Initialize log file
init_log_file() {
    local log_file="$1"
    local session_name="$2"
    local question="$3"
    
    mkdir -p "$(dirname "$log_file")"
    
    cat > "$log_file" << EOF
# Gemini Squad Execution Log
# Session: $session_name
# Started: $(get_timestamp)
# Question: $question
# =====================================

EOF
}

# Append to log file
append_to_log() {
    local log_file="$1"
    local message="$2"
    local level="${3:-INFO}"
    
    echo "$(log_message "$level" "$message")" >> "$log_file"
}

# Generate execution summary
generate_summary() {
    local session_name="$1"
    local question="$2"
    local start_time="$3"
    local end_time="$4"
    local status="$5"
    
    cat << EOF

📊 EXECUTION SUMMARY
==================
Session: $session_name
Question: $question
Start Time: $start_time
End Time: $end_time
Duration: $(($(date -d "$end_time" +%s) - $(date -d "$start_time" +%s)))s
Status: $status

EOF
}

# =============================================================================
# INITIALIZATION
# =============================================================================

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    # Check required commands
    local required_commands=("tmux" "date" "fold")
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        return 1
    fi
    
    return 0
}

# Initialize common environment
init_common_env() {
    # Check dependencies
    if ! check_dependencies; then
        return 1
    fi
    
    # Set up directories
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    export GEMINI_SQUAD_ROOT="$script_dir"
    export GEMINI_SQUAD_LOGS="$script_dir/logs"
    export GEMINI_SQUAD_TEMP="$script_dir/temp"
    
    mkdir -p "$GEMINI_SQUAD_LOGS"
    mkdir -p "$GEMINI_SQUAD_TEMP"
    
    return 0
}

# =============================================================================
# EXPORT FUNCTIONS
# =============================================================================

# Make functions available to other scripts
export -f print_color print_info print_success print_warning print_error print_header print_step
export -f get_timestamp log_message
export -f check_session_exists get_pane_count check_pane_exists
export -f send_to_pane send_multiline_to_pane clear_pane focus_pane
export -f validate_question format_question generate_question_id
export -f get_role_instruction wait_for_input show_progress
export -f retry_with_backoff validate_session_state
export -f init_log_file append_to_log generate_summary
export -f check_dependencies init_common_env

# Export color codes
export RED GREEN YELLOW BLUE MAGENTA CYAN WHITE NC

# Export default values
export DEFAULT_TIMEOUT DEFAULT_RETRY_COUNT DEFAULT_RETRY_DELAY

print_success "Common ask functions loaded successfully"