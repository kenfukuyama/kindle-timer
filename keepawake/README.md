# kindle-keepawake

A minimal [KUAL](https://wiki.mobileread.com/wiki/KUAL) extension that
temporarily prevents a jailbroken Kindle from sleeping, for a preset duration.
Useful for keeping a static page (e.g. a browser-based timer/stopwatch) visible
on the e-ink screen.

Author: Ken

## Tested environment

- Device: Kindle Paperwhite 4 (PW4)
- Firmware: 5.13.6
- Jailbroken, with KUAL (KUAL2) installed

## How it works

The stock sleep timeout (`system/daemon/powerd/t1_timeout`, default 600s / 10
min) cannot be changed persistently on this firmware — it lives in a read-only
`kdb.sec` (cramfs) layer, so `kdb set` is silently ignored even as root.

Instead of changing that value, this extension repeatedly resets powerd's sleep
countdown at runtime:

```sh
lipc-set-prop -i com.lab126.powerd touchScreenSaverTimeout 1
```

A background loop issues that reset every 4 minutes until the chosen deadline,
then stops — at which point the normal 10-minute sleep behavior resumes on its
own. No reboot needed, and it self-reverts.

> Note: This only works from the device side (shell/KUAL). A web page in the
> Kindle browser cannot call `lipc`, so keeping the screen awake must come from
> this extension, not from JavaScript.

## Installation

Copy the `keepawake` folder into your Kindle's `extensions` directory:

```
<KindleDrive>/extensions/keepawake/
    config.xml
    menu.json
    bin/
        keepawake.sh
        cancel.sh
```

- Keep the `.sh` files as UTF-8 with Unix (LF) line endings.
- No need to set executable permissions — the FAT drive can't store them and
  KUAL runs the scripts through the shell.

Then eject the Kindle and open KUAL. The "Keep awake" entries appear in the menu.

## Usage

Open KUAL and tap a duration:

| Button              | Duration | params  |
|---------------------|----------|---------|
| Keep awake 15 min   | 15 min   | `900`   |
| Keep awake 30 min   | 30 min   | `1800`  |
| Keep awake 1 hour   | 1 h      | `3600`  |
| Keep awake 2 hours  | 2 h      | `7200`  |
| Keep awake 3 hours  | 3 h      | `10800` |
| Keep awake 6 hours  | 6 h      | `21600` |
| Keep awake 12 hours | 12 h     | `43200` |
| Cancel keep awake   | stop     | —       |

- Tapping a new duration replaces any running one (tracked via a PID file at
  `/tmp/keepawake.pid`).
- **Cancel keep awake** stops the loop immediately; normal sleep resumes.
- A reboot clears an active session (the PID file lives in `/tmp`).

## Battery note

Keeping the screen on uses more power than normal e-ink sleep (roughly ~1.3%/hr
static vs ~0.33%/hr asleep). Use the longer presets (6h/12h) only when you truly
want an always-on display, ideally with airplane mode and low brightness.

## Customizing durations

Only `menu.json` controls the times — set each item's `params` to the number of
seconds you want. `keepawake.sh` reads that value; the scripts never need
editing.
