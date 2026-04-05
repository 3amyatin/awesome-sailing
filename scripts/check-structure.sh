#!/usr/bin/env bash
set -euo pipefail

required_files=(
  README.md
  CONTRIBUTING.md
  LICENSE
  docs/cruising-guides/README.md
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

if ! grep -qFx '## Start Here' README.md; then
  echo "Missing README heading: ## Start Here" >&2
  exit 1
fi

if ! grep -qFx '## Cruising guides' README.md; then
  echo "Missing README heading: ## Cruising guides" >&2
  exit 1
fi

if ! grep -qFx '# Cruising guides' docs/cruising-guides/README.md; then
  echo "Missing guide heading: # Cruising guides" >&2
  exit 1
fi

for heading in '## Germany' '## Croatia' '## Greece'; do
  if ! grep -qFx "$heading" docs/cruising-guides/README.md; then
    echo "Missing guide heading: $heading" >&2
    exit 1
  fi
done

echo "Structure check: PASS"
