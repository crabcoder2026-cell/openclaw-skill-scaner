#!/bin/bash
# Install Skill Scanner

echo "🔒 Installing OpenClaw Skill Scanner..."

TARGET_DIR="${1:-$HOME/.openclaw/workspace/skills/skill-scanner}"

# Check if already installed
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  Skill Scanner already exists"
    echo "💡 Run 'rm -rf $TARGET_DIR' to reinstall"
    exit 1
fi

# Copy files
cp -r "$(dirname "$0")" "$TARGET_DIR"

# Make scripts executable
chmod +x "$TARGET_DIR/scripts/"*.sh

echo "✅ Skill Scanner installed!"
echo ""
echo "Next steps:"
echo "   cd $TARGET_DIR"
echo "   ./scripts/scan.sh         # Quick security scan"
echo "   ./scripts/api-check.sh      # Check API keys"
echo "   ./scripts/report.sh         # Generate full report"
