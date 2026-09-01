# Cloud Run Mapping

## Configuration Variables
Non-secret configuration variables should be set as environment variables on the Cloud Run service.
- `DATABASE_URL` -> Use `--set-env-vars DATABASE_URL=...`
- `LOG_LEVEL` -> Use `--set-env-vars LOG_LEVEL=info`

## Secrets
Sensitive information like API keys should be stored in Google Cloud Secret Manager and mounted as environment variables.
- `API_KEY` -> Use `--set-secrets API_KEY=api-key-secret:latest`
