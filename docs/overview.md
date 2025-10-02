# Project Overview

## Goals
- Build a small data warehouse with raw → staging → mart schemas and automated ELT.  
- Implement quality checks and data contracts to prevent regressions.  
- Establish CI for tests, linting, and style to keep the repo healthy.  
- Document workflows and decisions so contributors can onboard quickly.  

## Architecture (high level)
- Ingestion: CSV → raw schema (append-only).  
- Transformation: SQL-based ELT to staging and marts.  
- Quality: Great Expectations validations in CI and pre-deploy.  
- Orchestration: Makefile targets locally; (future) simple scheduler.  

## Next Steps
- Advanced SQL practice to prepare for complex transformations.  
- Sketch out the dimensional model (facts/dimensions, SCD2 needs).  
- Implement SCD2 ELT patterns for at least one dimension.  
- Add Great Expectations for table/column expectations.  
- Run a basic performance benchmark and note bottlenecks.

## Definition of Done
- Reproducible environment via Docker/venv.  
- Tests passing in CI (smoke DB + basic expectations).  
- Docs updated (overview, runbook, decisions).  
