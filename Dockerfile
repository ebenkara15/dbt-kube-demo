FROM  ghcr.io/dbt-labs/dbt-bigquery:latest

WORKDIR /usr/app

COPY src/kube_bq_jobs .
