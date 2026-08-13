# Cloud Run Mapping

## How to deploy this application to Cloud Run

### Configuration Variables (non-sensitive)

Use `--set-env-vars` flag to inject configuration at deployment time:

```bash
gcloud run deploy env-config-lab \
  --set-env-vars DATABASE_URL="postgresql://user:password@host:5432/db" \
  --set-env-vars LOG_LEVEL="info"
```

**Variables:**
- `DATABASE_URL` - Database connection string (required)
- `LOG_LEVEL` - Application log level (optional, defaults to 'error')

### Secrets (sensitive data)

Use Google Secret Manager with `--set-secrets` for API keys and sensitive values:

```bash
# Create secrets in Secret Manager
gcloud secrets create api-key --replication-policy="automatic"
echo -n "your-actual-api-key" | gcloud secrets versions add api-key --data-file=-

# Deploy with secret injection
gcloud run deploy env-config-lab \
  --set-secrets API_KEY=api-key:latest
```

**Secrets:**
- `API_KEY` - API authentication key (injected from Secret Manager, never hardcoded)

## Why this matters

1. **Configuration** (DATABASE_URL, LOG_LEVEL) → Environment variables at deploy time
2. **Secrets** (API_KEY) → Secret Manager → Injected at runtime
3. **Never** hardcode secrets in Dockerfile or commit to git
4. **.env file** → Used locally only, added to .gitignore, never committed
