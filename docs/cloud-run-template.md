# Cloud Run Mapping

Documentation only — nothing here gets deployed.

Configuration Variables

- `DATABASE_URL` -> `--set-env-vars DATABASE_URL=<value>`
- `LOG_LEVEL` -> `--set-env-vars LOG_LEVEL=<value>`

Combined example:
```
gcloud run deploy envlab \
  --image gcr.io/PROJECT/envlab \
  --set-env-vars DATABASE_URL=postgres://...,LOG_LEVEL=info
```

Secrets

- `API_KEY` -> stored in Secret Manager, mounted as an env var at deploy time, never in the image or a committed file.

Create the secret once:
```
gcloud secrets create API_KEY --data-file=./api_key.txt
```

Wire it to the service:
```
gcloud run deploy envlab \
  --image gcr.io/PROJECT/envlab \
  --set-secrets API_KEY=API_KEY:latest
```

If a key was ever hardcoded (as it was in this repo's Dockerfile), rotate it in the provider dashboard after removing it from source — the old value stays valid until rotated even after the code fix ships.
