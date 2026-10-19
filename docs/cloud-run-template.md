# Cloud Run Mapping

## Non-secret configuration

- `LOG_LEVEL`: provide with `--set-env-vars LOG_LEVEL=info`.

For example:

```sh
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --set-env-vars LOG_LEVEL=info
```

## Secrets and credential-bearing values

- `API_KEY`: store the value in Secret Manager and map it with `--set-secrets`.
- `DATABASE_URL`: use Secret Manager if it contains a username, password, or
  other credentials. The credential-free local example can be supplied through
  `.env`; never put a real credential-bearing URL in a committed file or image.

For example:

```sh
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --set-secrets API_KEY=api-key:latest,DATABASE_URL=database-url:latest
```

Replace the example names with Secret Manager secrets containing the API key
and database URL. Rotate any value that was previously baked into an image.
