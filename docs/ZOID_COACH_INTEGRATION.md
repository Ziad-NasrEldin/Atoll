# Zoid Coach integration

This fork keeps Zoid Coach as a separate local macOS application.
Atoll owns notch presentation and interaction delivery.
Zoid Coach owns planning, persistence, private evidence, and all Apple automation.

## Compatibility contract

The extension descriptor metadata below is consumed only by this fork.
Stock Atoll ignores these keys safely.

| Metadata key | Type | Meaning |
| --- | --- | --- |
| `preferredWidth` | positive number encoded as a string | Requested expanded notch width in points. |
| `preferredHeight` | positive number encoded as a string | Requested expanded notch height in points. |

The host clamps width to the active display's safe notch width and height to its visible frame.
It never makes a surface smaller than the ordinary notch size.

The current Zoid Coach command center requests `1400 x 650`.
The host falls back to standard extension sizing when neither key is present.

## Source ownership

| Responsibility | Owner |
| --- | --- |
| Adaptive extension sizing and web-view layout | This Atoll fork |
| Native action callback transport | This fork and a future AtollExtensionKit fork |
| Prompt, plan, Calendar, and Reminders state | Zoid Coach |
| Screenwatch, OCR, and WhatsApp evidence | Zoid Coach |
| Accessibility fallback and full dashboard | Zoid Coach |

## Development notes

Start feature work from the `codex/zoid-integration` branch, which is pinned to upstream Atoll `v2.2.0`.
Keep `main` available for upstream sync.
Do not run the official Atoll app and this custom host simultaneously because both use the local extension RPC port.
