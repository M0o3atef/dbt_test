{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('id') }},
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(concat(first_name, ' ', last_name) as {{ dbt_utils.type_string() }}) as full_name
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at 
from {{ ref('customers_ab1') }}
-- customers
where 1 = 1

