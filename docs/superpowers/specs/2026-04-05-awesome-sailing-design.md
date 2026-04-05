# Awesome Sailing Design Spec

Date: 2026-04-05
Status: Draft approved in conversation, written for review
Repo target: `3amyatin/awesome-sailing`

## Summary

Create a public, English-first `awesome`-style GitHub repository for sailing resources, inspired by [`sindresorhus/awesome`](https://github.com/sindresorhus/awesome).

The repo should be:

- curated, not exhaustive
- readable and fast to scan
- useful for both newcomers and experienced sailors
- international by default, with extra strength in Europe and Germany
- built from a mix of public web resources and private research inputs

Private research inputs include Obsidian, Google Drive, and Workflowy. These sources are used to discover and organize candidates, but their raw private content must not be published directly.

## Goals

- Publish a high-quality public resource list around sailing.
- Put the best resources first in each section.
- Keep the main `README.md` mostly topic-based and easy to scan.
- Add a short `Start Here` section at the top for the strongest foundational resources.
- Add a dedicated `Cruising guides` section with destination pages split by country or region.
- Add a dedicated `Movies` section for films, documentaries, race films, and exceptional video resources.
- Include both free and paid resources, marking paid resources with `💳`.
- Allow non-English resources when worthwhile, marking them with a flag.
- Reuse the user's existing knowledge graph and resource collections without disclosing private material.

## Non-Goals

- Do not turn the repo into a full sailing wiki.
- Do not publish raw Obsidian notes, raw Workflowy nodes, or raw Google Drive documents.
- Do not publish private operational docs, personal plans, resumes, inventories, internal event files, or ambiguous material without explicit approval.
- Do not mirror copyrighted books, PDFs, or private files into the repo.
- Do not optimize for global coverage at the cost of curation quality.

## Audience

Primary audiences:

- people learning sailing
- racers and rules-focused sailors
- cruisers planning trips and destinations
- sailors looking for weather, navigation, safety, and app recommendations
- English-speaking readers, especially those interested in Europe or Germany

Secondary audiences:

- coaches
- clubs and organizers
- sailing-tech and open-source users

## Product Shape

The repo should follow the familiar `awesome` pattern:

- one main `README.md`
- flat sections with short annotated links
- strong curation instead of long unfiltered dumps

The list is topic-based, with one geography-heavy exception:

- destination-specific material lives under `Cruising guides`
- non-destination resources stay in topical sections

## Information Architecture

The main `README.md` should use these top-level sections:

1. `Start Here`
2. `Organizations`
3. `Education and certificates`
4. `Racing Rules of Sailing (RRS)`
5. `Regattas`
6. `Weather`
7. `Safety`
8. `Navigation`
9. `Boat handling`
10. `Sail trim`
11. `Offshore`
12. `Cruising guides`
13. `Apps`
14. `Communities`
15. `Movies`
16. `Books`

Notes:

- `Racing Rules of Sailing (RRS)` is fixed language and should not be renamed.
- `Apps` includes software from websites, app stores, and GitHub. There is no separate top-level `GitHub Projects` section.
- `Cruising guides` is the home for geography-specific sailing content, including Germany and other destinations.

Primary placement rules:

- `Organizations` is for governing bodies, federations, associations, and formal institutions.
- `Education and certificates` is for course systems, schools, certification frameworks, and learning-first resources.
- `Regattas` is for event calendars, event series, participation resources, and race discovery.
- `Communities` is for magazines, newsletters, forums, clubs, and ongoing community/media resources.
- A resource gets one primary home in the main README unless it is exceptional enough to justify a second appearance.

## Section Behavior

### Start Here

Purpose:

- give a newcomer the fastest path into the repo
- highlight the strongest 5-10 foundational resources

Selection bar:

- official or broadly trusted
- evergreen or actively maintained
- useful to a wide slice of sailors

### Cruising guides

Purpose:

- organize destination-specific practical resources
- avoid bloating the main `README.md`

Structure:

- the main README contains a short country/region list
- each destination links to a separate page

Initial likely destinations based on current source material:

- Germany
- Croatia
- Greece
- Italy
- Turkey
- France
- United Kingdom
- Thailand
- French Polynesia

Broader regions are allowed when they are more useful than a country split, for example:

- Baltic Sea
- Mediterranean
- Canary Islands

Each destination page should stay practical and concise. Recommended internal structure:

1. Overview
2. Official information
3. Ports and marinas
4. Weather
5. Rules and paperwork
6. Charter and local operators
7. Local apps and maps
8. Reading and references

Country versus region rules:

- Create a country page when the strongest practical material is country-specific and there are enough good public resources to make the page useful.
- Create a region page when the sailing reality is naturally cross-border or country pages would be too thin.
- Put cross-border resources in the narrowest useful page. If they are genuinely multi-country, prefer one regional page over duplicating them across country pages.
- Do not duplicate destination resources across many pages unless the duplication clearly improves usability.

Destination page format rules:

- Country and region pages may use a short prose intro of 2-4 sentences.
- Within each subsection, keep resources in the same one-line annotated link style as the main README.
- Short subsection notes are allowed when they help orientation, but destination pages should not turn into essays.

### Apps

Purpose:

- collect sailing-specific software and digital tools

Allowed content:

- navigation apps
- weather apps
- routing tools
- regatta and scoring apps
- marine data platforms
- open-source tools from GitHub

Suggested subsections if needed:

- Navigation
- Weather
- Racing
- Open source

### Movies

Purpose:

- collect films, documentaries, race films, and high-value sailing video resources

Allowed content:

- feature films about sailing
- documentaries
- race/event films

Excluded:

- random clips
- low-signal YouTube filler
- private recordings
- unofficial uploads when an official or neutral reference exists

Placement rule:

- Story-driven films, documentaries, and race-watch content belong in `Movies`.
- Instructional video belongs in the relevant topical section such as `Education and certificates`, `Boat handling`, `Sail trim`, or `Offshore`, not in `Movies`.

## Entry Format

Each list item should stay short and consistent:

```md
- [Resource Name](https://example.com) - One short reason it is worth opening. 💳 🇩🇪
```

Rules:

- best items first
- one short sentence only
- avoid marketing language
- avoid repeating the obvious
- no long paragraphs inside list items

## Emoji and Flag Policy

Default assumption:

- English-speaking
- international or broadly useful

Only add emoji when it adds useful signal.

Approved markers:

- `💳` for paid resources
- country flags such as `🇩🇪`, `🇫🇷`, `🇭🇷`, `🇬🇷` when language or regional focus matters
- `🇪🇺` only when a resource is clearly Europe-wide rather than country-specific

Avoid noisy tagging. Most entries should have no emoji at all.

For non-English resources, use the country flag as the language cue when that is the clearest simple signal, for example `🇩🇪` for German-language resources.

Flag meaning rules:

- `💳` marks pricing only.
- A country or region flag marks geography, language, or both when one simple flag usefully communicates that distinction.
- If a resource is both German-language and Germany-focused, a single `🇩🇪` is enough.
- Do not stack multiple flags unless the extra signal is genuinely useful.

## Curation Rules

Core rule:

- curate for usefulness, trust, and clarity, not for volume

Inclusion bar:

- clearly relevant to sailing
- still useful or maintained
- understandable to an English-speaking audience, or worth including with a flag
- materially better than generic search results

Ordering rule:

- strongest, most useful, and most official items first

Exclusion rule:

- duplicates unless the second item is genuinely distinct
- stale or dead links when better options exist
- private/internal resources
- items that are mainly personal context rather than public resources

README duplication rule:

- The main README should prefer one primary placement per resource.
- Cross-linking is allowed only for exceptionally central resources, for example a flagship app that belongs in both `Start Here` and `Apps`.

## Source Model

Four source classes feed the repo:

1. Private knowledge sources
2. Public GitHub discovery
3. Public web search
4. Official websites discovered through any source

### Private knowledge sources

Private knowledge sources are:

- Obsidian
- Google Drive
- Workflowy

These are research inputs only. They can contribute:

- public links
- cleaned titles
- rewritten short summaries
- category placement ideas
- destination-guide structure

They must not contribute:

- raw private notes
- raw document text
- personal context around a resource when that context is not public
- private files or copyrighted file mirrors

### Obsidian

Current Obsidian material is especially useful for:

- topic taxonomy
- racing and rules
- safety
- weather and routing
- sail trim and handling
- cruising destinations
- apps and organizations

Likely high-value vault areas include:

- `3Segeln`
- geography/travel sailing notes
- regatta collections
- safety and offshore notes

### Google Drive

Google Drive is useful for:

- spreadsheets and docs that already act as resource lists
- destination-related material
- rules, offshore, and regatta reference files
- books and movies discovery

Drive requires stronger filtering because it also contains:

- operational regatta files
- personal documents
- internal planning
- resumes
- media not suitable for publication

### Workflowy

Workflowy is useful for:

- resource discovery across collections
- link leads
- category ideas
- lightweight public-resource lists

Workflowy should be used in read-only mode for this project:

- `search`
- `get`
- `list`
- `report`

Do not use Workflowy write operations as part of repo curation.

### GitHub

GitHub is useful for:

- open-source sailing apps and platforms
- technical tools that belong under `Apps`
- the user's public stars and public sailing list as discovery signals

Examples already surfaced from the user's public GitHub signal:

- OpenCPN
- Signal K
- SAP Sailing Analytics
- rrs-finckh
- signal-flags-ts

### Web search

Web search is used to:

- verify that resources are active
- refresh outdated links
- find official sites for items discovered in private sources
- fill gaps where private notes are incomplete

Primary preference:

- official and primary sources first

## Approval Workflow

The repo should use a three-level inclusion policy:

### 1. Safe public items

Can be added directly when they are:

- clearly public
- clearly in scope
- not privacy-sensitive
- not ambiguous in ownership or context

Examples:

- official federation sites
- major public sailing apps
- official regatta calendars
- public open-source sailing software

### 2. Ambiguous items

Must be proposed to the user first.

Examples:

- something discovered inside a private note but not obviously intended for public reuse
- a Google Drive doc that mixes public links with private planning
- a personal shortlist that may reflect private judgment rather than a public recommendation

### 3. Private or operational items

Exclude by default.

Examples:

- internal event working documents
- resumes
- personal ops sheets
- inventories
- food planning
- contact lists
- anything that identifies private workflows without clear public value

## Proposed File Layout

Initial target structure:

```text
README.md
LICENSE
CONTRIBUTING.md
docs/
  cruising-guides/
    README.md
    germany.md
    croatia.md
    greece.md
    italy.md
    turkey.md
    france.md
    united-kingdom.md
```

Notes:

- start with a small number of destination pages that already have strong source material
- add more countries only when there is enough high-quality content
- `LICENSE` and `CONTRIBUTING.md` are part of the intended public launch surface

## Content Quality Bar by Section

### Organizations

Prefer:

- official governing bodies
- recognized sailing federations
- trusted training and safety organizations

### Education and certificates

Prefer:

- official certification systems
- strong learning platforms
- practical course directories

### Racing Rules of Sailing (RRS)

Prefer:

- official World Sailing resources
- respected explainers
- strong educational references

### Regattas

Prefer:

- official calendars
- established event series
- practical participation resources

### Weather

Prefer:

- trusted marine weather tools
- routing tools
- official forecast resources where relevant

### Safety

Prefer:

- incident databases
- offshore safety regulations
- respected training and seamanship resources

### Navigation

Prefer:

- charting tools
- marine electronics and data platforms
- practical navigation references

### Boat handling / Sail trim / Offshore

Prefer:

- resources with practical tactical value
- respected coaches, guides, and explainers
- material useful on the water, not just interesting trivia

### Communities

Prefer:

- strong publications
- clubs or communities with real signal
- high-value newsletters, forums, or media

### Movies

Prefer:

- titles that are culturally known in sailing
- documentaries or race films with strong practical or inspirational value

Movie entries should point to official pages, reputable catalogs, or legitimate viewing references rather than pirated uploads.

### Books

Prefer:

- enduring classics
- practical references
- books still recommended by active sailors

Do not publish pirated download links.

## Open Questions Resolved in This Spec

- The repo is English-first.
- The repo is international by default, with extra strength in Europe and Germany.
- Geography-specific content lives under `Cruising guides`, including Germany.
- `Movies` is a separate top-level section.
- `Apps` includes GitHub-hosted open-source tools, so there is no separate top-level `GitHub Projects` section.
- Paid resources are allowed and marked with `💳`.
- Non-English resources are allowed and marked with flags.

## Success Criteria

The design is successful if the first published version:

- feels like a real `awesome` list, not a private notebook dump
- is readable in under a few minutes
- helps a sailor discover genuinely useful resources quickly
- uses the user's private knowledge without exposing private material
- has a clean path to expand cruising destinations over time
- has enough editorial consistency that new additions remain coherent

## V1 Release Gates

The first public release should meet these checks:

- `README.md` includes `Start Here` and at least 8 strong non-empty topical sections.
- A top-level section may be omitted from v1 if it does not yet have at least 3 strong entries.
- `Cruising guides` is present in v1 with at least 3 destination pages, including `Germany`.
- Every published link is manually checked live at the time it is added.
- Every published item has a one-line annotation.
- Every paid item is marked `💳`.
- Non-English and strongly region-specific items are flagged only when the extra signal is useful.
- No ambiguous or private-source-derived item is published without explicit user approval.
