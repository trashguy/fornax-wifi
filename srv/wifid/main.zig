// wifid — 802.11 MAC layer server for Fornax OS
// Serves /dev/wifiN via IPC with Plan 9 ctl interface
//
// Handles: scanning, association, WPA2/WPA3 handshake, key management
// Bridges authenticated WiFi frames to /dev/etherN for netd consumption

const fx = @import("fornax");

pub fn main() void {
    // TODO: IPC server loop, 802.11 state machine, WPA handshake
    _ = fx;
}
