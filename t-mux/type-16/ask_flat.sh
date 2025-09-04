#!/bin/bash

# Gemini Squad Type-16 Flat Ask Script
# 16-pane flat structure: President coordinates with 15 specialists directly

# Source common functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../ask_common.sh"

# =============================================================================
# CONFIGURATION
# =============================================================================

SESSION_NAME="gemini-squad-16"
USAGE="Usage: $0 \"Your question here\""
EXAMPLE="Example: $0 \"Design and execute a comprehensive digital transformation for a large enterprise\""

# Pane assignments for Type-16 (0-15)
PRESIDENT_PANE=0
# Technical Division (1-7)
TECH_BOSS_PANE=1
SYSTEM_ARCHITECT_PANE=2
LEAD_DEVELOPER_PANE=3
DEVOPS_ENGINEER_PANE=4
SECURITY_SPECIALIST_PANE=5
DATA_ARCHITECT_PANE=6
QUALITY_ENGINEER_PANE=7
# Business Division (8-15)
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

# Execute flat coordination for Type-16
flat_ask_type16() {
    local question="$1"
    
    print_header "Type-16 Flat Coordination: President + 15 Specialists"
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
    local log_file="$GEMINI_SQUAD_LOGS/type16_flat_${question_id}.log"
    init_log_file "$log_file" "$SESSION_NAME" "$question"
    
    print_step "Step 1: Instructing Technical Division (8 specialists)..."
    
    # Technical Boss (1)
    print_info "📤 Instructing Technical Boss (1)..."
    local tech_boss_instructions=(
        ""
        "$(get_role_instruction "technical_boss" "$question")"
        ""
        "Technical Leadership Analysis:"
        "• Overall technical strategy and vision"
        "• Technology stack and platform decisions"
        "• Technical team coordination and management"
        "• Integration across all technical disciplines"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$TECH_BOSS_PANE" "${tech_boss_instructions[@]}"
    append_to_log "$log_file" "Technical Boss instructions sent to pane $TECH_BOSS_PANE" "INFO"
    
    # System Architect (2)
    print_info "📤 Instructing System Architect (2)..."
    local system_architect_instructions=(
        ""
        "$(get_role_instruction "system_architect" "$question")"
        ""
        "System Architecture Analysis:"
        "• Enterprise architecture design and patterns"
        "• System integration and interoperability"
        "• Scalability and performance architecture"
        "• Technology roadmap and evolution"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$SYSTEM_ARCHITECT_PANE" "${system_architect_instructions[@]}"
    append_to_log "$log_file" "System Architect instructions sent to pane $SYSTEM_ARCHITECT_PANE" "INFO"
    
    # Lead Developer (3)
    print_info "📤 Instructing Lead Developer (3)..."
    local lead_developer_instructions=(
        ""
        "$(get_role_instruction "lead_developer" "$question")"
        ""
        "Development Leadership Analysis:"
        "• Development methodology and best practices"
        "• Code quality and development standards"
        "• Team productivity and resource allocation"
        "• Implementation timeline and milestones"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$LEAD_DEVELOPER_PANE" "${lead_developer_instructions[@]}"
    append_to_log "$log_file" "Lead Developer instructions sent to pane $LEAD_DEVELOPER_PANE" "INFO"
    
    # DevOps Engineer (4)
    print_info "📤 Instructing DevOps Engineer (4)..."
    local devops_instructions=(
        ""
        "$(get_role_instruction "devops_engineer" "$question")"
        ""
        "DevOps and Infrastructure Analysis:"
        "• CI/CD pipeline design and automation"
        "• Infrastructure as Code and cloud strategy"
        "• Monitoring, logging, and observability"
        "• Deployment and release management"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$DEVOPS_ENGINEER_PANE" "${devops_instructions[@]}"
    append_to_log "$log_file" "DevOps Engineer instructions sent to pane $DEVOPS_ENGINEER_PANE" "INFO"
    
    # Security Specialist (5)
    print_info "📤 Instructing Security Specialist (5)..."
    local security_instructions=(
        ""
        "$(get_role_instruction "security_specialist" "$question")"
        ""
        "Security and Compliance Analysis:"
        "• Security architecture and threat modeling"
        "• Data protection and privacy compliance"
        "• Identity and access management"
        "• Security monitoring and incident response"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$SECURITY_SPECIALIST_PANE" "${security_instructions[@]}"
    append_to_log "$log_file" "Security Specialist instructions sent to pane $SECURITY_SPECIALIST_PANE" "INFO"
    
    # Data Architect (6)
    print_info "📤 Instructing Data Architect (6)..."
    local data_architect_instructions=(
        ""
        "$(get_role_instruction "data_architect" "$question")"
        ""
        "Data Architecture Analysis:"
        "• Data modeling and database design"
        "• Data integration and ETL processes"
        "• Analytics and business intelligence"
        "• Data governance and quality management"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$DATA_ARCHITECT_PANE" "${data_architect_instructions[@]}"
    append_to_log "$log_file" "Data Architect instructions sent to pane $DATA_ARCHITECT_PANE" "INFO"
    
    # Quality Engineer (7)
    print_info "📤 Instructing Quality Engineer (7)..."
    local quality_engineer_instructions=(
        ""
        "$(get_role_instruction "quality_engineer" "$question")"
        ""
        "Quality Engineering Analysis:"
        "• Testing strategy and automation framework"
        "• Quality metrics and performance benchmarks"
        "• Risk assessment and mitigation planning"
        "• Continuous quality improvement processes"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$QUALITY_ENGINEER_PANE" "${quality_engineer_instructions[@]}"
    append_to_log "$log_file" "Quality Engineer instructions sent to pane $QUALITY_ENGINEER_PANE" "INFO"
    
    print_step "Step 2: Instructing Business Division (8 specialists)..."
    
    # Business Boss (8)
    print_info "📤 Instructing Business Boss (8)..."
    local business_boss_instructions=(
        ""
        "$(get_role_instruction "business_boss" "$question")"
        ""
        "Business Leadership Analysis:"
        "• Overall business strategy and vision"
        "• Market positioning and competitive advantage"
        "• Business team coordination and management"
        "• Integration across all business functions"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$BUSINESS_BOSS_PANE" "${business_boss_instructions[@]}"
    append_to_log "$log_file" "Business Boss instructions sent to pane $BUSINESS_BOSS_PANE" "INFO"
    
    # Strategy Director (9)
    print_info "📤 Instructing Strategy Director (9)..."
    local strategy_director_instructions=(
        ""
        "$(get_role_instruction "strategy_director" "$question")"
        ""
        "Strategic Planning Analysis:"
        "• Long-term strategic planning and roadmap"
        "• Strategic initiatives and portfolio management"
        "• Competitive analysis and market positioning"
        "• Strategic partnerships and alliances"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$STRATEGY_DIRECTOR_PANE" "${strategy_director_instructions[@]}"
    append_to_log "$log_file" "Strategy Director instructions sent to pane $STRATEGY_DIRECTOR_PANE" "INFO"
    
    # Market Analyst (10)
    print_info "📤 Instructing Market Analyst (10)..."
    local market_analyst_instructions=(
        ""
        "$(get_role_instruction "market_analyst" "$question")"
        ""
        "Market Research Analysis:"
        "• Market size, growth, and opportunity assessment"
        "• Customer segmentation and persona development"
        "• Competitive landscape and market dynamics"
        "• Market trends and future outlook"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$MARKET_ANALYST_PANE" "${market_analyst_instructions[@]}"
    append_to_log "$log_file" "Market Analyst instructions sent to pane $MARKET_ANALYST_PANE" "INFO"
    
    # Finance Director (11)
    print_info "📤 Instructing Finance Director (11)..."
    local finance_director_instructions=(
        ""
        "$(get_role_instruction "finance_director" "$question")"
        ""
        "Financial Analysis:"
        "• Financial modeling and ROI analysis"
        "• Budget planning and resource allocation"
        "• Risk management and financial controls"
        "• Investment strategy and funding requirements"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$FINANCE_DIRECTOR_PANE" "${finance_director_instructions[@]}"
    append_to_log "$log_file" "Finance Director instructions sent to pane $FINANCE_DIRECTOR_PANE" "INFO"
    
    # Operations Manager (12)
    print_info "📤 Instructing Operations Manager (12)..."
    local operations_manager_instructions=(
        ""
        "$(get_role_instruction "operations_manager" "$question")"
        ""
        "Operations Analysis:"
        "• Operational processes and workflow optimization"
        "• Resource management and capacity planning"
        "• Performance metrics and KPI tracking"
        "• Change management and process improvement"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$OPERATIONS_MANAGER_PANE" "${operations_manager_instructions[@]}"
    append_to_log "$log_file" "Operations Manager instructions sent to pane $OPERATIONS_MANAGER_PANE" "INFO"
    
    # Product Manager (13)
    print_info "📤 Instructing Product Manager (13)..."
    local product_manager_instructions=(
        ""
        "$(get_role_instruction "product_manager" "$question")"
        ""
        "Product Management Analysis:"
        "• Product strategy and roadmap development"
        "• Feature prioritization and user experience"
        "• Product-market fit and customer validation"
        "• Go-to-market strategy and launch planning"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRODUCT_MANAGER_PANE" "${product_manager_instructions[@]}"
    append_to_log "$log_file" "Product Manager instructions sent to pane $PRODUCT_MANAGER_PANE" "INFO"
    
    # Customer Success (14)
    print_info "📤 Instructing Customer Success Manager (14)..."
    local customer_success_instructions=(
        ""
        "$(get_role_instruction "customer_success" "$question")"
        ""
        "Customer Success Analysis:"
        "• Customer journey and experience optimization"
        "• Customer retention and satisfaction metrics"
        "• Support strategy and service delivery"
        "• Customer feedback and product improvement"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$CUSTOMER_SUCCESS_PANE" "${customer_success_instructions[@]}"
    append_to_log "$log_file" "Customer Success instructions sent to pane $CUSTOMER_SUCCESS_PANE" "INFO"
    
    # Compliance Officer (15)
    print_info "📤 Instructing Compliance Officer (15)..."
    local compliance_instructions=(
        ""
        "$(get_role_instruction "compliance_officer" "$question")"
        ""
        "Compliance and Risk Analysis:"
        "• Regulatory compliance and legal requirements"
        "• Risk assessment and mitigation strategies"
        "• Policy development and governance framework"
        "• Audit preparation and compliance monitoring"
        ""
        "Report your findings to the President when ready."
    )
    send_multiline_to_pane "$SESSION_NAME" "$COMPLIANCE_OFFICER_PANE" "${compliance_instructions[@]}"
    append_to_log "$log_file" "Compliance Officer instructions sent to pane $COMPLIANCE_OFFICER_PANE" "INFO"
    
    print_step "Step 3: Setting up Presidential coordination..."
    
    # Setup President coordination
    focus_pane "$SESSION_NAME" "$PRESIDENT_PANE"
    local president_instructions=(
        ""
        "# PRESIDENTIAL COORDINATION - Type-16 Enterprise Flat Structure"
        "# Question: $question"
        "# Question ID: $question_id"
        ""
        "✅ Instructions sent to all 15 specialists:"
        ""
        "🏗️  TECHNICAL DIVISION (8 specialists):"
        "   1️⃣  Technical Boss: Technical leadership and strategy"
        "   2️⃣  System Architect: Enterprise architecture design"
        "   3️⃣  Lead Developer: Development leadership and standards"
        "   4️⃣  DevOps Engineer: Infrastructure and deployment"
        "   5️⃣  Security Specialist: Security and compliance"
        "   6️⃣  Data Architect: Data strategy and architecture"
        "   7️⃣  Quality Engineer: Quality assurance and testing"
        ""
        "💼 BUSINESS DIVISION (8 specialists):"
        "   8️⃣  Business Boss: Business leadership and strategy"
        "   9️⃣  Strategy Director: Strategic planning and execution"
        "   🔟 Market Analyst: Market research and analysis"
        "   1️⃣1️⃣ Finance Director: Financial planning and analysis"
        "   1️⃣2️⃣ Operations Manager: Operations and process optimization"
        "   1️⃣3️⃣ Product Manager: Product strategy and roadmap"
        "   1️⃣4️⃣ Customer Success: Customer experience and retention"
        "   1️⃣5️⃣ Compliance Officer: Regulatory compliance and risk"
        ""
        "📋 Coordination Process:"
        "   1. Monitor all 15 specialist analyses in parallel"
        "   2. Gather comprehensive reports from technical division"
        "   3. Gather comprehensive reports from business division"
        "   4. Synthesize technical and business perspectives"
        "   5. Make final enterprise-level strategic decision"
        ""
        "🎛️  Navigation Guide (Ctrl+b, q, [number]):"
        "   Technical: 1-7 | Business: 8-15 | President: 0"
        ""
        "⏳ Awaiting comprehensive specialist reports..."
        ""
        "📊 Enterprise Decision Framework:"
        "   • Technical feasibility across all domains"
        "   • Business viability and strategic alignment"
        "   • Market opportunity and competitive position"
        "   • Financial sustainability and ROI"
        "   • Operational readiness and scalability"
        "   • Risk management and compliance"
        ""
        "🎯 Final Decision Process:"
        "   1. Technical Division Analysis Synthesis"
        "   2. Business Division Analysis Synthesis"
        "   3. Cross-functional Integration Assessment"
        "   4. Enterprise-level Strategic Decision"
    )
    send_multiline_to_pane "$SESSION_NAME" "$PRESIDENT_PANE" "${president_instructions[@]}"
    append_to_log "$log_file" "Presidential coordination setup completed" "INFO"
    
    echo ""
    print_success "Type-16 enterprise flat coordination initiated!"
    
    print_info "📊 Current Process Flow:"
    print_info "   President (0) ← Technical Division (1-7)"
    print_info "                ← Business Division (8-15)"
    
    echo ""
    print_info "🎛️  To monitor progress:"
    print_info "   tmux attach-session -t $SESSION_NAME"
    
    echo ""
    print_info "📋 Expected Workflow:"
    print_info "   1. All 15 specialists analyze simultaneously"
    print_info "   2. Each specialist reports findings to President"
    print_info "   3. President synthesizes all perspectives"
    print_info "   4. President makes enterprise-level strategic decision"
    
    # Final log entry
    append_to_log "$log_file" "Type-16 flat ask completed successfully" "SUCCESS"
    
    echo ""
    print_success "🚀 Enterprise-scale comprehensive analysis in progress!"
    
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
    print_info "🎯 Type-16 Layout: Enterprise flat coordination structure"
    print_info "   President (0): Strategic coordination and decision making"
    print_info "   Technical Division (1-7): Complete technical expertise"
    print_info "   Business Division (8-15): Complete business expertise"
    exit 1
fi

QUESTION="$1"

# Validate question
if ! validate_question "$QUESTION"; then
    exit 1
fi

print_header "Starting Type-16 Enterprise Flat Ask Process"
print_info "Architecture: President coordinates directly with 15 specialists"
print_info "Session: $SESSION_NAME"
print_info "Question: $QUESTION"
echo ""

# Execute flat ask
flat_ask_type16 "$QUESTION"
exit $?