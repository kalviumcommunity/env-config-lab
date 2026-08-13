# Cloud Run Environment Variable Mapping

## Non‑secret config (`--set-env-vars`)
| Variable | Value | Cloud Run Flag |
|----------|-------|----------------|
| DATABASE_URL | postgres://user:pass@localhost:5432/mydb | `--set-env-vars=DATABASE_URL=postgres://user:pass@localhost:5432/mydb` |
| LOG_LEVEL | info | `--set-env-vars=LOG_LEVEL=info` |

## Secrets (`--set-secrets`)
| Variable | Secret Manager Reference | Cloud Run Flag |
|----------|--------------------------|----------------|
| API_KEY | projects/PROJECT_ID/secrets/API_KEY/versions/latest | `--set-secrets=API_KEY=API_KEY:latest` |

> **Important:** Never hardcode secrets in the Dockerfile or commit them to version control.  
> Use Secret Manager for all sensitive values in production.