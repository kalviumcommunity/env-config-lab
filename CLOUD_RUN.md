# Cloud Run Environment Configuration Mapping

This document details how environment configurations and secrets for `env-config-lab` map to Google Cloud Run runtime deployment parameters.

## Architectural Separation

| Variable | Classification | Storage / Injection Method | Google Cloud Run Flag |
| :--- | :--- | :--- | :--- |
| `LOG_LEVEL` | Non-sensitive Config | Environment Variable / `.env` | `--set-env-vars LOG_LEVEL=info` |
| `DATABASE_URL` (standard) | Non-sensitive Config | Environment Variable / `.env` | `--set-env-vars DATABASE_URL=mongodb+srv://...` |
| `DATABASE_URL` (with password) | Secret | Secret Manager | `--set-secrets DATABASE_URL=db-secret:latest` |
| `API_KEY` | Secret | Secret Manager | `--set-secrets API_KEY=app-api-key:latest` |
| `PORT` | Infrastructure Config | Cloud Run Managed Port | `--port 3000` (defaults to 8080 in Cloud Run) |

---

## 1. Non-Sensitive Configuration (`--set-env-vars`)

Non-sensitive configuration parameters govern application behavior without exposing confidential information. In Cloud Run, these are set using `--set-env-vars`:

```bash
--set-env-vars LOG_LEVEL=info,DATABASE_URL="mongodb+srv://cluster0.example.com/mydb"
```

- **`LOG_LEVEL`**: Controls logging verbosity (`debug`, `info`, `warn`, `error`). Can be updated between deployments without rebuilding container layers.
- **`DATABASE_URL`**: Used when pointing to an internal microservice, Cloud SQL Proxy socket, or connection URI without plaintext credentials.
- **`PORT`**: Google Cloud Run automatically routes incoming traffic to the container port defined by `PORT` (defaults to 8080). The application reads `process.env.PORT || 3000`.

---

## 2. Secrets Management (`--set-secrets`)

Sensitive credentials like authentication keys and passwords must never be stored in Dockerfiles, Git repositories, or plain environment variables. In Google Cloud Run, secrets are stored in **Google Cloud Secret Manager** and injected into the container securely at runtime using `--set-secrets`:

```bash
--set-secrets API_KEY=app-api-key:latest
```

- **`API_KEY`**: Sourced directly from Secret Manager (`projects/PROJECT_ID/secrets/app-api-key:latest`). It is injected into memory at container startup, enabling strict IAM permissions, audit logging, and automated credential rotation without rebuilding images.
- **`DATABASE_URL`** (with credentials): When connection strings contain usernames and passwords (e.g., `postgres://admin:secretpass@host:5432/production`), store the entire URI in Secret Manager and mount it as an environment variable via `--set-secrets`.

---

## 3. Full Deployment Command

```bash
gcloud run deploy env-config-service \
  --image gcr.io/PROJECT_ID/envlab:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars LOG_LEVEL=info \
  --set-secrets API_KEY=app-api-key:latest,DATABASE_URL=database-url-secret:latest
```
