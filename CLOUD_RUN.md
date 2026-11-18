# Deploying to Google Cloud Run

The Docker image contains the application only. Supply configuration when the
Cloud Run service is deployed so the same image can be used in each environment.
Cloud Run provides `PORT` to the container automatically.

## Non-secret configuration

`LOG_LEVEL` is non-secret and can be set on the service:

```sh
gcloud run deploy SERVICE_NAME \
  --image IMAGE_URL \
  --region REGION \
  --set-env-vars "LOG_LEVEL=info" \
  --set-secrets "DATABASE_URL=database-url:latest"
```

`DATABASE_URL` is required by this application. Since a database URL commonly
contains a username and password, store it as a secret rather than passing it
with `--set-env-vars`. `API_KEY` is optional in the current demo and is not used
by an application route; if a future integration needs it, add
`--set-secrets "DATABASE_URL=database-url:latest,API_KEY=api-key:latest"`.

## Create secrets and grant access

Create the required database secret in the project that hosts the Cloud Run
service. Create the API-key secret only if an integration needs it:

```sh
gcloud secrets create database-url --replication-policy=automatic
```

Add secret versions from a secure shell without putting secret values in source
control or echoing them into terminal output. For example, with the values
already available as protected shell variables:

```sh
printf '%s' "$DATABASE_URL" | gcloud secrets versions add database-url --data-file=-
```

For an integration that uses `API_KEY`, also create and populate an `api-key`
secret using the same commands with `api-key` as the secret name.

Use the service account configured as the Cloud Run service identity. Grant that
identity access only to the secrets the service needs:

```sh
gcloud secrets add-iam-policy-binding database-url \
  --member="serviceAccount:SERVICE_ACCOUNT_EMAIL" \
  --role="roles/secretmanager.secretAccessor"
```

Then deploy with `--set-secrets`, as shown above. Cloud Run resolves the
references at runtime; secret values do not become part of the image. Omit the
API key mapping and its IAM binding unless the application starts using it.
If the API key is needed, create it, add a version, and grant the same
Secret Accessor permission to the service account for that secret.

Never put credentials in a Dockerfile, image layer, committed `.env` file, or
documentation. If a real credential was ever committed or baked into an image,
rotate it and review access to the affected service; deleting the value from
the current source does not revoke it.
