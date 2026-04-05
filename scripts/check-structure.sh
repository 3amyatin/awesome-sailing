#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

required_files=(
  .gitignore
  README.md
  CONTRIBUTING.md
  LICENSE
  scripts/check-structure.sh
  docs/cruising-guides/README.md
  docs/cruising-guides/germany.md
  docs/cruising-guides/croatia.md
  docs/cruising-guides/greece.md
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing file: $file" >&2
    exit 1
  fi
done

for entry in '.DS_Store' '.private/' '.worktrees/'; do
  if ! grep -qFx -- "$entry" .gitignore; then
    echo "Missing .gitignore entry: $entry" >&2
    exit 1
  fi
done

readme_headings=(
  '## Start Here'
  '## Organizations'
  '## Education and certificates'
  '## Racing Rules of Sailing (RRS)'
  '## Regattas'
  '## Weather'
  '## Safety'
  '## Navigation'
  '## Boat handling'
  '## Sail trim'
  '## Offshore'
  '## Cruising guides'
  '## Apps'
  '## Communities'
  '## Movies'
  '## Books'
)

for heading in "${readme_headings[@]}"; do
  if ! grep -qFx -- "$heading" README.md; then
    echo "Missing README heading: $heading" >&2
    exit 1
  fi
done

if ! awk '
  function strip_comments(line) {
    gsub(/<!--[^>]*-->/, "", line)
    return line
  }
  /^## Cruising guides$/ { in_section=1; next }
  /^## / && in_section { exit }
  in_section {
    line = strip_comments($0)
    if (line ~ /[[:alnum:]]/ &&
        line ~ /\[Germany\]\(docs\/cruising-guides\/germany\.md\)/ &&
        line ~ /\[Croatia\]\(docs\/cruising-guides\/croatia\.md\)/ &&
        line ~ /\[Greece\]\(docs\/cruising-guides\/greece\.md\)/ &&
        line ~ /\[All cruising guides\]\(docs\/cruising-guides\/README\.md\)/) {
      found=1
    }
  }
  END { exit !found }
' README.md; then
  echo "Missing README cruising guides scaffold links" >&2
  exit 1
fi

if ! grep -qFx -- '# Cruising guides' docs/cruising-guides/README.md; then
  echo "Missing guide heading: # Cruising guides" >&2
  exit 1
fi

for heading in '## Germany' '## Croatia' '## Greece'; do
  if ! grep -qFx -- "$heading" docs/cruising-guides/README.md; then
    echo "Missing guide heading: $heading" >&2
    exit 1
  fi
done

if ! grep -qFx -- '## Privacy rule' CONTRIBUTING.md; then
  echo "Missing CONTRIBUTING heading: ## Privacy rule" >&2
  exit 1
fi

for term in 'Obsidian' 'Google Drive' 'Workflowy'; do
  if ! grep -qF -- "$term" CONTRIBUTING.md; then
    echo "Missing CONTRIBUTING privacy term: $term" >&2
    exit 1
  fi
done

guide_page_checks=(
  'docs/cruising-guides/germany.md|^# Germany( guide)?$'
  'docs/cruising-guides/croatia.md|^# Croatia( guide)?$'
  'docs/cruising-guides/greece.md|^# Greece( guide)?$'
)

for check in "${guide_page_checks[@]}"; do
  file="${check%%|*}"
  h1="${check#*|}"

  if ! grep -qEq -- "$h1" "$file"; then
    echo "Missing guide heading: $h1" >&2
    exit 1
  fi

  if ! grep -qF -- '[Cruising guides](README.md)' "$file"; then
    echo "Missing guide backlink: [Cruising guides](README.md)" >&2
    exit 1
  fi
done

required_readme_links=(
  '\[Germany\]\(docs/cruising-guides/germany\.md\)'
  '\[Croatia\]\(docs/cruising-guides/croatia\.md\)'
  '\[Greece\]\(docs/cruising-guides/greece\.md\)'
  '\[All cruising guides\]\(docs/cruising-guides/README\.md\)'
)

for pattern in "${required_readme_links[@]}"; do
  if ! grep -Eq -- "$pattern" README.md; then
    echo "Missing README link matching: $pattern" >&2
    exit 1
  fi
done

required_guide_links=(
  '^- \[Germany guide\]\(germany\.md\)( .*)?$'
  '^- \[Croatia guide\]\(croatia\.md\)( .*)?$'
  '^- \[Greece guide\]\(greece\.md\)( .*)?$'
)

for pattern in "${required_guide_links[@]}"; do
  if ! grep -Eq -- "$pattern" docs/cruising-guides/README.md; then
    echo "Missing guide link matching: $pattern" >&2
    exit 1
  fi
done

echo "Structure check: PASS"
