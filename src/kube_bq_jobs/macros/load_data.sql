{% macro load_data_from_bucket(filename, table_name) %}
{% do log("Importing data from " ~ var("storage_uri") ~ filename) %}
{% set file_uri = var("storage_uri") ~ filename -%}

{%- set data_import -%}
    load data overwrite {{ target.dataset }}.{{ table_name }}__raw
    from
        files(
            format = 'JSON', uris = ["{{ file_uri }}"]
        )
    ;
{%- endset -%}

{%- do run_query(data_import) %}
{% endmacro %}
