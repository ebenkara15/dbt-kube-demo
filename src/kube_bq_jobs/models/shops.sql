{{
    config(
        materialized = 'table',
        tags = ['raw']
    )
}}

{{ load_data_from_bucket("shops.ndjson", "shops") }}

SELECT * FROM `{{ target.dataset }}.shops__raw`
