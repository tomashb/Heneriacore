# Minecraft Network Infrastructure

This directory contains configuration templates and launch scripts for the Velocity + Paper network described in ticket CORE-001.

## Structure

```
minecraft-network/
├── velocity/
│   └── velocity.toml
├── auth/
│   ├── server.properties
│   └── config/
│       ├── forwarding.secret
│       └── paper-global.yml
├── lobby-1/
│   └── ...
├── lobby-2/
│   └── ...
├── lobby-3/
│   └── ...
├── bedwars-1/
│   └── ...
├── bedwars-2/
│   └── ...
├── nexus-1/
│   └── ...
├── nexus-2/
│   └── ...
├── zombie-1/
│   └── ...
├── zombie-2/
│   └── ...
├── start-velocity.sh
├── start-server.sh
├── start-all.sh
└── stop-all.sh
```

Each backend server directory mirrors the expected layout of a Paper installation. JAR files are intentionally omitted; download the latest builds from [PaperMC](https://papermc.io/downloads) and place them as `paper.jar` (or `velocity.jar` for the proxy) before starting the network.

## Usage

1. Install Java 17 or newer and `screen`.
2. Download the required server JARs into the appropriate directories.
3. Update `config/paper-global.yml` and `config/forwarding.secret` with a unique shared secret across all backends.
4. Make the scripts executable:
   ```bash
   chmod +x start-velocity.sh start-server.sh start-all.sh stop-all.sh
   ```
5. Launch the full stack:
   ```bash
   ./start-all.sh
   ```
6. Stop all services:
   ```bash
   ./stop-all.sh
   ```

Review and adapt RAM allocations in `start-server.sh`/`start-all.sh` based on your hardware. The templates default to the port assignments specified in the ticket.
