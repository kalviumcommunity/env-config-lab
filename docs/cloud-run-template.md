# Cloud Run Mapping

This document maps each environment-variable fix to its Cloud Run equivalent.
Config values are passed with `gcloud run deploy ... --set-env-vars` and secrets
are injected with `gcloud run deploy ... --set-secrets` (Secret Manager). Nothing
is baked into the image and nothing is committed to git.

## Configuration Variables (non-secret) → `--set-env-vars`

| Variable | Local source (.env / --env-file) | Cloud Run equivalent |
|----------|----------------------------------|----------------------|
| DATABASE_URL | `.env` loaded with `docker run --env-file .env` | `--set-env-vars DATABASE_URL="..."` |
| LOG_LEVEL | `.env` loaded with `docker run --env-file .env` | `--set-env-vars LOG_LEVEL="info"` |

## Secrets → `--set-secrets` (Secret Manager)

| Variable | Local source (runtime `-e`) | Cloud Run equivalent |
|----------|-----------------------------|----------------------|
| API_KEY | `docker run -e API_KEY="$API_KEY"` | `--set-secrets API_KEY=envlab-api-key:latest` |

## Notes
- The hardcoded `ENV API_KEY=super-secret-key` was removed from the Dockerfile so no secret is baked into any image layer.
- `LOGLEVEL` (typo) was removed from the Dockerfile; `LOG_LEVEL` is now provided as ordinary config at runtime.
- `.env` is listed in `.gitignore`; `.env.example` holds placeholder keys only.
