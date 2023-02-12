{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_ab1') }}
select
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    cast(purchaser as {{ dbt_utils.type_bigint() }}) as purchaser,
    cast({{ empty_string_to_null('order_date') }} as {{ type_date() }}) as order_date,
    cast(product_id as {{ dbt_utils.type_bigint() }}) as product_id,
    cast(order_number as {{ dbt_utils.type_bigint() }}) as order_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_ab1') }}
-- orders
where 1 = 1

