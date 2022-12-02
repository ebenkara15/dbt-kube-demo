# Helm Chart <img src="https://helm.sh/img/helm.svg" alt="Helm icon" width="50"/>

Here is the Helm chart we use to install all of our Kubernetes. Just dive into the [`dbt-bigquery`](./dbt-bigquery/) folder to discover.
Read more about Helm [here](https://helm.sh/docs/).

## :small_blue_diamond: Docker

Before all, you need to build the DBT image that we'll be run into the cluster. You can the Dockerfile at the root of this repository. The Dockerfile is pretty simple: it just fetches the official DBT image and copy your project into it.

You need first to properly setup `gcloud` to authenticate it for pulling/pushing into the Artifact Registry:
```bash
gcloud auth configure-docker 
```

Then build, tag and push to the Artifact Registry:
```bash
docker build -t europe-west1-docker.pkg.dev/<project-id>/demo-repo/dbt-kube-demo:latest .
docker push europe-west1-docker.pkg.dev/<project-id>/demo-repo/dbt-kube-demo:latest 
```

## :round_pushpin: Set Your Values

You may be interested in modifying the `values.yaml` file to better fit your project setup especially if you modify the name of some resources when deploying your infrastructure with Terraform: adapt the project ID. 

:warning: The ConfigMap is used to store the `profiles.yml` file that DBT uses. Review it before installing and change the name of the project if needed.

## :clapper: Installation

Go to the [`dbt-bigquery`](./dbt-bigquery/) folder and run:
```bash
helm upgrade --install --atomic dbt -f values.yaml -n dbt . --create-namespace
```
