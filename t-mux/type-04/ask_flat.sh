#!/bin/bash

# Gemini Squad Type-04 Flat Ask Script
# 4-pane flat structure: President coordinates with 3 specialists directly

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-4"
USAGE="Usage: $0 \"Your question here\""
EXAMPLE="Example: $0 \"Analyze the feasibility of developing a new mobile app\""

# Pane assignments for Type-04
PRESIDENT_PANE=0
TECHNICAL_PANE=1
BUSINESS_PANE=2
QUALITY_PANE=3

# =============================================================================
# TYPE-04 SPECIFIC FUNCTIONS
# =============================================================================

# Execute flat coordination for Type-04
flat_ask_type04() {
    local question="$1"
    
    print_header "Type-04 Flat Coordination: President + 3 Specialists"
    print_info "Question: $question"
    echo ""
    
    # Validate session
    if ! validate_session_state "$SESSION_NAME" 4; then
        print_error "Please run './tmux_layout.sh' first to create the session"
        return 1
    fi
    
    # Generate question ID
    local question_id=$(generate_question_id)
    print_info "Question ID: $question_id"
    
    # Initialize log
    local log_file="$GEMINI_SQUAD_LOGS/type04_flat_${question_id}.log"
    init_log_file "$log_file" "$SESSION_NAME" "$question"

    
    print_step "Step 1: Instructing specialists directly..."
    
    # Instruct Technical Specialist (B)
    print_info "📤 Instructing Technical Specialist (b)..."
    local tech_instructions=(
        ""
        "$(get_role_instruction "technical_lead" "$question")"
        ""
        "Please analyze the technical aspects:"
        "• Technical feasibility and architecture"
        "• Technology stack recommendations"
        "• Development complexity and timeline"
        "• Technical risks and mitigation strategies"
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
        "• Market opportunity and target audience"
        "• Business model and revenue potential"
        "• Competitive landscape analysis"
        "• ROI and financial projections"
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
        "• Quality assurance strategy"
        "• Testing approach and coverage"
        "• Risk assessment and mitigation"
        "• Compliance and security considerations"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$QUALITY_PANE" "${quality_instructions[@]}"
    append_to_log "$log_file" "Quality instructions sent to pane $QUALITY_PANE" "INFO"

    
    print_step "Step 2: Setting up Presidential coordination..."
    
    # Setup President coordination
    focus_pane "$SESSION_NAME" "$PRESIDENT_PANE"
    local president_instructions=(
        ""
        "# PRESIDENTIAL COORDINATION - Type-04 Flat Structure"
        "# Question: $question"
        "# Question ID: $question_id"
        ""
        "✅ Instructions sent to all specialists:"
        "   🔧 Technical Specialist (b): Technical feasibility analysis"
        "   💼 Business Specialist (c): Business opportunity analysis"
        "   🛡️  Quality Specialist (d): Quality and risk analysis"
        ""
        "📋 Coordination Process:"
        "   1. Monitor specialist analyses in parallel"
        "   2. Gather reports from all three specialists"
        "   3. Synthesize findings into integrated decision"
        "   4. Make final strategic recommendation"
        ""
        "🎛️  Navigation Guide:"
        "   • Ctrl+b, q, 1: Check Technical Specialist (b)"
        "   • Ctrl+b, q, 2: Check Business Specialist (c)"
        "   • Ctrl+b, q, 3: Check Quality Specialist (d)"
        "   • Ctrl+b, q, 0: Return to President (a)"
        ""
        "⏳ Awaiting specialist reports..."
        ""
        "📊 Decision Framework:"
        "   • Technical Feasibility: Can we build it effectively?"
        "   • Business Viability: Should we build it profitably?"
        "   • Quality Assurance: Can we deliver it reliably?"
        ""
        "🎯 Final Decision Process:"
        "   1. Review technical feasibility assessment"
        "   2. Evaluate business opportunity analysis"
        "   3. Consider quality and risk factors"
        "   4. Synthesize into go/no-go recommendation"
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRESIDENT_PANE" "${president_instructions[@]}"
    append_to_log "$log_file" "Presidential coordination setup completed" "INFO"

    
    echo ""
    print_success "Type-04 flat coordination initiated!"
    
    print_info "📊 Current Process Flow:"
    print_info "   President (a) ← Technical (b)"
    print_info "                ← Business (c)"
    print_info "                ← Quality (d)"
    
    echo ""
    print_info "🎛️  To monitor progress:"
    print_info "   tmux attach-session -t $SESSION_NAME"
    
    echo ""
    print_info "📋 Expected Workflow:"
    print_info "   1. All specialists analyze simultaneously"
    print_info "   2. Each specialist reports findings to President"
    print_info "   3. President synthesizes all perspectives"
    print_info "   4. President makes integrated decision"
    
    # Final log entry
    append_to_log "$log_file" "Type-04 flat ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "🚀 Parallel specialist analysis in progress!"
    
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
    print_info "🎯 Type-04 Layout: Flat coordination structure"
    print_info "   President (a): Strategic coordination and decision making"
    print_info "   Technical (b): Technical feasibility and architecture"
    print_info "   Business (c): Market analysis and business strategy"
    print_info "   Quality (d): Quality assurance and risk management"
    exit 1
fi

QUESTION="$1"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

print_header "Starting Type-04 Flat Ask Process"
print_info "Architecture: President coordinates directly with 3 specialists"
print_info "Session: $SESSION_NAME"
print_info "Question: $QUESTION"
echo ""

# Execute flat ask
flat_ask_type04 "$QUESTION"
exit $?