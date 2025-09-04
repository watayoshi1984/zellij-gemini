#!/bin/bash

# Gemini Squad Type-16 Hierarchical Ask Script
# 16-pane hierarchical structure: President → Bosses → Workers

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-16"
USAGE="Usage: $0 \"Your question here\""
EXAMPLE="Example: $0 \"Design and execute a comprehensive digital transformation strategy for a Fortune 500 company\""

# Pane assignments for Type-16 (0-15)
PRESIDENT_PANE=0
# Technical Division
TECH_BOSS_PANE=1
SYSTEM_ARCHITECT_PANE=2
LEAD_DEVELOPER_PANE=3
DEVOPS_ENGINEER_PANE=4
SECURITY_SPECIALIST_PANE=5
DATA_ARCHITECT_PANE=6
QUALITY_ENGINEER_PANE=7
# Business Division
BUSINESS_BOSS_PANE=8
STRATEGY_DIRECTOR_PANE=9
MARKET_ANALYST_PANE=10
FINANCE_DIRECTOR_PANE=11
OPERATIONS_MANAGER_PANE=12
PRODUCT_MANAGER_PANE=13
CUSTOMER_SUCCESS_PANE=14
COMPLIANCE_OFFICER_PANE=15

# =============================================================================
# TYPE-16 SPECIFIC FUNCTIONS
# =============================================================================

# Execute hierarchical coordination for Type-16
hierarchical_ask_type16() {
    local question="$1"
    
    print_header "Type-16 Hierarchical Coordination: President → Bosses → Workers"
    print_info "Question: $question"
    echo ""
    
    # Validate session
    if ! validate_session_state "$SESSION_NAME" 16; then
        print_error "Please run './tmux_layout.sh' first to create the session"
        return 1
    fi
    
    # Generate question ID
    local question_id=$(generate_question_id)
    print_info "Question ID: $question_id"
    
    # Initialize log
    local log_file="$GEMINI_SQUAD_LOGS/type16_tree_${question_id}.log"
    init_log_file "$log_file" "$SESSION_NAME" "$question"
    
    print_step "Step 1: Instructing Technical Boss for delegation..."
    
    # Technical Boss (1) - Delegation instructions
    print_info "📤 Instructing Technical Boss (1) for team delegation..."
    local tech_boss_instructions=(
        ""
        "$(get_role_instruction "technical_boss" "$question")"
        ""
        "🏗️  TECHNICAL BOSS DELEGATION TASK:"
        "Question: $question"
        "Question ID: $question_id"
        ""
        "Your mission: Analyze this enterprise challenge from a technical leadership perspective,"
        "then delegate specific technical tasks to your 6 technical specialists."
        ""
        "📋 Your Technical Team (Panes 2-7):"
        "   2️⃣  System Architect: Enterprise architecture and design"
        "   3️⃣  Lead Developer: Development leadership and standards"
        "   4️⃣  DevOps Engineer: Infrastructure and deployment"
        "   5️⃣  Security Specialist: Security architecture and compliance"
        "   6️⃣  Data Architect: Data strategy and architecture"
        "   7️⃣  Quality Engineer: Quality assurance and testing"
        ""
        "🎯 Process:"
        "   1. Analyze the technical aspects of this enterprise challenge"
        "   2. Break down into specific technical work packages"
        "   3. Use Tmux to delegate tasks to each specialist:"
        "      Ctrl+b, q, [2-7] to navigate to each pane"
        "      Give each specialist their specific assignment"
        "   4. Coordinate and integrate their findings"
        "   5. Report comprehensive technical analysis to President (Pane 0)"
        ""
        "🔧 Technical Analysis Framework:"
        "   • Architecture: System design and scalability"
        "   • Development: Implementation and standards"
        "   • Infrastructure: Platform and deployment"
        "   • Security: Protection and compliance"
        "   • Data: Information architecture and analytics"
        "   • Quality: Testing and assurance"
        ""
        "📊 Expected Deliverable:"
        "   Comprehensive technical feasibility assessment with:"
        "   • Architecture recommendations"
        "   • Implementation strategy"
        "   • Resource requirements"
        "   • Risk assessment"
        "   • Timeline estimates"
        ""
        "🎛️  Navigation: Ctrl+b, q, [number] to switch panes"
        "Ready to lead the technical analysis!"
    )
    send_multiline_to_pane "$SESSION_NAME" "$TECH_BOSS_PANE" "${tech_boss_instructions[@]}"
    append_to_log "$log_file" "Technical Boss delegation instructions sent to pane $TECH_BOSS_PANE" "INFO"
    
    print_step "Step 2: Instructing Business Boss for delegation..."
    
    # Business Boss (8) - Delegation instructions
    print_info "📤 Instructing Business Boss (8) for team delegation..."
    local business_boss_instructions=(
        ""
        "$(get_role_instruction "business_boss" "$question")"
        ""
        "💼 BUSINESS BOSS DELEGATION TASK:"
        "Question: $question"
        "Question ID: $question_id"
        ""
        "Your mission: Analyze this enterprise challenge from a business leadership perspective,"
        "then delegate specific business tasks to your 7 business specialists."
        ""
        "📋 Your Business Team (Panes 9-15):"
        "   9️⃣  Strategy Director: Strategic planning and execution"
        "   🔟 Market Analyst: Market research and competitive analysis"
        "   1️⃣1️⃣ Finance Director: Financial planning and analysis"
        "   1️⃣2️⃣ Operations Manager: Operations and process optimization"
        "   1️⃣3️⃣ Product Manager: Product strategy and roadmap"
        "   1️⃣4️⃣ Customer Success: Customer experience and retention"
        "   1️⃣5️⃣ Compliance Officer: Regulatory compliance and risk"
        ""
        "🎯 Process:"
        "   1. Analyze the business aspects of this enterprise challenge"
        "   2. Break down into specific business work packages"
        "   3. Use Tmux to delegate tasks to each specialist:"
        "      Ctrl+b, q, [9-15] to navigate to each pane"
        "      Give each specialist their specific assignment"
        "   4. Coordinate and integrate their findings"
        "   5. Report comprehensive business analysis to President (Pane 0)"
        ""
        "💡 Business Analysis Framework:"
        "   • Strategy: Vision, planning, and competitive positioning"
        "   • Market: Opportunity, customers, and competition"
        "   • Finance: ROI, budgeting, and sustainability"
        "   • Operations: Processes, efficiency, and scalability"
        "   • Product: Strategy, roadmap, and market fit"
        "   • Customer: Experience, retention, and success"
        "   • Compliance: Risk, regulations, and governance"
        ""
        "📊 Expected Deliverable:"
        "   Comprehensive business viability assessment with:"
        "   • Strategic recommendations"
        "   • Market opportunity analysis"
        "   • Financial projections"
        "   • Operational requirements"
        "   • Risk mitigation plan"
        ""
        "🎛️  Navigation: Ctrl+b, q, [number] to switch panes"
        "Ready to lead the business analysis!"
    )
    send_multiline_to_pane "$SESSION_NAME" "$BUSINESS_BOSS_PANE" "${business_boss_instructions[@]}"
    append_to_log "$log_file" "Business Boss delegation instructions sent to pane $BUSINESS_BOSS_PANE" "INFO"
    
    print_step "Step 3: Setting up Presidential coordination..."
    
    # Return to President pane for coordination
    focus_pane "$SESSION_NAME" "$PRESIDENT_PANE"
    local president_instructions=(
        ""
        "# PRESIDENTIAL COORDINATION - Type-16 Enterprise Hierarchical Structure"
        "# Question: $question"
        "# Question ID: $question_id"
        ""
        "✅ Hierarchical delegation initiated:"
        ""
        "🏗️  TECHNICAL DIVISION COORDINATION:"
        "   📤 Technical Boss (1): Delegating to 6 technical specialists"
        "      → System Architect (2): Architecture and design"
        "      → Lead Developer (3): Development and standards"
        "      → DevOps Engineer (4): Infrastructure and deployment"
        "      → Security Specialist (5): Security and compliance"
        "      → Data Architect (6): Data strategy and architecture"
        "      → Quality Engineer (7): Quality assurance and testing"
        ""
        "💼 BUSINESS DIVISION COORDINATION:"
        "   📤 Business Boss (8): Delegating to 7 business specialists"
        "      → Strategy Director (9): Strategic planning and execution"
        "      → Market Analyst (10): Market research and analysis"
        "      → Finance Director (11): Financial planning and analysis"
        "      → Operations Manager (12): Operations optimization"
        "      → Product Manager (13): Product strategy and roadmap"
        "      → Customer Success (14): Customer experience and retention"
        "      → Compliance Officer (15): Regulatory compliance and risk"
        ""
        "📋 Coordination Process:"
        "   1. Technical Boss (1) coordinates technical analysis (Panes 2-7)"
        "   2. Business Boss (8) coordinates business analysis (Panes 9-15)"
        "   3. Both bosses report comprehensive findings to President (0)"
        "   4. President synthesizes dual-axis analysis for strategic decision"
        ""
        "🎛️  Navigation Guide (Ctrl+b, q, [number]):"
        "   President: 0 | Tech Boss: 1 | Biz Boss: 8"
        "   Technical Team: 2-7 | Business Team: 9-15"
        ""
        "⏳ Awaiting comprehensive reports from both division bosses..."
        ""
        "📊 Enterprise Decision Framework:"
        "   • Technical Feasibility: Can it be built at enterprise scale?"
        "   • Business Viability: Will it deliver strategic value?"
        "   • Market Opportunity: Does it address market needs?"
        "   • Financial Sustainability: Is the ROI compelling?"
        "   • Operational Readiness: Can we execute effectively?"
        "   • Risk Management: Are risks acceptable and mitigated?"
        ""
        "🎯 Expected Workflow:"
        "   1. Division bosses analyze and delegate (5-10 minutes)"
        "   2. Specialists complete detailed analysis (10-15 minutes)"
        "   3. Bosses integrate and report findings (5 minutes)"
        "   4. President makes strategic decision (5 minutes)"
        ""
        "🏛️  Final Decision Process:"
        "   1. Technical Division Report Synthesis"
        "   2. Business Division Report Synthesis"
        "   3. Cross-Division Integration Analysis"
        "   4. Enterprise Strategic Decision and Roadmap"
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRESIDENT_PANE" "${president_instructions[@]}"
    append_to_log "$log_file" "Presidential coordination setup completed" "INFO"
    
    echo ""
    print_success "Type-16 enterprise hierarchical coordination initiated!"
    
    print_info "📊 Current Process Flow:"
    print_info "   President (0) ← Technical Boss (1) ← Technical Workers (2-7)"
    print_info "                ← Business Boss (8) ← Business Workers (9-15)"
    
    echo ""
    print_info "🎛️  To monitor progress:"
    print_info "   tmux attach-session -t $SESSION_NAME"
    
    echo ""
    print_info "📋 Expected Workflow:"
    print_info "   1. Bosses analyze and delegate to their teams"
    print_info "   2. Specialists complete detailed domain analysis"
    print_info "   3. Bosses integrate findings and report to President"
    print_info "   4. President synthesizes for enterprise strategic decision"
    
    # Final log entry
    append_to_log "$log_file" "Type-16 hierarchical ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "🚀 Enterprise-scale hierarchical analysis in progress!"
    
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
    print_info "🎯 Type-16 Layout: Enterprise hierarchical coordination structure"
    print_info "   President (0): Strategic coordination and decision making"
    print_info "   Technical Boss (1): Technical team leadership (manages 2-7)"
    print_info "   Business Boss (8): Business team leadership (manages 9-15)"
    exit 1
fi

QUESTION="$1"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

print_header "Starting Type-16 Enterprise Hierarchical Ask Process"
print_info "Architecture: President → Bosses → Specialists"
print_info "Session: $SESSION_NAME"
print_info "Question: $QUESTION"
echo ""

# Execute hierarchical ask
hierarchical_ask_type16 "$QUESTION"
exit $?