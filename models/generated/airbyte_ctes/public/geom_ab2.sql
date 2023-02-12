{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('geom_ab1') }}
select
    cast(decode({{ adapter.quote('g') }}, 'base64') as {{ type_binary() }}) as {{ adapter.quote('g') }},
    cast(decode(h, 'base64') as {{ type_binary() }}) as h,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('id') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('geom_ab1') }}
-- geom
where 1 = 1

