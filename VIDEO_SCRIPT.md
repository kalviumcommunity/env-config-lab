# Video Walkthrough Script

Target length: 3–6 minutes. Record the terminal and repository side by side.
Use a real Docker installation for the demonstrations below. The environment
used to prepare this change did not have Docker installed, so no container logs
or recording were captured here; show the actual output rather than inventing
results.

## Speaking script

**Introduction**

"Hi, this is my walkthrough of the environment-configuration fix for the
Kalvium Docker deployment assignment. I’ll show why the original container
could not start, how the environment variables were corrected, and how the
same image can be configured securely on Cloud Run. The goal is to keep
environment-specific configuration outside the image and keep credentials out
of source control."

**Original failure and diagnosis**

"The application reads `DATABASE_URL` and `LOG_LEVEL` from the process
environment. At startup it exits if `DATABASE_URL` is missing. In the original
Dockerfile, no database URL was provided, and the log-level variable was
misspelled as `LOGLEVEL`. The Dockerfile also contained a hard-coded API-key
value. The application code shows that it reads the API key, although the
current demo does not use it in a route. I’ll run the original revision and
show its actual logs and variable names here. The expected startup error can
also be traced directly to the check in `app/server.js`; I’ll distinguish the
observed terminal output from what the source code predicts."

**Fixes**

"The fixed image no longer sets environment-specific values or secrets in the
Dockerfile. The local `.env` file supplies only local configuration and is
ignored by Git. `.env.example` has safe placeholders. `DATABASE_URL` is
required, `LOG_LEVEL` is optional, and a real API key must be supplied at
runtime only if a future integration needs it. The example database URL is a
local placeholder for this assignment; the server only checks that it is set
and does not open a database connection. For a real deployment, the database
URL should be treated as sensitive because it can contain credentials."

**Verification**

"I’ll build and run the fixed image with the local environment file, then check
the health endpoint and container logs. I’ll verify environment variable
names without printing values, and inspect image history for configuration
values. I’ll show the actual results on screen. The `/health` endpoint should
return a JSON status response once the server is listening. I’ll also check
that the application logs show the configured log level and successful server
startup, while avoiding commands that print secret values."

**Cloud Run and pull request**

"On Cloud Run, `LOG_LEVEL` can be set with `--set-env-vars`. `DATABASE_URL`
may contain credentials, so it belongs in Secret Manager and is mapped with
`--set-secrets`. The Cloud Run service account needs the Secret Manager
Secret Accessor role on the relevant secret. This assignment documents the
deployment only; it does not deploy to Google Cloud. Finally, I’ll show the
feature branch and pull request with the changes and test results. The fixed
Docker image stays identical across environments, and Cloud Run injects the
appropriate configuration when starting the service."

## Demonstration sequence

1. In a clean checkout of the base revision, run `docker build -t envlab-before .`
   and `docker run --name app-before envlab-before`, then show
   `docker logs app-before`. Redact any values if inspecting environment
   configuration; show variable names only.
2. Open `Dockerfile`, `app/config.js`, and `app/server.js` to connect the
   observed failure to the actual variable names and startup check.
3. In this fixed branch, copy `.env.example` to `.env` if needed, build with
   `docker build -t envlab .`, and run
   `docker run --env-file .env --name app-fixed -p 3000:3000 envlab`.
4. Show `docker logs app-fixed`, visit `http://localhost:3000/health`, and
   inspect environment variable names and `docker history envlab` without
   displaying secret values.
5. Show `CLOUD_RUN.md`, `git status`, and the pull request page. Do not claim a
   build, recording, or upload succeeded unless it actually did.
