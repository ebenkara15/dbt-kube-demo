# dbt-kube-demo
A demo of how to use K8s CronJobs to automate DBT pipelines.

You'll find here all you need to run a simple DBT project over Kubernetes with BiGQuery as a SQL backend.

## Prerequisites

We use several tools in order to run this project.

:heavy_exclamation_mark: Mandatory tools
- `python` and `poetry` in order to generate and upload some fake data and run DBT locally if you want.
- `gcloud` CLI to interact with GCP. Installation guide [here](https://cloud.google.com/sdk/docs/install)
- `kubectl` to interact with you Kubernetes cluster. Installation with `gcloud` [here](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl)
- `helm` to install and manages Kubernetes resources. Installation guide [here](https://helm.sh/docs/intro/install/)
- `terraform` to deploy and manage the infrastructure. Installation guide [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- `docker` to build and push the DBT image to GCP Artifact Registry. Installation guide [here](https://docs.docker.com/get-docker/)

:information_source: Optional tools
- `k9s`, a TUI to visualize, explore and interact with the cluster
- `kubens` to set a default namespace when running `kubectl` commands
- `kubectx` to handle multiple context with kubectl

## Installation steps

### GCP Project

The very first step is to setup a new GCP project. Once this is done, you can start deploying your infrastructure.

### Infrastructure

We use Terraform to deploy and manage the infrastructure: all can be done without clicking on the GCP Console.

Follow the [README](./terraform/) in the `terraform` folder.

### Export some fake data

There are 2 scripts in `data` folder that generates and upload to GCS some fake data you can use. You can have a look at the data it generates by inspect the 2 `.ndjson` files.

Make sure you have installed the project with `poerty install` and just run:
```bash
poetry run pyhton data/data_faker.py
poetry run python data/storage_load.py
```

### Local run of DBT (optional)
You can run DBT locally if you want to check that DBT can correctly run your SQL queries on BigQuery.

You'll need to define your `profile.yml` in order to make DBT able to connect and query BigQuery. The default profile name is `kube_bq_jobs`. You can find an example in the ConfigMap [here](./kubernetes/helm/dbt-bigquery/templates/configmap.yaml).

### Deploy your CronJob to Kubernetes
