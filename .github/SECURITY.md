# Security Policy

## Scope

fornax-wifi contains userspace WiFi drivers and an 802.11 stack for the Fornax
research/hobby OS. It is not intended for production use. That said, we take
correctness seriously — especially for code that handles untrusted wireless frames
and cryptographic key material.

## Reporting

If you find a security-relevant bug, open a regular GitHub issue. For this project,
public disclosure is fine — there are no production deployments to protect.

If you'd prefer to report privately, use GitHub's
[private vulnerability reporting](https://github.com/trashguy/fornax-wifi/security/advisories/new).

## What counts

- Buffer overflows in 802.11 frame parsing (crafted packets)
- WPA key handling bugs (key leakage, weak derivation)
- DMA mapping errors that could allow device-to-host attacks
- Firmware upload path traversal or tampering

## What doesn't

- Denial of service (a hobby OS with no uptime SLA)
- Bugs requiring physical access
