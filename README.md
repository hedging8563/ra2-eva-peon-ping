# Red Alert 2 EVA - Peon-Ping Sound Pack

Command & Conquer: Red Alert 2 EVA 播报语音，用于 [peon-ping](https://github.com/PeonPing/peon-ping)（Claude Code / AI 编码助手提示音）。

## 一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/hedging8563/ra2-eva-peon-ping/main/install.sh | bash
```

## 音效映射

| 事件 | 触发场景 | 音效 |
|------|---------|------|
| session.start | 会话开始 | Battle Control Online |
| task.complete | 任务完成 | Construction Complete / Unit Ready |
| task.acknowledge | 确认收到 | Incoming Transmission / Kirov Reporting |
| input.required | 需要输入 | Our Ally Is Under Attack |
| task.error | 任务出错 | Unit Lost |
| resource.limit | 资源不足 | Insufficient Funds / Low Power |
| user.spam | 用户刷屏 | Battle Control Terminated |

## 手动安装

```bash
git clone https://github.com/hedging8563/ra2-eva-peon-ping.git
cd ra2-eva-peon-ping
cp -r sounds openpeon.json ~/.claude/hooks/peon-ping/packs/ra2_eva/
peon packs use ra2_eva
```

## 切换 / 控制

```bash
peon packs use ra2_eva    # 切换到 RA2 EVA
peon toggle               # 静音/取消静音
peon status               # 查看状态
```
