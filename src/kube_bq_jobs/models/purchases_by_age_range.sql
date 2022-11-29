{{ config(materialized="table", tags=["analyse"]) }}

  {%- set edges = [20, 40, 60, 80] -%}

with customers_age_range as (
  select *, (
    select case 
    {%- for edge in edges %}
      {%- if loop.first %}
      when (date_diff(current_date(), birthdate, year) < {{ edge }}) then '{{ edge }}-'
      {%- endif %}
      {%- if not loop.last %}
      when (date_diff(current_date(), birthdate, year) between {{ edge }} and {{ loop.nextitem }}) then '{{ edge }}-{{ loop.nextitem }}'
      {%- else  %}
      else '{{ edge }}+' end as age_range
      {%- endif %}  
    {%- endfor %} 
  ) as age_range
  from {{ ref("customers") }} as c
)

select sum(purchases) as purchases_sum, age_range
from customers_age_range
group by age_range
order by age_range
