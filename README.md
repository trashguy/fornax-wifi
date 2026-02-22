# fornax-wifi

WiFi drivers and 802.11 stack for [Fornax OS](https://github.com/trashguy/Fornax). Each driver runs as a userspace file server, serving wireless frames via `/dev/wifiN` and exposing a Plan 9 control interface for scanning, authentication, and association.

## Architecture

WiFi on Fornax is split into three layers:

```
netd (TCP/IP stack)
  ↓ read/write /dev/etherN (bridged from wifi)
wifid (802.11 MAC + WPA)
  ↓ firmware commands + raw frames
WiFi driver (this repo)
  ↓ MMIO + DMA + firmware upload
Hardware
```

- **WiFi driver** — hardware-specific: firmware loading, command rings, frame TX/RX
- **wifid** — shared 802.11 MAC layer: scanning, association, WPA handshake, key management
- **netd** — unmodified, sees WiFi as another Ethernet-like interface

### Plan 9 interface

```
/dev/wifi0/
  ctl        RW  "scan", "connect SSID", "disconnect", "power on/off"
  status     R   connection state, SSID, BSSID, signal, channel
  scan       R   scan results (SSID, BSSID, signal, security)
  stats      R   TX/RX counters, retries, errors
  keys       W   "wpa PASSPHRASE" (write-only, never readable)
```

## Drivers

| Driver | Hardware | Firmware | Status |
|--------|----------|----------|--------|
| iwlwifi | Intel AX200/AX210/AX211/BE200 | Required (~200 MB total) | Planned |

## Structure

```
fornax-wifi/
├── iwlwifi/
│   ├── src/main.zig
│   ├── DEVICE_IDS
│   ├── firmware/
│   │   └── MANIFEST           # SHA-256 hashes + download URLs
│   └── build.zig
├── lib/
│   ├── wifi.zig               # shared 802.11 frame parsing
│   ├── wpa.zig                # WPA2/WPA3 handshake + key derivation
│   └── scan.zig               # BSS scan result management
├── srv/
│   └── wifid/
│       └── main.zig           # 802.11 MAC layer server
├── fay.toml
└── build.zig
```

## Installation

```
fay install iwlwifi
```

This downloads the required firmware blobs from [linux-firmware](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/iwlwifi) and installs them to `/lib/firmware/iwlwifi/`.

## Firmware

WiFi firmware blobs are required but **not included** in this repo. Each driver's `firmware/MANIFEST` lists the required files with SHA-256 checksums and download URLs. `fay install` fetches them automatically.

Manual download:
```sh
cd iwlwifi/firmware
./fetch.sh    # downloads from linux-firmware, verifies checksums
```

## Dependencies

Requires Fornax kernel phases G0-G4 (PCI enhancement, IOAPIC/MSI-X, device mmap, shared memory, IRQ forwarding).

## License

[MIT](LICENSE)

Driver-specific firmware blobs are distributed under their respective vendor licenses. See `LICENSES/` for details.
