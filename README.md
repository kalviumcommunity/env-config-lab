# LU 4.7 — Fixing Environment Variables in Cloud Deployments

## Overview
This repository is an assessment for debugging and fixing environment variable configurations in a containerized Node.js application.

The application currently fails to start correctly because one or more configuration issues exist. 
Use logs and environment inspection to diagnose the problem.

## Setup Instructions

1. Build the Docker image:
   ```bash
   docker build -t envlab .
   ```

2. Create a local configuration file and edit it with the non-secret values for
   your environment:
   ```bash
   cp .env.example .env
   ```
   `.env` is ignored by Git. Do not put a real API key in it: supply the key at
   runtime instead.

3. Run the container, injecting `API_KEY` from your shell environment:
   ```bash
   docker run --env-file .env -e API_KEY="$API_KEY" --name app envlab
   ```

4. Inspect startup and the runtime environment:
   ```bash
   docker logs app
   docker exec app printenv
   ```

## Task

`DATABASE_URL` and `LOG_LEVEL` are non-secret configuration, passed via `.env`.
`API_KEY` is a secret and must be injected at runtime. See
[`docs/cloud-run-template.md`](docs/cloud-run-template.md) for the Cloud Run
equivalent using `--set-env-vars` and Secret Manager `--set-secrets`.

Good luck!
