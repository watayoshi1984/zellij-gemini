#!/bin/bash

# Gemini Squad Type-08 Flat Ask Script
# 8-pane flat structure: President coordinates with 7 specialists directly

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-8"
USAGE="Usage: $0 \"Your question here\""
EXAMPLE="Example: $0 \"Design and launch a comprehensive digital transformation initiative\""

# Pane assignments for Type-08
PRESIDENT_PANE=0
TECH_BOSS_PANE=1
SYSTEM_DESIGN_PANE=2
IMPLEMENTATION_PANE=3
QUALITY_PANE=4
BUSINESS_BOSS_PANE=5
MARKET_ANALYSIS_PANE=6
BUSINESS_STRATEGY_PANE=7

# =============================================================================
# TYPE-08 SPECIFIC FUNCTIONS
# =============================================================================

# Execute flat coordination for Type-08
flat_ask_type08() {
    local question="$1"
    
    print_header "Type-08 Flat Coordination: President + 7 Specialists"
    print_info "Question: $question"
    echo ""
    
    # Validate session
    if ! validate_session_state "$SESSION_NAME" 8; then
        print_error "Please run './tmux_layout.sh' first to create the session"
        return 1
    fi
    
    # Generate question ID
    local question_id=$(generate_question_id)
    print_info "Question ID: $question_id"
    
    # Initialize log
    local log_file="$GEMINI_SQUAD_LOGS/type08_flat_${question_id}.log"
    init_log_file "$log_file" "$SESSION_NAME" "$question"
    
    print_step "Step 1: Instructing all specialists directly..."
    
    # Instruct Technical Boss (B)
    print_info "📤 Instructing Technical Boss (b)..."
    local tech_boss_instructions=(
        ""
        "$(get_role_instruction "technical_boss" "$question")"
        ""
        "Please provide technical leadership analysis:"
        "• Overall technical strategy and direction"
        "• Technology stack and architecture decisions"
        "• Technical team coordination and management"
        "• Integration with system design and implementation"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$TECH_BOSS_PANE" "${tech_boss_instructions[@]}"
    append_to_log "$log_file" "Technical Boss instructions sent to pane $TECH_BOSS_PANE" "INFO"
    
    # Instruct System Design Specialist (C)
    print_info "📤 Instructing System Design Specialist (c)..."
    local system_design_instructions=(
        ""
        "$(get_role_instruction "system_designer" "$question")"
        ""
        "Please analyze the system design aspects:"
        "• System architecture and design patterns"
        "• Component interactions and data flow"
        "• Scalability and performance considerations"
        "• Security and reliability requirements"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$SYSTEM_DESIGN_PANE" "${system_design_instructions[@]}"
    append_to_log "$log_file" "System Design instructions sent to pane $SYSTEM_DESIGN_PANE" "INFO"
    
    # Instruct Implementation Specialist (D)
    print_info "📤 Instructing Implementation Specialist (d)..."
    local implementation_instructions=(
        ""
        "$(get_role_instruction "implementation_lead" "$question")"
        ""
        "Please analyze the implementation aspects:"
        "• Development methodology and processes"
        "• Resource allocation and timeline planning"
        "• Technology implementation and deployment"
        "• Integration and testing strategies"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$IMPLEMENTATION_PANE" "${implementation_instructions[@]}"
    append_to_log "$log_file" "Implementation instructions sent to pane $IMPLEMENTATION_PANE" "INFO"
    
    # Instruct Quality Assurance Specialist (E)
    print_info "📤 Instructing Quality Assurance Specialist (e)..."
    local quality_instructions=(
        ""
        "$(get_role_instruction "quality_lead" "$question")"
        ""
        "Please analyze the quality assurance aspects:"
        "• Quality standards and testing frameworks"
        "• Risk assessment and mitigation strategies"
        "• Compliance and regulatory requirements"
        "• Performance monitoring and metrics"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$QUALITY_PANE" "${quality_instructions[@]}"
    append_to_log "$log_file" "Quality instructions sent to pane $QUALITY_PANE" "INFO"
    
    # Instruct Business Boss (F)
    print_info "📤 Instructing Business Boss (f)..."
    local business_boss_instructions=(
        ""
        "$(get_role_instruction "business_boss" "$question")"
        ""
        "Please provide business leadership analysis:"
        "• Overall business strategy and direction"
        "• Market positioning and competitive advantage"
        "• Business team coordination and management"
        "• Integration with market analysis and strategy"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$BUSINESS_BOSS_PANE" "${business_boss_instructions[@]}"
    append_to_log "$log_file" "Business Boss instructions sent to pane $BUSINESS_BOSS_PANE" "INFO"
    
    # Instruct Market Analysis Specialist (G)
    print_info "📤 Instructing Market Analysis Specialist (g)..."
    local market_analysis_instructions=(
        ""
        "$(get_role_instruction "market_analyst" "$question")"
        ""
        "Please analyze the market aspects:"
        "• Market opportunity and size assessment"
        "• Customer segments and target audience"
        "• Competitive landscape and positioning"
        "• Market trends and future outlook"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$MARKET_ANALYSIS_PANE" "${market_analysis_instructions[@]}"
    append_to_log "$log_file" "Market Analysis instructions sent to pane $MARKET_ANALYSIS_PANE" "INFO"
    
    # Instruct Business Strategy Specialist (H)
    print_info "📤 Instructing Business Strategy Specialist (h)..."
    local business_strategy_instructions=(
        ""
        "$(get_role_instruction "business_strategist" "$question")"
        ""
        "Please analyze the business strategy aspects:"
        "• Strategic planning and execution roadmap"
        "• Business model and revenue optimization"
        "• Resource allocation and investment priorities"
        "• Success metrics and performance indicators"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$BUSINESS_STRATEGY_PANE" "${business_strategy_instructions[@]}"
    append_to_log "$log_file" "Business Strategy instructions sent to pane $BUSINESS_STRATEGY_PANE" "INFO"
    
    print_step "Step 2: Setting up Presidential coordination..."
    
    # Setup President coordination
    focus_pane "$SESSION_NAME" "$PRESIDENT_PANE"
    local president_instructions=(
        ""
        "# PRESIDENTIAL COORDINATION - Type-08 Flat Structure"
        "# Question: $question"
        "# Question ID: $question_id"
        ""
        "✅ Instructions sent to all specialists:"
        "   🏗️  Technical Boss (b): Technical leadership and strategy"
        "   🔧 System Design (c): Architecture and design analysis"
        "   ⚙️  Implementation (d): Development and deployment analysis"
        "   🛡️  Quality Assurance (e): Quality and risk analysis"
        "   💼 Business Boss (f): Business leadership and strategy"
        "   📊 Market Analysis (g): Market opportunity analysis"
        "   🎯 Business Strategy (h): Strategic planning analysis"
        ""
        "📋 Coordination Process:"
        "   1. Monitor all specialist analyses in parallel"
        "   2. Gather comprehensive reports from all seven specialists"
        "   3. Synthesize technical and business perspectives"
        "   4. Make final comprehensive strategic decision"
        ""
        "🎛️  Navigation Guide:"
        "   • Ctrl+b, q, 1: Check Technical Boss (b)"
        "   • Ctrl+b, q, 2: Check System Design (c)"
        "   • Ctrl+b, q, 3: Check Implementation (d)"
        "   • Ctrl+b, q, 4: Check Quality Assurance (e)"
        "   • Ctrl+b, q, 5: Check Business Boss (f)"
        "   • Ctrl+b, q, 6: Check Market Analysis (g)"
        "   • Ctrl+b, q, 7: Check Business Strategy (h)"
        "   • Ctrl+b, q, 0: Return to President (a)"
        ""
        "⏳ Awaiting specialist reports..."
        ""
        "📊 Decision Framework:"
        "   • Technical Leadership: Strategic technical direction"
        "   • System Design: Architecture and scalability"
        "   • Implementation: Development feasibility and timeline"
        "   • Quality: Risk management and compliance"
        "   • Business Leadership: Strategic business direction"
        "   • Market Analysis: Market opportunity and demand"
        "   • Business Strategy: Strategic alignment and execution"
        ""
        "🎯 Final Decision Process:"
        "   1. Review technical leadership strategy and direction"
        "   2. Evaluate system design and architecture plans"
        "   3. Assess implementation feasibility and timeline"
        "   4. Consider quality standards and risk factors"
        "   5. Review business leadership strategy and direction"
        "   6. Analyze market opportunity and competitive position"
        "   7. Assess business strategy and execution roadmap"
        "   8. Synthesize into comprehensive strategic decision"
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRESIDENT_PANE" "${president_instructions[@]}"
    append_to_log "$log_file" "Presidential coordination setup completed" "INFO"
    
    echo ""
    print_success "Type-08 flat coordination initiated!"
    
    print_info "📊 Current Process Flow:"
    print_info "   President (a) ← Technical Boss (b)"
    print_info "                ← System Design (c)"
    print_info "                ← Implementation (d)"
    print_info "                ← Quality Assurance (e)"
    print_info "                ← Business Boss (f)"
    print_info "                ← Market Analysis (g)"
    print_info "                ← Business Strategy (h)"
    
    echo ""
    print_info "🎛️  To monitor progress:"
    print_info "   tmux attach-session -t $SESSION_NAME"
    
    echo ""
    print_info "📋 Expected Workflow:"
    print_info "   1. All seven specialists analyze simultaneously"
    print_info "   2. Each specialist reports findings to President"
    print_info "   3. President synthesizes all perspectives"
    print_info "   4. President makes comprehensive strategic decision"
    
    # Final log entry
    append_to_log "$log_file" "Type-08 flat ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "🚀 Comprehensive enterprise-level analysis in progress!"
    
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
if [ $# -eq 0 ]; then
    print_error "Question is required"
    echo ""
    echo "$USAGE"
    echo "$EXAMPLE"
    echo ""
    print_info "🎯 Type-08 Layout: Enterprise flat coordination structure"
    print_info "   President (a): Strategic coordination and decision making"
    print_info "   Technical Boss (b): Technical leadership and strategy"
    print_info "   System Design (c): Architecture and design"
    print_info "   Implementation (d): Development and deployment"
    print_info "   Quality Assurance (e): Quality and risk management"
    print_info "   Business Boss (f): Business leadership and strategy"
    print_info "   Market Analysis (g): Market research and analysis"
    print_info "   Business Strategy (h): Strategic planning and execution"
    exit 1
fi

QUESTION="$1"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

print_header "Starting Type-08 Flat Ask Process"
print_info "Architecture: President coordinates directly with 7 specialists"
print_info "Session: $SESSION_NAME"
print_info "Question: $QUESTION"
echo ""

# Execute flat ask
flat_ask_type08 "$QUESTION"
exit $?