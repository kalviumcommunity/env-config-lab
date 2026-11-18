# LU 4.7 — Fixing Environment Variables in Cloud Deployments

## Overview
This repository is an assessment for debugging and fixing environment variable configurations in a containerized Node.js application.

The original configuration prevented the application from starting correctly.
This repository now demonstrates supplying configuration at runtime.

## Local Docker Setup

1. Copy `.env.example` to `.env` and set `DATABASE_URL` for your environment.
   The example URL is only a placeholder; this demo checks that the variable is
   present but does not connect to a database.
2. Build the reusable Docker image:
   ```bash
   docker build -t envlab .
   ```

3. Run the app with local configuration:
   ```bash
   docker run --env-file .env --name app -p 3000:3000 envlab
   ```

4. Check `http://localhost:3000/health`. Remove the container when finished:
   ```bash
   docker rm -f app
   ```

`API_KEY` is optional in the current demo and is not used by a route. If a
future integration needs it, pass it at runtime (for example,
`docker run --env-file .env -e API_KEY="$API_KEY" -p 3000:3000 envlab`) or use a secret manager;
never add its value to the Dockerfile or a committed file. `.env` is ignored by
Git. `.env.example` contains placeholders only.

See [CLOUD_RUN.md](CLOUD_RUN.md) for the Cloud Run and Secret Manager mapping.

## Configuration

| Variable | Required | Purpose |
| --- | --- | --- |
| `DATABASE_URL` | Yes | Database URL presence is checked at startup. |
| `LOG_LEVEL` | No | Log level; defaults to `error`. |
| `API_KEY` | No | Reserved optional secret; currently not consumed by an app route. |
