# Cloud Run Mapping

Configuration Variables

- DATABASE_URL: Configured via --set-env-vars DATABASE_URL="..."
- LOG_LEVEL: Configured via --set-env-vars LOG_LEVEL="info"

Secrets

- API_KEY: Injected securely via --set-secrets API_KEY=APP_API_KEY:latest (Secret Manager)
