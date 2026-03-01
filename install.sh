#!/bin/bash
# ═══════════════════════════════════════════════════════
#  Red Alert 2 EVA Sound Pack Installer
#  Configures RA2 EVA announcer voices for Claude Code (peon-ping)
#
#  Usage: curl -fsSL https://raw.githubusercontent.com/hedging8563/ra2-eva-peon-ping/master/install.sh | bash
# ═══════════════════════════════════════════════════════

set -e

REPO="https://github.com/hedging8563/ra2-eva-peon-ping"
PEON_DIR="$HOME/.claude/hooks/peon-ping"
PACK_DIR="$PEON_DIR/packs/ra2_eva"

echo "═══════════════════════════════════════════"
echo "  Red Alert 2 EVA Sound Pack Installer"
echo "═══════════════════════════════════════════"
echo ""

# Step 1: Check/install peon-ping
if [ ! -f "$PEON_DIR/peon.sh" ]; then
    echo "peon-ping not found, installing..."
    curl -fsSL https://raw.githubusercontent.com/PeonPing/peon-ping/main/install.sh | bash
    echo ""
fi
echo "✓ peon-ping ready"

# Step 2: Download sound pack
echo ""
echo "Downloading RA2 EVA sound pack..."

TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

if command -v git &>/dev/null; then
    git clone --depth 1 "$REPO.git" "$TMP_DIR/repo" 2>/dev/null
else
    curl -fsSL "$REPO/archive/refs/heads/master.tar.gz" | tar xz -C "$TMP_DIR"
    mv "$TMP_DIR/ra2-eva-peon-ping-master" "$TMP_DIR/repo"
fi

echo "✓ Download complete"

# Step 3: Install sound pack
echo ""
echo "Installing..."
mkdir -p "$PACK_DIR/sounds"
cp "$TMP_DIR/repo/openpeon.json" "$PACK_DIR/"
cp "$TMP_DIR/repo/sounds/"* "$PACK_DIR/sounds/"

SOUND_COUNT=$(ls "$PACK_DIR/sounds/"*.wav 2>/dev/null | wc -l | tr -d ' ')
echo "✓ Installed $SOUND_COUNT sound files"

# Step 4: Activate
bash "$PEON_DIR/peon.sh" packs use ra2_eva 2>&1

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Installation complete!"
echo "═══════════════════════════════════════════"
echo ""
echo "Sound mapping:"
echo "  Session start  → Battle Control Online"
echo "  Task complete  → Construction Complete / Unit Ready"
echo "  Acknowledged   → Incoming Transmission / Kirov Reporting"
echo "  Input needed   → Our Ally Is Under Attack"
echo "  Task error     → Unit Lost"
echo "  Low resources  → Insufficient Funds / Low Power"
echo "  User spam      → Battle Control Terminated"
echo ""
echo "Controls:"
echo "  peon toggle          — Mute / unmute"
echo "  peon packs use NAME  — Switch sound pack"
echo "  peon status          — Check status"
echo ""
echo "Restart Claude Code to take effect."
