# 🔒 OpenClaw Skill Scanner

<p align="center">
  <img src="https://img.shields.io/badge/OpenClaw-Skill-blue?style=flat-square&logo=shield" alt="OpenClaw Skill">
  <img src="https://img.shields.io/badge/Security-Audit-brightgreen?style=flat-square&logo=security" alt="Security Audit">
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License">
</p>

<p align="center">
  <b>🔍 Know what your OpenClaw skills are doing.</b><br>
  Scan, audit, and secure your OpenClaw installation in seconds.
</p>

---

## 🎯 Why Use Skill Scanner?

| 🤔 Your Question | ✅ What Skill Scanner Does |
|------------------|---------------------------|
| "What API keys do I need?" | Auto-detects all required keys from SKILL.md files |
| "Is this skill safe to use?" | Risk grading with 🟢🟡🔴 color-coded levels |
| "Which skills actually get used?" | Tracks usage patterns and identifies bloat |
| "How do I clean up unused skills?" | Generates removal recommendations |

---

## 🚀 Quick Start (30 Seconds)

### 1. Install
```bash
# Via ClawHub (easiest)
clawhub install chengbot/skill-scanner

# Or manually
cd ~/.openclaw/workspace/skills
git clone https://github.com/chengbot/skill-scanner.git
cd skill-scanner && chmod +x scripts/*.sh
```

### 2. Run Your First Scan
```bash
./scripts/scan.sh
```

**Expected output:**
```
🔒 OpenClaw Skill Security Scanner
==================================

🟢 weather         [Low Risk]     ✅ Safe: Read-only
🟡 tavily-search   [Medium Risk]  ⚠️  Network calls
🔴 agentmail       [High Risk]    ❗ Handles credentials
```

### 3. Check Your API Keys
```bash
./scripts/api-check.sh
```

### 4. Generate Full Report
```bash
./scripts/report.sh my-security-audit.md
```

---

## 📸 What The Output Looks Like

### Scan Results
```
🔒 OpenClaw Skill Security Scanner
==================================
📁 Scanning: /home/user/.openclaw/workspace/skills

🟢 weather [Low Risk] [System]
   ├─ Need: None
   ├─ Usage: Frequent (2x/day)
   └─ Actions: curl wttr.in (read-only)

🟡 tavily-search [Medium Risk]
   ├─ Need: TAVILY_API_KEY ✅ (Configured)
   ├─ Usage: Frequent (2x/day)
   ├─ Actions: Network calls to API
   └─ 💡 Review: External API dependency

🔴 agentmail [High Risk]
   ├─ Need: AGENTMAIL_API_KEY ❌ (Missing)
   ├─ Usage: Never used
   ├─ Actions: Email sending, network calls, credential handling
   └─ 🗑️  Recommendation: Remove — keys not configured
```

### API Key Status
```
🔑 API Key Configuration Status
==================================

✅ TAVILY_API_KEY
   └─ Tavily Search API
      📁 Found in: .env file
      📝 Used 2x/day by tavily-search

❌ AGENTMAIL_API_KEY
   └─ AgentMail Email Service
      💡 Set with: export AGENTMAIL_API_KEY="your-key"
      🗑️  Skill "agentmail" can be removed
```

---

## 📊 Understanding Risk Levels

| Level | Icon | What It Means | Should You Keep It? |
|-------|------|---------------|---------------------|
| **Low** | 🟢 | No network, read-only files | ✅ Safe to keep |
| **Medium** | 🟡 | Network calls, file writes | ⚠️ Review first |
| **High** | 🔴 | Command execution, credentials | ❗ Audit code before using |

---

## 🔍 What Gets Scanned

```
Your Skills Directory
├── weather/
│   └── 🟢 Safe: Only reads weather data
├── tavily-search/
│   └── 🟡 Network: Calls external APIs
├── agentmail/
│   └── 🔴 High Risk: Handles email credentials
└── twilio-sms/
    └── 🔴 High Risk: Sends SMS, network calls
```

**Detection includes:**
- ✅ Required API keys from SKILL.md
- ✅ Network calls (curl, wget, http requests)
- ✅ File system operations (read, write, delete)
- ✅ Command execution (exec, eval, subprocess)
- ✅ Credential handling
- ✅ Usage frequency

---

## 📖 Detailed Usage

### `./scripts/scan.sh` — Basic Security Scan
```bash
# Quick overview of all skills
./scripts/scan.sh

# Save output
./scripts/scan.sh > my-scan.txt
```

### `./scripts/api-check.sh` — API Key Audit
```bash
# See which keys are configured
./scripts/api-check.sh

# Output includes:
# - ✅ Configured keys
# - ❌ Missing keys  
# - 💡 How to set them
```

### `./scripts/report.sh` — Generate Markdown Report
```bash
# Create shareable report
./scripts/report.sh security-audit.md

# View it
cat security-audit.md | less
# Or open in any Markdown viewer
```

---

## 🛡️ Safety First

- ✅ **Read-only** — Never modifies your skills
- ✅ **Local only** — No network calls
- ✅ **Transparent** — 100% open source, review the code
- ✅ **Non-destructive** — Only reports, never deletes

---

## 💡 Common Use Cases

### "I want to clean up unused skills"
```bash
./scripts/scan.sh | grep "Never used"
```

### "Show me only high-risk skills"
```bash
./scripts/scan.sh | grep "🔴 High"
```

### "What API keys am I missing?"
```bash
./scripts/api-check.sh | grep "❌"
```

---

## 🏗️ Project Structure

```
skill-scanner/
├── SKILL.md              ← OpenClaw manifest
├── README.md             ← This file
├── install.sh            ← One-command installer
├── scripts/
│   ├── scan.sh          ← Main scanner
│   ├── api-check.sh     ← Key checker
│   └── report.sh        ← Report generator
└── .github/
    └── workflows/
        └── test.yml     ← Automated tests
```

---

## 🤝 Contributing

Found a bug or have a feature request? Open an issue!

**Ideas for improvement:**
- Python/Node.js skill support
- Web dashboard
- JSON export format
- Continuous monitoring mode

---

## 📜 License

MIT License — OpenClaw Community

---

<p align="center">
  Made with ❤️ by <b>Chengbot</b> for the OpenClaw community
</p>
