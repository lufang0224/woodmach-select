# WoodMach Select

Hugo static catalog site for used woodworking machinery.

## Clone and sync

This project currently uses local layouts, but if a visual theme is added as a Git submodule later, clone with:

```powershell
git clone --recurse-submodules <your-repository-url>
```

If the repository was already cloned without submodules, run:

```powershell
git submodule update --init --recursive
```

## Local preview

Install Hugo Extended, then run:

```powershell
hugo server -D --bind 127.0.0.1 --port 1313 --disableFastRender
```

The `-D` flag shows draft equipment pages during local review.

## New equipment SOP

Create Chinese content first, then duplicate the same slug into English and Spanish after the copy is reviewed:

```powershell
hugo new content/zh/equipment/<machine-slug>.md
hugo new content/en/equipment/<machine-slug>.md
hugo new content/es/equipment/<machine-slug>.md
```

Recommended workflow for multilingual equipment:

1. Create and finish the English source page first:

```powershell
hugo new content/en/equipment/<machine-slug>.md
```

2. Generate translation draft files for the other languages:

```powershell
.\scripts\sync-equipment-languages.ps1 -Slug <machine-slug>
```

If Windows blocks PowerShell scripts, use the wrapper instead:

```powershell
.\scripts\sync-equipment-languages.cmd <machine-slug>
```

3. Ask Codex to translate the generated `[TRANSLATE]` fields in:

```text
content/zh/equipment/<machine-slug>.md
content/es/equipment/<machine-slug>.md
content/fr/equipment/<machine-slug>.md
content/pt/equipment/<machine-slug>.md
content/ar/equipment/<machine-slug>.md
```

Keep these fields identical across languages:

```text
slug
brandKey
status
cover
images
videos
```

Translate these fields:

```text
title
location
type
specs.label
features
support
body text
```

Use lowercase English slugs, for example:

```text
pinmai-pt67-cnc-six-side-drill-2023
haode-871jd-edge-bander-2021
```

Place media under:

```text
static/uploads/<machine-slug>/
```

Required media rule for WhatsApp sharing:

```text
static/uploads/<machine-slug>/cover.jpg
```

Every equipment page must point `cover` to this image. WhatsApp, Facebook, and other apps use this Open Graph image to create the preview card when a link is shared.

## Front Matter template

Use this structure for every machine. Keep field names unchanged so the templates render correctly.

```yaml
---
title: "2023 Pinmai PT67-1325 Six-Side CNC Drill"
brand: "Pinmai"
model: "PT67-1325"
year: "2023"
location: "Zunyi, Guizhou, China"
status: "available" # available, reserved, sold
type: "Six-side CNC drill"
cover: "/uploads/pinmai-pt67-cnc-six-side-drill-2023/cover.jpg"
images:
  - "/uploads/pinmai-pt67-cnc-six-side-drill-2023/cover.jpg"
  - "/uploads/pinmai-pt67-cnc-six-side-drill-2023/image-01.jpg"
videos:
  - "/uploads/pinmai-pt67-cnc-six-side-drill-2023/demo.mp4"
specs:
  - label: "Machine model"
    value: "PT67-1325"
  - label: "Motor power"
    value: "10KW"
  - label: "Working size"
    value: "1325mm"
  - label: "Voltage"
    value: "380V"
  - label: "Machine weight"
    value: "3800KG"
features:
  - "Drilling unit with automatic tool changing capability."
  - "Real photos and video are provided for remote condition review."
support: "We provide condition communication, setup guidance, and follow-up technical support."
---

Write the machine introduction here, including current condition, suitable production scenario, and items that should be confirmed before purchase.
```

When there is no video, omit the `videos` field or leave it as an empty list:

```yaml
videos: []
```

## Cloudflare Pages

- Build command: `hugo --minify`
- Build output directory: `public`
- Hugo version environment variable: `HUGO_VERSION=0.161.1`

Recommended Cloudflare Pages settings:

```text
Framework preset: Hugo
Build command: hugo --minify
Build output directory: public
Environment variable: HUGO_VERSION=0.161.1
```

If deploying with Wrangler after logging in:

```powershell
hugo --minify
npx wrangler pages deploy public --project-name woodmach-select
```

Update these before publishing:

- `baseURL` in `hugo.toml`
- `whatsapp` in `hugo.toml`
- `whatsappNumber` in `hugo.toml`
- `whatsappUrl` in `hugo.toml`
- `email` in `hugo.toml`
