# Cloud Run Mapping

See the repository's [CLOUD_RUN.md](../CLOUD_RUN.md) for deployment commands,
Secret Manager setup, and service-account permissions.

| Variable | Cloud Run configuration |
| --- | --- |
| `LOG_LEVEL` | Non-secret: `--set-env-vars="LOG_LEVEL=info"` |
| `DATABASE_URL` | Secret: map from Secret Manager as `DATABASE_URL=database-url:latest`; database URLs may contain credentials. |
| `API_KEY` | Optional secret if a future integration uses it: `API_KEY=api-key:latest`. |
