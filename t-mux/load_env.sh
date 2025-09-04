#!/bin/bash

# Gemini Squad Environment Configuration
# This file contains API keys and common settings for all tmux layouts

echo "🔑 Loading Gemini Squad environment..."

# =============================================================================
# API KEYS CONFIGURATION
# =============================================================================
# Please set your Gemini API keys below
# You can obtain API keys from: https://makersuite.google.com/app/apikey

# Type-04 Layout (4 panes)
export GEMINI_API_KEY_A="your-api-key-here"  # President
export GEMINI_API_KEY_B="your-api-key-here"  # Technical Lead
export GEMINI_API_KEY_C="your-api-key-here"  # Business Lead
export GEMINI_API_KEY_D="your-api-key-here"  # Quality Lead

# Type-06 Layout (6 panes) - extends Type-04
export GEMINI_API_KEY_E="your-api-key-here"  # Implementation
export GEMINI_API_KEY_F="your-api-key-here"  # Market Analysis

# Type-08 Layout (8 panes) - extends Type-06
export GEMINI_API_KEY_G="your-api-key-here"  # Market Analysis (dedicated)
export GEMINI_API_KEY_H="your-api-key-here"  # Business Strategy

# Type-16 Layout (16 panes) - full expansion
export GEMINI_API_KEY_I="your-api-key-here"   # Additional Worker 1
export GEMINI_API_KEY_J="your-api-key-here"   # Additional Worker 2
export GEMINI_API_KEY_K="your-api-key-here"   # Additional Worker 3
export GEMINI_API_KEY_L="your-api-key-here"   # Additional Worker 4
export GEMINI_API_KEY_M="your-api-key-here"   # Additional Worker 5
export GEMINI_API_KEY_N="your-api-key-here"   # Additional Worker 6
export GEMINI_API_KEY_O="your-api-key-here"   # Additional Worker 7
export GEMINI_API_KEY_P="your-api-key-here"   # Additional Worker 8

# =============================================================================
# GEMINI CONFIGURATION
# =============================================================================
export GEMINI_MODEL="gemini-1.5-pro-latest"
export GEMINI_TEMPERATURE="0.7"
export GEMINI_MAX_TOKENS="8192"
export GEMINI_TOP_P="0.8"
export GEMINI_TOP_K="40"

# =============================================================================
# TMUX CONFIGURATION
# =============================================================================
export TMUX_SESSION_PREFIX="gemini-squad"
export TMUX_PANE_BORDER_STATUS="top"
export TMUX_STATUS_POSITION="bottom"

# =============================================================================
# COMMON PATHS
# =============================================================================
export GEMINI_SQUAD_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export GEMINI_SQUAD_LOGS="$GEMINI_SQUAD_ROOT/logs"
export GEMINI_SQUAD_TEMP="$GEMINI_SQUAD_ROOT/temp"

# Create necessary directories
mkdir -p "$GEMINI_SQUAD_LOGS"
mkdir -p "$GEMINI_SQUAD_TEMP"

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Function to check if API key is set
check_api_key() {
    local key_name="$1"
    local key_value="${!key_name}"
    
    if [ -z "$key_value" ] || [ "$key_value" = "your-api-key-here" ]; then
        echo "⚠️  Warning: $key_name is not configured"
        return 1
    else
        echo "✅ $key_name is configured"
        return 0
    fi
}

# Function to validate all required API keys for a layout
validate_layout_keys() {
    local layout="$1"
    local missing_keys=0
    
    echo "🔍 Validating API keys for $layout layout..."
    
    case "$layout" in
        "type-04")
            check_api_key "GEMINI_API_KEY_A" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_B" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_C" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_D" || ((missing_keys++))
            ;;
        "type-06")
            check_api_key "GEMINI_API_KEY_A" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_B" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_C" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_D" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_E" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_F" || ((missing_keys++))
            ;;
        "type-08")
            check_api_key "GEMINI_API_KEY_A" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_B" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_C" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_D" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_E" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_F" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_G" || ((missing_keys++))
            check_api_key "GEMINI_API_KEY_H" || ((missing_keys++))
            ;;
        "type-16")
            for letter in {A..P}; do
                check_api_key "GEMINI_API_KEY_$letter" || ((missing_keys++))
            done
            ;;
    esac
    
    if [ $missing_keys -gt 0 ]; then
        echo "❌ $missing_keys API key(s) missing for $layout layout"
        echo "📝 Please edit $GEMINI_SQUAD_ROOT/load_env.sh to configure your API keys"
        return 1
    else
        echo "✅ All API keys configured for $layout layout"
        return 0
    fi
}

# Function to start Gemini session with proper error handling
start_gemini_session() {
    local api_key="$1"
    local role="$2"
    
    if [ -z "$api_key" ] || [ "$api_key" = "your-api-key-here" ]; then
        echo "❌ Error: API key not configured for $role"
        echo "📝 Please configure your API keys in load_env.sh"
        return 1
    fi
    
    echo "🚀 Starting Gemini session for $role..."
    # Add your Gemini CLI startup command here
    # Example: gemini-cli --api-key="$api_key" --model="$GEMINI_MODEL"
    
    return 0
}

# =============================================================================
# LOGGING FUNCTIONS
# =============================================================================

# Function to log session activity
log_session_activity() {
    local layout="$1"
    local action="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_file="$GEMINI_SQUAD_LOGS/session_${layout}.log"
    
    echo "[$timestamp] $action" >> "$log_file"
}

# Function to cleanup old logs
cleanup_logs() {
    local days_to_keep=${1:-7}
    echo "🧹 Cleaning up logs older than $days_to_keep days..."
    find "$GEMINI_SQUAD_LOGS" -name "*.log" -mtime +$days_to_keep -delete
}

# =============================================================================
# INITIALIZATION
# =============================================================================

echo "✅ Environment loaded successfully"
echo "📂 Root directory: $GEMINI_SQUAD_ROOT"
echo "📝 Logs directory: $GEMINI_SQUAD_LOGS"
echo "🔧 Model: $GEMINI_MODEL"
echo ""

# Display configuration status
if [ "$1" != "--quiet" ]; then
    echo "🔑 API Key Status:"
    for letter in A B C D E F G H I J K L M N O P; do
        key_name="GEMINI_API_KEY_$letter"
        key_value="${!key_name}"
        if [ -n "$key_value" ] && [ "$key_value" != "your-api-key-here" ]; then
            echo "   ✅ $key_name: Configured"
        else
            echo "   ⚠️  $key_name: Not configured"
        fi
    done
    echo ""
fi