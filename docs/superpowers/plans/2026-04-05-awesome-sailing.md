# Awesome Sailing Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Launch a public `3amyatin/awesome-sailing` GitHub repository with an English-first, curated `awesome`-style README, initial cruising guide pages, privacy-safe sourcing from private research inputs, and basic verification for structure and links.

**Architecture:** The public repo surface stays small: a main `README.md`, contribution and license files, and destination pages under `docs/cruising-guides/`. Private sources are mined into ignored local working files under `.private/`, then only approved public links and rewritten annotations are promoted into the tracked repo. Verification is split between a repo structure check, markdown style/lint checks, and manual live-link review during curation.

**Tech Stack:** Markdown, Bash, Git, GitHub CLI, GitHub Actions, Google Workspace CLI (`gws`), `workflowy` CLI, `rg`

---

## File Structure

Public tracked files:

- `README.md` — main awesome list with topic sections and a short `Start Here`
- `CONTRIBUTING.md` — public contribution and curation rules, including privacy boundaries
- `LICENSE` — repository license
- `.gitignore` — ignore local-only research files and macOS noise
- `scripts/check-structure.sh` — repository structure and heading checks
- `.github/workflows/ci.yml` — CI for structure, awesome lint, and markdown link checks
- `docs/cruising-guides/README.md` — landing page for destination guides
- `docs/cruising-guides/germany.md` — Germany v1 guide
- `docs/cruising-guides/croatia.md` — Croatia v1 guide
- `docs/cruising-guides/greece.md` — Greece v1 guide

Local ignored working files:

- `.private/source-inventory/obsidian.txt` — raw sailing matches from Obsidian
- `.private/source-inventory/gdrive.tsv` — raw sailing matches from Google Drive
- `.private/source-inventory/workflowy.md` — raw sailing matches from Workflowy
- `.private/source-inventory/github-stars.json` — public GitHub discovery dump
- `.private/approval-queue.md` — curated `SAFE`, `AMBIGUOUS`, `REJECT` candidates before publishing

## Task 1: Preflight the Tooling and Scaffold the Public Repo Surface

**Files:**
- Create: `.gitignore`
- Create: `README.md`
- Create: `CONTRIBUTING.md`
- Create: `LICENSE`
- Create: `docs/cruising-guides/README.md`
- Create: `scripts/check-structure.sh`
- Test: `scripts/check-structure.sh`

- [ ] **Step 1: Run the tool and auth preflight**

Run:

```bash
command -v gh
command -v gws
command -v workflowy
command -v rg
command -v jq
command -v python3
gh auth status
gws drive files list --params '{"pageSize":1,"fields":"files(id,name),nextPageToken"}' --format json >/dev/null
workflowy --help >/dev/null
command -v node >/dev/null || command -v brew >/dev/null
```

Expected:

- all required CLIs are installed
- `gh` is authenticated
- `gws` can read Drive metadata
- `workflowy` responds
- either `node` is already available or Homebrew is available for installation later

- [ ] **Step 2: Write the failing structure check**

```bash
#!/usr/bin/env bash
set -euo pipefail

required_files=(
  "README.md"
  "CONTRIBUTING.md"
  "LICENSE"
  "docs/cruising-guides/README.md"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing file: $file"
    exit 1
  fi
done

required_headings=(
  "## Start Here"
  "## Cruising guides"
)

for heading in "${required_headings[@]}"; do
  if ! grep -Fq "$heading" README.md 2>/dev/null; then
    echo "Missing heading: $heading"
    exit 1
  fi
done

guide_headings=(
  "# Cruising guides"
  "## Germany"
  "## Croatia"
  "## Greece"
)

for heading in "${guide_headings[@]}"; do
  if ! grep -Fq "$heading" docs/cruising-guides/README.md 2>/dev/null; then
    echo "Missing guide heading: $heading"
    exit 1
  fi
done

echo "Structure check: PASS"
```

- [ ] **Step 3: Run the structure check to verify it fails**

Run: `bash scripts/check-structure.sh`

Expected: FAIL with `Missing file: README.md`

- [ ] **Step 4: Create the scaffold files**

```gitignore
.DS_Store
.private/
```

```md
# Awesome Sailing

Curated sailing resources in English, with extra depth for Europe and Germany. Resources are ordered best first. `💳` marks paid resources. Country flags are used only when they add useful signal.

## Start Here

## Organizations

## Education and certificates

## Racing Rules of Sailing (RRS)

## Regattas

## Weather

## Safety

## Navigation

## Boat handling

## Sail trim

## Offshore

## Cruising guides

- [Germany](docs/cruising-guides/germany.md)
- [Croatia](docs/cruising-guides/croatia.md)
- [Greece](docs/cruising-guides/greece.md)
- [All cruising guides](docs/cruising-guides/README.md)

## Apps

## Communities

## Movies

## Books
```

```md
# Contributing

Thanks for helping improve `awesome-sailing`.

## What belongs here

- public sailing resources that are genuinely useful
- short, factual annotations
- best resources first
- English-first resources, plus high-value non-English resources marked with a flag
- paid resources only when clearly useful, marked with `💳`

## What does not belong here

- private notes or internal documents
- copyrighted file mirrors
- low-signal link dumps
- marketing-heavy or stale resources when better options exist

## Privacy rule

Obsidian, Google Drive, and Workflowy may be used as research inputs, but raw private material must never be copied into the public repo. When in doubt, ask for approval before adding an item.
```

```text
MIT License

Copyright (c) 2026 Dmitry Zamyatin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

```md
# Cruising guides

Country and region guides for practical cruising research. These pages stay concise and link-focused.

## Germany

- [Germany guide](germany.md)

## Croatia

- [Croatia guide](croatia.md)

## Greece

- [Greece guide](greece.md)
```

- [ ] **Step 5: Save the structure check script and make it executable**

Run:

```bash
chmod +x scripts/check-structure.sh
```

Expected: no output

- [ ] **Step 6: Run the structure check to verify it passes**

Run: `bash scripts/check-structure.sh`

Expected: `Structure check: PASS`

- [ ] **Step 7: Commit**

```bash
git add .gitignore README.md CONTRIBUTING.md LICENSE docs/cruising-guides/README.md scripts/check-structure.sh
git commit -m "chore: scaffold awesome-sailing repo"
```

## Task 2: Create the Local Research Workspace and Approval Queue

**Files:**
- Create: `.private/source-inventory/obsidian.txt`
- Create: `.private/source-inventory/gdrive.tsv`
- Create: `.private/source-inventory/workflowy.md`
- Create: `.private/source-inventory/github-stars.json`
- Create: `.private/approval-queue.md`
- Test: `.gitignore`

- [ ] **Step 1: Create the local-only working directories**

Run:

```bash
mkdir -p .private/source-inventory
```

Expected: no output

- [ ] **Step 2: Extract sailing matches from private and public discovery sources**

Run:

```bash
rg -n -i '(sailing|segeln|yacht|regatta|offshore|gennaker|spinnaker|colregs|cruising|croatia|greece|germany|movie|film|documentary)' /Users/digy/Documents/Obsidian > .private/source-inventory/obsidian.txt

gws drive files list --params '{"q":"trashed = false and (name contains '\''sailing'\'' or name contains '\''Segeln'\'' or name contains '\''yacht'\'' or name contains '\''regatta'\'' or name contains '\''offshore'\'' or name contains '\''gennaker'\'' or name contains '\''spinnaker'\'' or name contains '\''movie'\'' or name contains '\''film'\'' or name contains '\''яхт'\'' or name contains '\''парус'\'')","pageSize":100,"fields":"files(id,name,mimeType,modifiedTime,webViewLink),nextPageToken"}' --page-all --page-limit 4 | jq -r '.files[] | [.mimeType,.name,.webViewLink] | @tsv' > .private/source-inventory/gdrive.tsv

workflowy search -i 'sailing|segeln|yacht|regatta|offshore|gennaker|spinnaker|croatia|greece|germany|movie|film|documentary' > .private/source-inventory/workflowy.md

gh api graphql -f query='query { viewer { starredRepositories(first: 100, orderBy: {field: STARRED_AT, direction: DESC}) { nodes { nameWithOwner description url isPrivate repositoryTopics(first: 10) { nodes { topic { name } } } } } } }' > .private/source-inventory/github-stars.json
```

Expected: all four files exist under `.private/source-inventory/`

- [ ] **Step 3: Create the approval queue template**

```md
# Approval Queue

## Start Here
### SAFE
### AMBIGUOUS
### REJECT

## Organizations
### SAFE
### AMBIGUOUS
### REJECT

## Education and certificates
### SAFE
### AMBIGUOUS
### REJECT

## Racing Rules of Sailing (RRS)
### SAFE
### AMBIGUOUS
### REJECT

## Regattas
### SAFE
### AMBIGUOUS
### REJECT

## Weather
### SAFE
### AMBIGUOUS
### REJECT

## Safety
### SAFE
### AMBIGUOUS
### REJECT

## Navigation
### SAFE
### AMBIGUOUS
### REJECT

## Boat handling
### SAFE
### AMBIGUOUS
### REJECT

## Sail trim
### SAFE
### AMBIGUOUS
### REJECT

## Offshore
### SAFE
### AMBIGUOUS
### REJECT

## Cruising guides
### SAFE
### AMBIGUOUS
### REJECT

## Apps
### SAFE
### AMBIGUOUS
### REJECT

## Communities
### SAFE
### AMBIGUOUS
### REJECT

## Movies
### SAFE
### AMBIGUOUS
### REJECT

## Books
### SAFE
### AMBIGUOUS
### REJECT
```

- [ ] **Step 4: Populate the queue with clearly safe seed items before asking for approval on ambiguous ones**

Copy these initial `SAFE` items into `.private/approval-queue.md`:

```md
## Start Here
### SAFE
- [World Sailing](https://www.sailing.org/) - Global governing body with rules, classes, and offshore resources.
- [RYA](https://www.rya.org.uk/) - Clear English-language entry point for learning, cruising, and racing.
- [Noonsite](https://www.noonsite.com/) - Practical cruising information and paperwork guidance by destination.
- [OpenCPN](https://opencpn.org/) - Widely used open-source navigation software.
- [PredictWind](https://www.predictwind.com/) - Strong weather and routing tool. 💳

## Apps
### SAFE
- [OpenCPN](https://opencpn.org/) - Open-source chartplotter and navigation software.
- [Signal K](https://signalk.org/) - Open marine data standard and server ecosystem.
- [PredictWind](https://www.predictwind.com/) - Forecasting and routing platform. 💳
- [Windy](https://www.windy.com/) - Fast weather visualization for route planning.
- [XyGrib](https://opengribs.org/en/) - Free GRIB viewer with sailing relevance.
```

- [ ] **Step 5: Sort the remaining candidates**

Rules:

- move obviously public and in-scope items to `SAFE`
- move anything mixed with personal context to `AMBIGUOUS`
- move internal docs, resumes, ops material, and copyrighted file mirrors to `REJECT`

- [ ] **Step 6: Refresh each `SAFE` candidate to an official or primary public URL**

Use web search for each `SAFE` item whose current URL is not obviously the official or primary public destination.

Expected:

- stale links are replaced
- official sites are preferred when available
- neutral catalog references are used for movies and books when official pages are weak or missing

- [ ] **Step 7: Verify the private workspace stays ignored**

Run: `git status --short`

Expected: no `.private/` paths appear

- [ ] **Step 8: Ask the user to approve anything under `AMBIGUOUS` before publishing**

Run:

```bash
sed -n '1,260p' .private/approval-queue.md
```

Expected: a reviewable queue with `SAFE`, `AMBIGUOUS`, and `REJECT` buckets

- [ ] **Step 9: After approval, move approved ambiguous items into `SAFE`**

Rule:

- anything published later must exist under `SAFE` in `.private/approval-queue.md`
- anything left under `AMBIGUOUS` must not be published

## Task 3: Fill the Foundation Sections in README

**Files:**
- Modify: `README.md`
- Test: `scripts/check-structure.sh`

- [ ] **Step 1: Copy approved `SAFE` and user-approved `AMBIGUOUS` bullets into the first five sections**

Update `README.md` so these sections are non-empty:

- `Start Here`
- `Organizations`
- `Education and certificates`
- `Racing Rules of Sailing (RRS)`
- `Regattas`

Use this exact insertion pattern:

```md
## Start Here

- [World Sailing](https://www.sailing.org/) - Global governing body with rules, classes, and offshore resources.
- [RYA](https://www.rya.org.uk/) - Clear English-language entry point for learning, cruising, and racing.
- [Noonsite](https://www.noonsite.com/) - Practical cruising information and paperwork guidance by destination.

## Organizations

- [World Sailing](https://www.sailing.org/) - Global governing body for the sport.
- [Royal Yachting Association](https://www.rya.org.uk/) - Major sailing authority and education provider. 🇬🇧
- [Deutscher Segler-Verband](https://www.dsv.org/) - Germany's national sailing federation. 🇩🇪
```

Then append additional approved bullets from `.private/approval-queue.md` under the matching sections.

- [ ] **Step 2: Keep the section boundaries strict while you curate**

Use these exact placement rules while editing:

```text
Organizations -> institutions and governing bodies
Education and certificates -> schools, course systems, certificates, training tracks
Racing Rules of Sailing (RRS) -> rules references and explainers
Regattas -> calendars, event series, participation resources
```

Expected: no duplicate placement unless a resource is exceptional enough to belong in `Start Here` plus one topic section

- [ ] **Step 3: Run the structure check**

Run: `bash scripts/check-structure.sh`

Expected: `Structure check: PASS`

- [ ] **Step 4: Manually open and verify each newly added link**

Run:

```bash
python3 - <<'PY' > /tmp/awesome-sailing-foundation-links.txt
from pathlib import Path
import re

text = Path("README.md").read_text()
capture = False
for line in text.splitlines():
    if line == "## Start Here":
        capture = True
        continue
    if capture and line == "## Weather":
        break
    match = re.search(r'\((https?://[^)]+)\)', line)
    if capture and match:
        print(match.group(1))
PY
while read -r url; do open "$url"; done < /tmp/awesome-sailing-foundation-links.txt
```

Expected: browser tabs open for each URL in the edited foundation sections, and each page is manually confirmed to match its annotation before continuing

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "feat: add foundation sailing resources"
```

## Task 4: Fill the Practical Sections in README

**Files:**
- Modify: `README.md`
- Test: `scripts/check-structure.sh`

- [ ] **Step 1: Add approved resources to the practical sections**

Fill these sections:

- `Weather`
- `Safety`
- `Navigation`
- `Boat handling`
- `Sail trim`
- `Offshore`
- `Apps`

Start with these seed bullets:

```md
## Weather

- [PredictWind](https://www.predictwind.com/) - Forecasting and routing platform used widely offshore. 💳
- [Windy](https://www.windy.com/) - Fast weather visualization for route planning.
- [XyGrib](https://opengribs.org/en/) - Free GRIB viewer with sailing relevance.

## Safety

- [MAIB recreational craft sail reports](https://www.gov.uk/maib-reports?vessel_type%5B%5D=recreational-craft-sail&cb=202601241246) - Official incident investigations for sail craft. 🇬🇧
- [World Sailing technical and offshore safety](https://www.sailing.org/) - Official offshore safety and technical references.

## Navigation

- [OpenCPN](https://opencpn.org/) - Widely used open-source chartplotter and navigator.
- [Signal K](https://signalk.org/) - Open marine data standard and server ecosystem.

## Apps

- [OpenCPN](https://opencpn.org/) - Open-source chartplotter and navigation software.
- [Signal K](https://signalk.org/) - Open marine data standard and server ecosystem.
- [PredictWind](https://www.predictwind.com/) - Forecasting and routing platform. 💳
```

Then append the rest of the approved bullets from `.private/approval-queue.md`.

- [ ] **Step 2: Keep instructional material out of `Movies`**

Use this editing rule:

```text
Instructional video goes into Education and certificates, Boat handling, Sail trim, or Offshore.
Movies is only for films, documentaries, and race-watch content.
```

Expected: no training videos are filed under `Movies`

- [ ] **Step 3: Run the structure check**

Run: `bash scripts/check-structure.sh`

Expected: `Structure check: PASS`

- [ ] **Step 4: Re-read the practical sections for annotation quality**

Run:

```bash
python3 - <<'PY' > /tmp/awesome-sailing-practical-links.txt
from pathlib import Path
import re

sections = {
    "## Weather",
    "## Safety",
    "## Navigation",
    "## Boat handling",
    "## Sail trim",
    "## Offshore",
    "## Apps",
}
text = Path("README.md").read_text().splitlines()
capture = False
for line in text:
    if line in sections:
        capture = True
    elif capture and line.startswith("## ") and line not in sections:
        capture = False
    if capture:
        match = re.search(r'\((https?://[^)]+)\)', line)
        if match:
            print(match.group(1))
PY
while read -r url; do open "$url"; done < /tmp/awesome-sailing-practical-links.txt
```

Expected: browser tabs open for each URL in the practical sections, and each page is manually confirmed live before the commit

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "feat: add practical sailing sections"
```

## Task 5: Fill Communities, Movies, and Books

**Files:**
- Modify: `README.md`
- Test: `scripts/check-structure.sh`

- [ ] **Step 1: Add approved items to `Communities`, `Movies`, and `Books`**

Use approved public references only. For `Movies` and `Books`, prefer official pages, reputable catalogs, or neutral references instead of download mirrors.

Start with this seed shape:

```md
## Movies

- [Maiden](https://en.wikipedia.org/wiki/Maiden_(2018_film)) - Documentary about Tracy Edwards and the first all-women Whitbread entry.
- [Deep Water](https://en.wikipedia.org/wiki/Deep_Water_(2006_film)) - Documentary about the 1968 Sunday Times Golden Globe Race.
- [Morning Light](https://en.wikipedia.org/wiki/Morning_Light_(film)) - Race-campaign documentary produced around a young crew's Transpac run.

## Books

- [The Annapolis Book of Seamanship](https://www.simonandschuster.com/books/The-Annapolis-Book-of-Seamanship/Fourth-Edition/John-Rousmaniere/9781982133140) - Modern seamanship reference that remains widely recommended. 💳
```

Then append additional approved entries from `.private/approval-queue.md`.

- [ ] **Step 2: Apply the flag and pricing rules while editing**

Use this exact rule set:

```text
Use 💳 only for paid resources.
Use a country flag only when it usefully signals language, geography, or both.
If one flag is enough, do not add more.
```

Expected: the sections stay visually light and easy to scan

- [ ] **Step 3: Run the structure check**

Run: `bash scripts/check-structure.sh`

Expected: `Structure check: PASS`

- [ ] **Step 4: Review the tail of README for readability**

Run:

```bash
python3 - <<'PY' > /tmp/awesome-sailing-culture-links.txt
from pathlib import Path
import re

sections = {"## Communities", "## Movies", "## Books"}
text = Path("README.md").read_text().splitlines()
capture = False
for line in text:
    if line in sections:
        capture = True
    elif capture and line.startswith("## ") and line not in sections:
        capture = False
    if capture:
        match = re.search(r'\((https?://[^)]+)\)', line)
        if match:
            print(match.group(1))
PY
while read -r url; do open "$url"; done < /tmp/awesome-sailing-culture-links.txt
```

Expected: browser tabs open for each URL in the edited culture sections, and each page is manually confirmed live before the commit

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "feat: add culture and media sections"
```

## Task 6: Build the Cruising Guide Pages for Germany, Croatia, and Greece

**Files:**
- Create: `docs/cruising-guides/germany.md`
- Create: `docs/cruising-guides/croatia.md`
- Create: `docs/cruising-guides/greece.md`
- Modify: `docs/cruising-guides/README.md`
- Test: `scripts/check-structure.sh`

- [ ] **Step 1: Create the country pages with explicit intros**

Use this exact page shape for Germany:

```md
# Germany

Germany is most useful here as a practical cruising and sailing-reference page: federation rules, local paperwork, clubs, weather, and coastal planning links in one place.

## Overview

## Official information

## Ports and marinas

## Weather

## Rules and paperwork

## Charter and local operators

## Local apps and maps

## Reading and references
```

Use these exact intros for the other pages:

```md
# Croatia

Croatia is one of Europe's busiest charter and flotilla destinations, so this page should prioritize practical trip-planning, marina, weather, and paperwork resources.

# Greece

Greece needs a practical guide focused on Ionian and Aegean trip planning, official references, weather, and reliable local sailing resources.
```

Reuse the same section structure for Croatia and Greece.

- [ ] **Step 2: Populate each page from approved public candidates**

Rules:

- use only `SAFE` or user-approved `AMBIGUOUS` items from `.private/approval-queue.md`
- keep bullets one line each
- prefer official, practical, current resources
- keep each page concise and useful
- create a country page only when the resources are truly country-specific; otherwise prefer a regional page later instead of duplicating links

Expected minimum for v1:

- 1 short intro
- at least 4 non-empty subsections
- at least 5 total public links per page

- [ ] **Step 3: Update the cruising-guides landing page**

Add one-line descriptions under each link:

```md
## Germany

- [Germany guide](germany.md) - Sailing and cruising references with a Germany focus.

## Croatia

- [Croatia guide](croatia.md) - High-value references for one of Europe's busiest charter destinations.

## Greece

- [Greece guide](greece.md) - Public resources for Ionian, Aegean, and practical trip planning.
```

Update the main `README.md` `Cruising guides` section at the same time so it contains the same short destination list, not just the index link.

- [ ] **Step 4: If Node.js is missing locally, install it before link checks**

Run:

```bash
command -v node >/dev/null || brew install node
```

Expected: `node` becomes available on the path

- [ ] **Step 5: Run the structure check and link checks**

Run:

```bash
bash scripts/check-structure.sh
npx --yes markdown-link-check docs/cruising-guides/README.md
npx --yes markdown-link-check docs/cruising-guides/germany.md
npx --yes markdown-link-check docs/cruising-guides/croatia.md
npx --yes markdown-link-check docs/cruising-guides/greece.md
```

Expected: all commands pass

- [ ] **Step 6: Manually open and verify the new cruising-guide links**

Run:

```bash
python3 - <<'PY' > /tmp/awesome-sailing-guide-links.txt
from pathlib import Path
import re

for path in [
    "README.md",
    "docs/cruising-guides/README.md",
    "docs/cruising-guides/germany.md",
    "docs/cruising-guides/croatia.md",
    "docs/cruising-guides/greece.md",
]:
    text = Path(path).read_text()
    for url in re.findall(r'https?://[^\s)]+', text):
        print(url)
PY
sort -u /tmp/awesome-sailing-guide-links.txt | while read -r url; do open "$url"; done
```

Expected: browser tabs open for the newly added guide URLs, and each destination page's links are manually confirmed live before the commit

- [ ] **Step 7: Commit**

```bash
git add README.md docs/cruising-guides/README.md docs/cruising-guides/germany.md docs/cruising-guides/croatia.md docs/cruising-guides/greece.md
git commit -m "feat: add initial cruising guides"
```

## Task 7: Add README Lint and Link Verification in CI

**Files:**
- Create: `.github/workflows/ci.yml`
- Test: `.github/workflows/ci.yml`

- [ ] **Step 1: Write the CI workflow**

```yaml
name: CI

on:
  push:
  pull_request:

jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Run structure check
        run: bash scripts/check-structure.sh

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "22"

      - name: Run awesome-lint
        run: npx --yes awesome-lint README.md

      - name: Run markdown link check
        run: |
          npx --yes markdown-link-check README.md
          npx --yes markdown-link-check docs/cruising-guides/README.md
          npx --yes markdown-link-check docs/cruising-guides/germany.md
          npx --yes markdown-link-check docs/cruising-guides/croatia.md
          npx --yes markdown-link-check docs/cruising-guides/greece.md
```

- [ ] **Step 2: Sanity-check the workflow file locally**

Run:

```bash
sed -n '1,220p' .github/workflows/ci.yml
```

Expected: one job named `verify` with structure, awesome-lint, and markdown link check steps

- [ ] **Step 3: Run the same checks locally**

Run:

```bash
bash scripts/check-structure.sh
npx --yes awesome-lint README.md
npx --yes markdown-link-check README.md
npx --yes markdown-link-check docs/cruising-guides/README.md
```

Expected: all commands pass

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "chore: add README verification workflow"
```

## Task 8: Final Verification and Publish the Public GitHub Repo

**Files:**
- Modify: `README.md` (only if verification reveals issues)
- Test: repo state and remote creation

- [ ] **Step 1: Run the full verification suite**

Run:

```bash
bash scripts/check-structure.sh
npx --yes awesome-lint README.md
npx --yes markdown-link-check README.md
npx --yes markdown-link-check docs/cruising-guides/README.md
npx --yes markdown-link-check docs/cruising-guides/germany.md
npx --yes markdown-link-check docs/cruising-guides/croatia.md
npx --yes markdown-link-check docs/cruising-guides/greece.md
python3 - <<'PY'
from pathlib import Path

text = Path("README.md").read_text().splitlines()
sections = {}
current = None
for line in text:
    if line.startswith("## "):
        current = line[3:]
        sections[current] = 0
    elif current and line.startswith("- ["):
        sections[current] += 1

start_here = sections.get("Start Here", 0)
topical = [
    name for name, count in sections.items()
    if name not in {"Start Here", "Cruising guides"} and count >= 3
]
print(f"start_here={start_here}")
print(f"topical_sections_with_3_plus={len(topical)}")
print("topical_names=" + ", ".join(topical))
PY
git status --short
```

Expected:

- all checks pass
- `start_here` is between 5 and 10
- `topical_sections_with_3_plus` is at least 8
- `git status --short` is empty

- [ ] **Step 2: Do the final provenance and privacy pass**

Run:

```bash
rg -n 'Obsidian|Workflowy|Google Drive|internal|private|resume|inventory|ops' README.md CONTRIBUTING.md docs/cruising-guides
python3 - <<'PY' > /tmp/published-urls.txt
from pathlib import Path
import re

paths = [
    "README.md",
    "docs/cruising-guides/README.md",
    "docs/cruising-guides/germany.md",
    "docs/cruising-guides/croatia.md",
    "docs/cruising-guides/greece.md",
]
seen = set()
for path in paths:
    text = Path(path).read_text()
    for url in re.findall(r'https?://[^\s)]+', text):
        seen.add(url)
for url in sorted(seen):
    print(url)
PY
python3 - <<'PY' > /tmp/approved-safe-urls.txt
from pathlib import Path
import re

text = Path(".private/approval-queue.md").read_text().splitlines()
capture = False
approved = set()
for line in text:
    if line.startswith("### "):
        capture = line == "### SAFE"
        continue
    if capture:
        match = re.search(r'\((https?://[^)]+)\)', line)
        if match:
            approved.add(match.group(1))
for url in sorted(approved):
    print(url)
PY
comm -23 /tmp/published-urls.txt /tmp/approved-safe-urls.txt
```

Expected:

- the grep does not reveal accidental private-source wording
- `comm -23` prints nothing, meaning every published URL is present under `SAFE` in `.private/approval-queue.md`

- [ ] **Step 3: If any verification step failed, fix and commit before publishing**

Run:

```bash
git add README.md CONTRIBUTING.md docs/cruising-guides/README.md docs/cruising-guides/germany.md docs/cruising-guides/croatia.md docs/cruising-guides/greece.md .github/workflows/ci.yml
git commit -m "chore: finalize awesome-sailing launch"
```

Only do this step if Step 1 or Step 2 revealed a real issue.

- [ ] **Step 4: Ask the user for final publish approval on the exact tracked content**

Run:

```bash
git status --short
git log --oneline -5
```

Expected:

- working tree is clean
- the user reviews the exact tracked repo state and explicitly approves publication before the next step

- [ ] **Step 5: Create the GitHub repository and push**

Run:

```bash
gh repo create 3amyatin/awesome-sailing --public --source=. --remote=origin --push
```

Expected: GitHub prints the new repository URL and the branch is pushed

- [ ] **Step 6: Set the repository metadata**

Run:

```bash
gh repo edit 3amyatin/awesome-sailing --description "Curated sailing resources in English, with extra depth for Europe and Germany." --homepage "https://github.com/3amyatin/awesome-sailing"
gh repo edit 3amyatin/awesome-sailing --add-topic awesome --add-topic awesome-list --add-topic sailing --add-topic yachting --add-topic cruising --add-topic regatta
```

Expected: repo description and topics are updated

- [ ] **Step 7: Verify the public repo page**

Run:

```bash
gh repo view 3amyatin/awesome-sailing --web
```

Expected: the public repository opens with the curated README, guide files, and metadata visible
