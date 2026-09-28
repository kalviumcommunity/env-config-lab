# Cloud Run Mapping

## Configuration Variables

- `DATABASE_URL`: set at runtime with `--set-env-vars DATABASE_URL=postgres://...` if the database URL is not sensitive in the current environment. If it contains credentials, store it in Secret Manager instead and inject it with `--set-secrets`.
- `LOG_LEVEL`: set with `--set-env-vars LOG_LEVEL=info`. This replaces the incorrect Dockerfile variable name `LOGLEVEL` and keeps the value outside the image.

## Secrets

- `API_KEY`: store in Secret Manager and inject with `--set-secrets API_KEY=api-key:latest`. Do not put the key in the Dockerfile, `.env.example`, or git.

## Example Cloud Run Commands

```bash
gcloud run deploy env-config-lab \
  --image REGION-docker.pkg.dev/PROJECT/REPOSITORY/envlab:TAG \
  --set-env-vars LOG_LEVEL=info \
  --set-secrets API_KEY=api-key:latest,DATABASE_URL=database-url:latest
```

Local equivalent:

```bash
docker run --env-file .env -e API_KEY="$API_KEY" --name app-fixed envlab
```
