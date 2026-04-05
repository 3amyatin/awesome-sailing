#!/usr/bin/env bash
set -euo pipefail

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

if ! grep -qF -- '## Start Here' README.md; then
  echo "Missing README heading: ## Start Here" >&2
  exit 1
fi

if ! grep -qF -- '## Cruising guides' README.md; then
  echo "Missing README heading: ## Cruising guides" >&2
  exit 1
fi

if ! grep -qF -- '# Cruising guides' docs/cruising-guides/README.md; then
  echo "Missing guide heading: # Cruising guides" >&2
  exit 1
fi

for heading in '## Germany' '## Croatia' '## Greece'; do
  if ! grep -qF -- "$heading" docs/cruising-guides/README.md; then
    echo "Missing guide heading: $heading" >&2
    exit 1
  fi
done

required_readme_links=(
  "[Germany](docs/cruising-guides/germany.md)"
  "[Croatia](docs/cruising-guides/croatia.md)"
  "[Greece](docs/cruising-guides/greece.md)"
  "[All cruising guides](docs/cruising-guides/README.md)"
)

for link in "${required_readme_links[@]}"; do
  if ! grep -qF -- "$link" README.md; then
    echo "Missing README link: $link" >&2
    exit 1
  fi
done

required_guide_links=(
  "[Germany guide](germany.md)"
  "[Croatia guide](croatia.md)"
  "[Greece guide](greece.md)"
)

for link in "${required_guide_links[@]}"; do
  if ! grep -qF -- "$link" docs/cruising-guides/README.md; then
    echo "Missing guide link: $link" >&2
    exit 1
  fi
done

echo "Structure check: PASS"
