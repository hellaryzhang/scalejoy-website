# scalejoy.org Deployment Runbook

This site is deployed as a static site via **GitHub Pages** with a custom domain.

## What Is Already Configured In This Folder

- `index.html`, `style.css`, `assets/` are the static site files.
- `CNAME` is set to `scalejoy.org` for custom domain mapping.
- `.nojekyll` disables Jekyll processing.
- `.github/workflows/deploy-pages.yml` auto-deploys on pushes to `main`.

## One-Time Setup (GitHub + DNS)

1. Create a new GitHub repo, for example: `scalejoy-website`.
2. Push this folder to that repo on the `main` branch.
3. In GitHub repo settings:
   - Go to `Settings -> Pages`
   - Under `Build and deployment`, choose `Source: GitHub Actions`
4. In your DNS provider for `scalejoy.org`, set:
   - `A` record: `@ -> 185.199.108.153`
   - `A` record: `@ -> 185.199.109.153`
   - `A` record: `@ -> 185.199.110.153`
   - `A` record: `@ -> 185.199.111.153`
   - `CNAME` record: `www -> <your-github-username>.github.io`
5. Back in GitHub `Settings -> Pages`, ensure the custom domain is `scalejoy.org` and enable HTTPS.

Notes:
- DNS propagation can take from a few minutes up to 24 hours.
- Keep the `CNAME` file committed, otherwise custom domain can reset.

## Deploying Updates (Normal Workflow)

1. Edit files locally.
2. Commit changes.
3. Push to `main`.
4. GitHub Actions workflow `Deploy GitHub Pages` runs automatically.
5. Validate live site:
   - `https://scalejoy.org`
   - `https://www.scalejoy.org`

## Fast Command Sequence

Run from this folder after your repo exists and remote is configured:

```bash
git add .
git commit -m "Update site content/design"
git push origin main
```

## Troubleshooting

- If `scalejoy.org` does not load:
  - Verify all 4 apex `A` records exist exactly as above.
  - Verify no conflicting AAAA/CNAME records on apex (`@`).
- If `www.scalejoy.org` fails:
  - Verify `www` CNAME points to `<your-github-username>.github.io`.
- If GitHub Action fails:
  - Open `Actions -> Deploy GitHub Pages` logs and check artifact upload/deploy steps.
- If custom domain disappears:
  - Re-check that `CNAME` file still exists in the repo root.

## Security / Operations Notes

- This is a static site, so no server runtime secrets are required.
- For ownership continuity, keep at least two GitHub org/repo admins.
- Consider enabling branch protection on `main` once stable.
