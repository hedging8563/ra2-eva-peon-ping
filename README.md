# Red Alert 2 EVA - Peon-Ping Sound Pack

Command & Conquer: Red Alert 2 EVA announcer voice pack for [peon-ping](https://github.com/PeonPing/peon-ping) (Claude Code / AI coding assistant sound notifications).

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/hedging8563/ra2-eva-peon-ping/master/install.sh | bash
```

## Sound Mapping

| Event | Trigger | Sound |
|-------|---------|-------|
| session.start | Session begins | Battle Control Online |
| task.complete | Task finished | Construction Complete / Unit Ready |
| task.acknowledge | Acknowledged | Incoming Transmission / Kirov Reporting |
| input.required | User input needed | Our Ally Is Under Attack |
| task.error | Command failed | Unit Lost |
| resource.limit | Context compacting | Insufficient Funds / Low Power |
| user.spam | Rapid messages | Battle Control Terminated |

## Manual Install

```bash
git clone https://github.com/hedging8563/ra2-eva-peon-ping.git
cd ra2-eva-peon-ping
mkdir -p ~/.claude/hooks/peon-ping/packs/ra2_eva
cp -r sounds openpeon.json ~/.claude/hooks/peon-ping/packs/ra2_eva/
peon packs use ra2_eva
```

## Controls

```bash
peon packs use ra2_eva    # Switch to RA2 EVA
peon toggle               # Mute / unmute
peon status               # Check status
```
