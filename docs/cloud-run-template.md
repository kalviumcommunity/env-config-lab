# Cloud Run Mapping

Configuration variables

- `DATABASE_URL`: inject as non-secret runtime configuration with
  `gcloud run deploy envlab --set-env-vars DATABASE_URL="postgres://db-host:5432/app"`.
- `LOG_LEVEL`: inject as non-secret runtime configuration with
  `gcloud run deploy envlab --set-env-vars LOG_LEVEL="info"`.

Secrets

- `API_KEY`: store the value in Secret Manager and inject it at runtime with
  `gcloud run deploy envlab --set-secrets API_KEY=envlab-api-key:latest`.
- Do not put `API_KEY` in the Dockerfile, `.env.example`, or a committed file.
  Rotate the previously exposed value before using this deployment.
