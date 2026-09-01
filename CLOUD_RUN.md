# GCP Cloud Run Environment & Secret Mapping

When deploying this application to Google Cloud Run, non-secret configuration variables and sensitive secrets must be handled separately using Cloud Run flags.

## 1. Configuration Variables (`--set-env-vars`)
Non-secret application configurations are managed using environment variables passed directly to the container at deployment time via the `--set-env-vars` flag:

- **`DATABASE_URL`**: `DATABASE_URL="postgres://user:pass@db.example.com:5432/mydb"`
- **`LOG_LEVEL`**: `LOG_LEVEL="info"`

Example `gcloud` deployment flag:
```bash
gcloud run deploy envlab-service \
  --image gcr.io/$PROJECT_ID/envlab \
  --set-env-vars DATABASE_URL="postgres://user:pass@db.example.com:5432/mydb",LOG_LEVEL="info"
```

## 2. Secrets (`--set-secrets`)
Sensitive credentials such as API keys, passwords, and tokens must **never** be baked into Dockerfiles or stored in committed files. Store secrets securely in **Google Secret Manager** and inject them into container environment variables at runtime via `--set-secrets`:

- **`API_KEY`**: Sourced from Secret Manager secret `APP_API_KEY:latest`

Example `gcloud` deployment flag:
```bash
gcloud run deploy envlab-service \
  --image gcr.io/$PROJECT_ID/envlab \
  --set-env-vars DATABASE_URL="postgres://user:pass@db.example.com:5432/mydb",LOG_LEVEL="info" \
  --set-secrets API_KEY=APP_API_KEY:latest
```
