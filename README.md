# kindle-timer

A minimal, high-contrast **Split Timer** (stopwatch) built as a single static
`index.html`. It uses a black-on-white, monospace design that works well on
low-power / e-ink browsers such as the Kindle's experimental browser.

## Features

- Start / Stop the timer
- Record splits (lap + cumulative total)
- Reset everything
- No dependencies — pure HTML, CSS, and vanilla JavaScript

## Local usage

Just open `index.html` in any browser, or serve it locally:

```bash
python3 -m http.server 8000
# then visit http://localhost:8000
```

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
