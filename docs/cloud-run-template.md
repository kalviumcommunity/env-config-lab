# Cloud Run Mapping

## Configuration Variables (Non-Sensitive Config)

In Google Cloud Run, non-sensitive configuration values are supplied via the `--set-env-vars` deployment flag or specified within the Cloud Run service YAML under the `env` block.

- **`LOG_LEVEL`**
  - **Type**: Non-sensitive application configuration
  - **Cloud Run Flag**: `--set-env-vars LOG_LEVEL="info"`
  - **Purpose / Mapping**: Controls logging verbosity (`debug`, `info`, `warn`, `error`). Allows switching log levels in production or staging without rebuilding the container image.
  
- **`DATABASE_URL`** (When non-sensitive or pointing to an internal connection pooler / proxy / non-credentialed endpoint)
  - **Type**: Non-sensitive connection string / service endpoint
  - **Cloud Run Flag**: `--set-env-vars DATABASE_URL="mongodb+srv://cluster0.example.com/mydb"` (or Cloud SQL proxy socket)
  - **Purpose / Mapping**: Specifies the database target. Can be adapted per environment (dev, staging, prod) via deployment flags.

- **`PORT`**
  - **Type**: Container port configuration
  - **Cloud Run Flag**: `--port 3000` (or automatic Cloud Run `PORT=8080`)
  - **Purpose / Mapping**: Cloud Run injects `PORT=8080` by default into containers. The Node.js application dynamically binds to `process.env.PORT || 3000`.

---

## Secrets (Sensitive Data)

Sensitive values (such as API keys, passwords, database credentials, certificates) must never be baked into container images or committed to source control. In Google Cloud Run, secrets are securely managed using **Google Cloud Secret Manager** and injected into the container environment at runtime using the `--set-secrets` flag.

- **`API_KEY`**
  - **Type**: Secret / Authentication credential
  - **Cloud Run Flag**: `--set-secrets API_KEY=projects/PROJECT_ID/secrets/API_KEY:latest` (or `--set-secrets API_KEY=app-api-key:latest`)
  - **Purpose / Mapping**: Google Secret Manager stores the secret with encryption at rest, automatic IAM authorization, audit trails, and version rotation. At container startup, Cloud Run mounts the secret as the `API_KEY` environment variable directly in memory.

- **`DATABASE_URL`** (When containing database passwords / sensitive credentials)
  - **Type**: Secret connection string
  - **Cloud Run Flag**: `--set-secrets DATABASE_URL=projects/PROJECT_ID/secrets/DATABASE_URL:latest`
  - **Purpose / Mapping**: If the database connection string contains embedded database credentials (e.g. `postgres://user:password@host:5432/mydb`), it must be secured in Secret Manager rather than exposed via plaintext environment variables.

---

## Example Cloud Run Deployment

```bash
gcloud run deploy env-config-service \
  --image gcr.io/PROJECT_ID/envlab:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars LOG_LEVEL=info \
  --set-secrets API_KEY=app-api-key:latest,DATABASE_URL=database-url-secret:latest
```
