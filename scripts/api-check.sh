#!/bin/bash
# Check API Key Configuration Status

echo "🔑 API Key Configuration Status"
echo "=================================="
echo ""

# Load environment
ENV_FILE="$HOME/.openclaw/workspace/.env"
MEMORY_DIR="$HOME/.openclaw/workspace/memory"

declare -A KNOWN_KEYS=(
    ["TAVILY_API_KEY"]="Tavily Search API"
    ["OPENAI_API_KEY"]="OpenAI API (Images/Whisper)"
    ["AGENTMAIL_API_KEY"]="AgentMail Email Service"
    ["MATON_API_KEY"]="Maton Gateway (Twilio/ClickSend)"
    ["TELTEL_API_KEY"]="TelTel SMS Service"
    ["FREEMOBILE_SMS_USER"]="Free Mobile SMS User"
    ["FREEMOBILE_SMS_API_KEY"]="Free Mobile SMS API"
    ["BRAVE_API_KEY"]="Brave Search API"
)

check_key_status() {
    local key_name="$1"
    local description="$2"
    
    # Check environment
    local env_value="${!key_name}"
    
    # Check .env file
    local file_value=""
    if [ -f "$ENV_FILE" ]; then
        file_value=$(grep "^${key_name}=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2 | head -1)
    fi
    
    # Check memory files
    local mem_value=""
    if [ -d "$MEMORY_DIR" ]; then
        mem_value=$(grep -r "${key_name}" "$MEMORY_DIR" 2>/dev/null | grep -oE "${key_name}[\"']?\s*[:=]\s*[\"']?[^\s\"']+" | head -1)
    fi
    
    if [ ! -z "$env_value" ] || [ ! -z "$file_value" ]; then
        echo "✅ ${key_name}"
        echo "   └─ ${description}"
        if [ ! -z "$file_value" ]; then
            echo "      📁 Found in: .env"
        fi
        if [ ! -z "$mem_value" ]; then
            echo "      📝 Referenced in memory"
        fi
    else
        echo "❌ ${key_name}"
        echo "   └─ ${description}"
        echo "      💡 Required but not configured"
    fi
    echo ""
}

# Check all known keys
echo "Checking configured API keys..."
echo ""

for key in "${!KNOWN_KEYS[@]}"; do
    check_key_status "$key" "${KNOWN_KEYS[$key]}"
done

echo "=================================="
echo ""
echo "📝 Summary:"
echo "   Configured keys will be loaded into environment"
echo "   Missing keys will cause skills to fail silently"
echo ""
echo "💡 Recommendations:"
echo "   • Remove skills that require missing keys"
echo "   • Secure .env file with: chmod 600 ~/.openclaw/workspace/.env"
