// Intel iwlwifi driver for Fornax OS (AX200/AX210/AX211/BE200)
// Handles firmware upload, command rings, and raw 802.11 frame TX/RX
//
// Reference: Linux drivers/net/wireless/intel/iwlwifi/
// Firmware: linux-firmware/iwlwifi-*

const fx = @import("fornax");

pub fn main() void {
    // TODO: PCI discovery, firmware upload, command/TX/RX ring setup
    _ = fx;
}
