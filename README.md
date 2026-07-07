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

2. Run the container:
   ```bash
   docker run --name app envlab
   ```

## Task

1. The application fails to start. Diagnose the issue using `docker logs app` and fix it.
2. Identify and resolve any configuration variable mismatches.
3. Find and remove any hardcoded secrets. Use proper runtime injection.
4. Ensure your local `.env` file (which you need to create) is not tracked by Git.
5. Fill out `docs/cloud-run-template.md` categorizing variables correctly.

Good luck!
