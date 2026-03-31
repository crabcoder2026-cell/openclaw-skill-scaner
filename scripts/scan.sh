#!/bin/bash
# Skill Scanner Main Script
# Scans OpenClaw skills for security risks

set -e

SKILLS_DIR="${OPENCLAW_SKILLS_DIR:-$HOME/.openclaw/workspace/skills}"
SYSTEM_SKILLS_DIR="${OPENCLAW_SYSTEM_SKILLS_DIR:-$HOME/.nvm/versions/node/v24.13.1/lib/node_modules/openclaw/skills}"

echo "🔒 OpenClaw Skill Security Scanner"
echo "=================================="
echo ""

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ Skills directory not found: $SKILLS_DIR"
    exit 1
fi

TOTAL_RISKS=0
TOTAL_SKILLS=0

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

scan_skill() {
    local skill_path="$1"
    local skill_name=$(basename "$skill_path")
    local risk_level="🟢 Low"
    local risk_reason=""
    local api_keys=()
    local actions=()
    
    # Check for SKILL.md
    if [ ! -f "$skill_path/SKILL.md" ]; then
        risk_level="🟡 Medium"
        risk_reason="Missing SKILL.md documentation"
    fi
    
    # Scan for API key requirements in SKILL.md
    if [ -f "$skill_path/SKILL.md" ]; then
        while IFS= read -r line; do
            if [[ $line =~ (API_KEY|api_key|API_SECRET|TOKEN|token|secret) ]]; then
                key_name=$(echo "$line" | grep -oE '[A-Z_]+_(API_KEY|API_SECRET|TOKEN|KEY)' | head -1)
                if [ ! -z "$key_name" ]; then
                    api_keys+=("$key_name")
                fi
            fi
        done < "$skill_path/SKILL.md"
    fi
    
    # Scan scripts for risky patterns
    local scripts_dir="$skill_path/scripts"
    if [ -d "$scripts_dir" ]; then
        # Check for network calls
        if grep -r -E "(curl|wget|fetch|http|urllib|requests)" "$scripts_dir" 2>/dev/null | grep -v "^Binary"; then
            actions+=("Network calls detected")
            risk_level="🟡 Medium"
        fi
        
        # Check for file writes
        if grep -r -E "(>|write|save|download)" "$scripts_dir" 2>/dev/null | grep -v "Binary" | grep -v "read"; then
            actions+=("File write operations")
            risk_level="🟡 Medium"
        fi
        
        # Check for command execution
        if grep -r -E "(exec|eval|system|subprocess)" "$scripts_dir" 2>/dev/null | grep -v "Binary"; then
            actions+=("Command execution")
            risk_level="🔴 High"
        fi
        
        # Check for credential access
        if grep -r -E "(password|secret|key|token|credential)" "$scripts_dir" 2>/dev/null | grep -v "Binary" | grep -v "API_KEY"; then
            actions+=("Credential handling")
            risk_level="🔴 High"
        fi
    fi
    
    # Check if system skill (pre-installed)
    local is_system=""
    if [ -d "$SYSTEM_SKILLS_DIR/$skill_name" ]; then
        is_system=" [System]"
    fi
    
    # Output results
    echo "${risk_level} ${skill_name}${is_system}"
    
    if [ ${#api_keys[@]} -gt 0 ]; then
        echo "   ├─ Need: ${api_keys[*]}"
    fi
    
    if [ ${#actions[@]} -gt 0 ]; then
        for action in "${actions[@]}"; do
            echo "   ├─ Actions: ${action}"
        done
    fi
    
    if [ ! -z "$risk_reason" ]; then
        echo "   └─ ⚠️  ${risk_reason}"
    fi
    
    echo ""
}

echo "📁 Scanning: $SKILLS_DIR"
echo ""

# Scan user-installed skills
if [ -d "$SKILLS_DIR" ]; then
    for skill in "$SKILLS_DIR"/*/; do
        if [ -d "$skill" ]; then
            TOTAL_SKILLS=$((TOTAL_SKILLS + 1))
            scan_skill "$skill"
        fi
    done
fi

echo "=================================="
echo "Total skills scanned: ${TOTAL_SKILLS}"
echo ""
echo "💡 Run with --full for detailed API key analysis"
echo "💡 Run --report to generate markdown report"
