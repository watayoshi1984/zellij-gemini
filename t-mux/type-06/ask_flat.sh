#!/bin/bash

# Gemini Squad Type-06 Flat Ask Script
# 6-pane flat structure: President coordinates with 5 specialists directly

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-6"
USAGE="Usage: $0 \"Your question here\""
EXAMPLE="Example: $0 \"Develop a comprehensive strategy for launching a new product\""

# Pane assignments for Type-06
PRESIDENT_PANE=0
TECHNICAL_PANE=1
BUSINESS_PANE=2
QUALITY_PANE=3
MARKET_PANE=4
STRATEGY_PANE=5

# =============================================================================
# TYPE-06 SPECIFIC FUNCTIONS
# =============================================================================

# Execute flat coordination for Type-06
flat_ask_type06() {
    local question="$1"
    
    print_header "Type-06 Flat Coordination: President + 5 Specialists"
    print_info "Question: $question"
    echo ""
    
    # Validate session
    if ! validate_session_state "$SESSION_NAME" 6; then
        print_error "Please run './tmux_layout.sh' first to create the session"
        return 1
    fi
    
    # Generate question ID
    local question_id=$(generate_question_id)
    print_info "Question ID: $question_id"
    
    # Initialize log
    local log_file="$GEMINI_SQUAD_LOGS/type06_flat_${question_id}.log"
    init_log_file "$log_file" "$SESSION_NAME" "$question"
    
    print_step "Step 1: Instructing specialists directly..."
    
    # Instruct Technical Specialist (B)
    print_info "📤 Instructing Technical Specialist (b)..."
    local tech_instructions=(
        ""
        "$(get_role_instruction "technical_lead" "$question")"
        ""
        "Please analyze the technical aspects:"
        "• Technical architecture and system design"
        "• Technology stack and infrastructure requirements"
        "• Development timeline and resource allocation"
        "• Technical risks and scalability considerations"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$TECHNICAL_PANE" "${tech_instructions[@]}"
    append_to_log "$log_file" "Technical instructions sent to pane $TECHNICAL_PANE" "INFO"
    
    # Instruct Business Specialist (C)
    print_info "📤 Instructing Business Specialist (c)..."
    local business_instructions=(
        ""
        "$(get_role_instruction "business_lead" "$question")"
        ""
        "Please analyze the business aspects:"
        "• Business model and value proposition"
        "• Revenue streams and cost structure"
        "• Operational requirements and processes"
        "• Financial projections and ROI analysis"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$BUSINESS_PANE" "${business_instructions[@]}"
    append_to_log "$log_file" "Business instructions sent to pane $BUSINESS_PANE" "INFO"
    
    # Instruct Quality Specialist (D)
    print_info "📤 Instructing Quality Specialist (d)..."
    local quality_instructions=(
        ""
        "$(get_role_instruction "quality_lead" "$question")"
        ""
        "Please analyze the quality aspects:"
        "• Quality assurance framework and standards"
        "• Testing strategy and validation processes"
        "• Risk management and compliance requirements"
        "• Performance metrics and monitoring"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$QUALITY_PANE" "${quality_instructions[@]}"
    append_to_log "$log_file" "Quality instructions sent to pane $QUALITY_PANE" "INFO"
    
    # Instruct Market Analysis Specialist (E)
    print_info "📤 Instructing Market Analysis Specialist (e)..."
    local market_instructions=(
        ""
        "$(get_role_instruction "market_analyst" "$question")"
        ""
        "Please analyze the market aspects:"
        "• Market size and growth potential"
        "• Target customer segments and personas"
        "• Competitive landscape and positioning"
        "• Market entry strategy and timing"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$MARKET_PANE" "${market_instructions[@]}"
    append_to_log "$log_file" "Market instructions sent to pane $MARKET_PANE" "INFO"
    
    # Instruct Strategy Specialist (F)
    print_info "📤 Instructing Strategy Specialist (f)..."
    local strategy_instructions=(
        ""
        "$(get_role_instruction "strategy_lead" "$question")"
        ""
        "Please analyze the strategic aspects:"
        "• Strategic alignment and objectives"
        "• Resource allocation and prioritization"
        "• Implementation roadmap and milestones"
        "• Success metrics and KPIs"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$STRATEGY_PANE" "${strategy_instructions[@]}"
    append_to_log "$log_file" "Strategy instructions sent to pane $STRATEGY_PANE" "INFO"
    
    print_step "Step 2: Setting up Presidential coordination..."
    
    # Setup President coordination
    focus_pane "$SESSION_NAME" "$PRESIDENT_PANE"
    local president_instructions=(
        ""
        "# PRESIDENTIAL COORDINATION - Type-06 Flat Structure"
        "# Question: $question"
        "# Question ID: $question_id"
        ""
        "✅ Instructions sent to all specialists:"
        "   🔧 Technical Specialist (b): Technical architecture analysis"
        "   💼 Business Specialist (c): Business model analysis"
        "   🛡️  Quality Specialist (d): Quality assurance analysis"
        "   📊 Market Analyst (e): Market opportunity analysis"
        "   🎯 Strategy Specialist (f): Strategic planning analysis"
        ""
        "📋 Coordination Process:"
        "   1. Monitor all specialist analyses in parallel"
        "   2. Gather comprehensive reports from all five specialists"
        "   3. Synthesize findings into integrated strategic plan"
        "   4. Make final comprehensive recommendation"
        ""
        "🎛️  Navigation Guide:"
        "   • Ctrl+b, q, 1: Check Technical Specialist (b)"
        "   • Ctrl+b, q, 2: Check Business Specialist (c)"
        "   • Ctrl+b, q, 3: Check Quality Specialist (d)"
        "   • Ctrl+b, q, 4: Check Market Analyst (e)"
        "   • Ctrl+b, q, 5: Check Strategy Specialist (f)"
        "   • Ctrl+b, q, 0: Return to President (a)"
        ""
        "⏳ Awaiting specialist reports..."
        ""
        "📊 Decision Framework:"
        "   • Technical: Can we build it effectively?"
        "   • Business: Is it financially viable?"
        "   • Quality: Can we deliver it reliably?"
        "   • Market: Is there sufficient demand?"
        "   • Strategy: Does it align with our goals?"
        ""
        "🎯 Final Decision Process:"
        "   1. Review technical feasibility and architecture"
        "   2. Evaluate business model and financial projections"
        "   3. Consider quality standards and risk factors"
        "   4. Analyze market opportunity and competitive position"
        "   5. Assess strategic alignment and resource requirements"
        "   6. Synthesize into comprehensive go/no-go decision"
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRESIDENT_PANE" "${president_instructions[@]}"
    append_to_log "$log_file" "Presidential coordination setup completed" "INFO"
    
    echo ""
    print_success "Type-06 flat coordination initiated!"
    
    print_info "📊 Current Process Flow:"
    print_info "   President (a) ← Technical (b)"
    print_info "                ← Business (c)"
    print_info "                ← Quality (d)"
    print_info "                ← Market (e)"
    print_info "                ← Strategy (f)"
    
    echo ""
    print_info "🎛️  To monitor progress:"
    print_info "   tmux attach-session -t $SESSION_NAME"
    
    echo ""
    print_info "📋 Expected Workflow:"
    print_info "   1. All five specialists analyze simultaneously"
    print_info "   2. Each specialist reports findings to President"
    print_info "   3. President synthesizes all perspectives"
    print_info "   4. President makes comprehensive strategic decision"
    
    # Final log entry
    append_to_log "$log_file" "Type-06 flat ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "🚀 Comprehensive specialist analysis in progress!"
    
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
    print_info "🎯 Type-06 Layout: Comprehensive flat coordination structure"
    print_info "   President (a): Strategic coordination and decision making"
    print_info "   Technical (b): Technical architecture and development"
    print_info "   Business (c): Business model and operations"
    print_info "   Quality (d): Quality assurance and risk management"
    print_info "   Market (e): Market analysis and customer insights"
    print_info "   Strategy (f): Strategic planning and execution"
    exit 1
fi

QUESTION="$1"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

print_header "Starting Type-06 Flat Ask Process"
print_info "Architecture: President coordinates directly with 5 specialists"
print_info "Session: $SESSION_NAME"
print_info "Question: $QUESTION"
echo ""

# Execute flat ask
flat_ask_type06 "$QUESTION"
exit $?