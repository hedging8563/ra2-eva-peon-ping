#!/bin/bash
# ═══════════════════════════════════════════════════════
#  Red Alert 2 EVA 音效包 一键安装脚本
#  为 Claude Code (peon-ping) 配置红警2 EVA 播报语音
#
#  用法: curl -fsSL https://raw.githubusercontent.com/hedging8563/ra2-eva-peon-ping/main/install.sh | bash
# ═══════════════════════════════════════════════════════

set -e

REPO="https://github.com/hedging8563/ra2-eva-peon-ping"
PEON_DIR="$HOME/.claude/hooks/peon-ping"
PACK_DIR="$PEON_DIR/packs/ra2_eva"

echo "═══════════════════════════════════════════"
echo "  Red Alert 2 EVA 音效包安装器"
echo "═══════════════════════════════════════════"
echo ""

# Step 1: 检查/安装 peon-ping
if [ ! -f "$PEON_DIR/peon.sh" ]; then
    echo "peon-ping 未安装，正在安装..."
    curl -fsSL https://raw.githubusercontent.com/PeonPing/peon-ping/main/install.sh | bash
    echo ""
fi
echo "✓ peon-ping 已就绪"

# Step 2: 下载音效包
echo ""
echo "正在下载 RA2 EVA 音效包..."

TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

if command -v git &>/dev/null; then
    git clone --depth 1 "$REPO.git" "$TMP_DIR/repo" 2>/dev/null
else
    curl -fsSL "$REPO/archive/refs/heads/main.tar.gz" | tar xz -C "$TMP_DIR"
    mv "$TMP_DIR/ra2-eva-peon-ping-main" "$TMP_DIR/repo"
fi

echo "✓ 下载完成"

# Step 3: 安装音效包
echo ""
echo "正在安装..."
mkdir -p "$PACK_DIR/sounds"
cp "$TMP_DIR/repo/openpeon.json" "$PACK_DIR/"
cp "$TMP_DIR/repo/sounds/"* "$PACK_DIR/sounds/"

SOUND_COUNT=$(ls "$PACK_DIR/sounds/"*.wav 2>/dev/null | wc -l | tr -d ' ')
echo "✓ 已安装 $SOUND_COUNT 个音效文件"

# Step 4: 激活
bash "$PEON_DIR/peon.sh" packs use ra2_eva 2>&1

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ 安装完成！"
echo "═══════════════════════════════════════════"
echo ""
echo "音效映射:"
echo "  会话开始  → Battle Control Online"
echo "  任务完成  → Construction Complete / Unit Ready"
echo "  确认收到  → Incoming Transmission / Kirov Reporting"
echo "  需要输入  → Our Ally Is Under Attack"
echo "  任务出错  → Unit Lost"
echo "  资源不足  → Insufficient Funds / Low Power"
echo "  用户刷屏  → Battle Control Terminated"
echo ""
echo "控制:"
echo "  peon toggle          — 静音/取消静音"
echo "  peon packs use NAME  — 切换音效包"
echo "  peon status          — 查看状态"
echo ""
echo "重启 Claude Code 即可生效。"
