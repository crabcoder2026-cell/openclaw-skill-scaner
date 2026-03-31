---
name: skill-scanner
emoji: 🔒
description: Security audit scanner for OpenClaw skills - scans installed skills for risks, API keys, usage patterns, and suspicious code.
author: chengbot
version: 1.0.0
---

# 🔒 Skill Scanner

> **Know what your OpenClaw skills are doing.**
> 
> Scan, audit, and secure your OpenClaw installation with beautiful, easy-to-read reports.

---

## ✨ What It Does

| 🤔 Question | ✅ Answer |
|------------|-----------|
| Which API keys do I need? | Auto-detects from SKILL.md files |
| Is this skill safe? | Risk grading with 🟢🟡🔴 |
| What's using network access? | Lists all external connections |
| Can I remove unused skills? | Shows usage + cleanup tips |

---

## 🚀 Quick Start (One Command)

```bash
./scripts/scan.sh
```

**Output preview:**
```
🔒 OpenClaw Skill Security Scanner
==================================

🟢 weather         [Low Risk]     ✅ Safe
🟡 tavily-search   [Medium Risk]  ⚠️  Network
🔴 agentmail       [High Risk]    ❗ Credentials
```

---

## 📋 Commands

### `scan.sh` — Quick Security Overview
```bash
./scripts/scan.sh
```
Shows all skills with risk levels (🟢 Low / 🟡 Medium / 🔴 High).

### `api-check.sh` — API Key Status
```bash
./scripts/api-check.sh
```
Shows which API keys are configured ✅ vs missing ❌.

### `report.sh` — Full Markdown Report
```bash
./scripts/report.sh my-audit.md
cat my-audit.md
```
Generates a detailed report you can share.

---

## 🎨 Risk Levels Explained

| Icon | Level | Meaning | Keep? |
|------|-------|---------|-------|
| 🟢 | Low | Read-only, no network | ✅ Safe |
| 🟡 | Medium | Network calls, file writes | ⚠️ Review |
| 🔴 | High | Credentials, commands | ❗ Check first |

---

## 🔍 What's Scanned

- ✅ API keys required by each skill
- ✅ Network access (curl, wget, http)
- ✅ File operations (read/write/delete)
- ✅ Command execution (exec, eval)
- ✅ Credential handling
- ✅ Usage patterns

---

## 🛡️ Safety

- ✅ **Read-only** — Never modifies skills
- ✅ **Local** — No network calls
- ✅ **Open source** — Review all code

---

## 💡 Example: Cleaning Up Skills

```bash
# Find high-risk skills you don't use
./scripts/scan.sh | grep "🔴" | grep "Never used"

# Example output:
# 🔴 agentmail [High Risk]
#    └─ Usage: Never used
#    └─ 💡 Recommendation: Remove

# Safe to remove:
rm -rf ~/.openclaw/workspace/skills/agentmail/
```

---

## 📦 Files

```
skill-scanner/
├── SKILL.md           # This file
├── README.md          # Full documentation
├── install.sh         # Auto-installer
└── scripts/
    ├── scan.sh        # Main scanner
    ├── api-check.sh   # Key checker
    └── report.sh      # Report generator
```

---

Made for the OpenClaw community ❤️
