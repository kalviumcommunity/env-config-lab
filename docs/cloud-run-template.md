# Cloud Run Mapping

## Configuration Variables

- `DATABASE_URL` — non-secret configuration. Locally supplied through `.env` using Docker `--env-file`. In Cloud Run, use `--set-env-vars`.
- `LOG_LEVEL` — non-secret configuration. Locally supplied through `.env` using Docker `--env-file`. In Cloud Run, use `--set-env-vars`.

Example:

```bash
gcloud run deploy envlab \
  --set-env-vars="DATABASE_URL=<database-url>,LOG_LEVEL=info"