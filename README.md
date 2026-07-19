# kindle-timer

A minimal, high-contrast **Stopwatch** built as a single static `index.html`.
It uses a black-on-white, monospace design and is rotated 90° for landscape use
on low-power / e-ink browsers such as the Kindle Paperwhite's experimental
browser.

## Features

- Start / Stop / Lap / Reset
- Lap menu (tap the top of the screen): view all laps, or **Adjust stopwatch**
  to set the total to a specific time (30 min / 1 hour / 2 hours, or custom
  ±5 minute steps)
- Rotated sideways (the screen's left edge becomes the bottom) for landscape use
- No dependencies — pure HTML, CSS, and vanilla JavaScript
- Built to work on the old Kindle WebKit (no flexbox, no `vh`/`vw`, no arrow
  functions): uses block flow + CSS tables and sizes the rotation from JS

## Local usage

Just open `index.html` in any browser, or serve it locally:

```bash
python3 -m http.server 8000
# then visit http://localhost:8000
```

> Note: because it is rotated for the Kindle, it will appear sideways on a
> normal desktop browser. That is expected.

## Deployment (GitHub Pages)

Deployment is automated with GitHub Actions. On every push to `main`, the
workflow in `.github/workflows/deploy-pages.yml` publishes the site to GitHub
Pages (it enables Pages automatically via `actions/configure-pages`).

Once deployed, the app is available at:

```
https://kenfukuyama.github.io/kindle-timer/
```

> If the first deployment does not appear, confirm that **Settings → Pages →
> Build and deployment → Source** is set to **GitHub Actions**.
