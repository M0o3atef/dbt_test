{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_on_hand_ab1') }}
select
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    cast(product_id as {{ dbt_utils.type_bigint() }}) as product_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_on_hand_ab1') }}
-- products_on_hand
where 1 = 1

