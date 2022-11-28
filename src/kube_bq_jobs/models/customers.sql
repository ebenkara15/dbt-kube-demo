{{
    config(
        materialized = 'table',
        tags = ['raw']
    )
}}

{{- load_data_from_bucket("customers.ndjson", "customers") -}}

SELECT * FROM `{{ target.dataset }}.customers__raw`
