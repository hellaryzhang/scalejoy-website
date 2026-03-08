#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required. Install GitHub CLI first."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub auth is invalid or missing."
  echo "Run: gh auth login -h github.com"
  exit 1
fi

REPO_NAME="${1:-scalejoy-website}"
VISIBILITY="${2:-public}"

git rev-parse --is-inside-work-tree >/dev/null 2>&1

if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push
else
  git push -u origin main
fi

echo ""
echo "Repository published."
echo "Next:"
echo "1) Open repo Settings -> Pages and set Source to 'GitHub Actions'."
echo "2) Confirm CNAME is scalejoy.org."
echo "3) Configure DNS records listed in DEPLOYMENT.md."
