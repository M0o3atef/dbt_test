{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'quantity',
        'purchaser',
        'order_date',
        'product_id',
        'order_number',
    ]) }} as _airbyte_orders_hashid,
    tmp.*
from {{ ref('orders_ab2') }} tmp
-- orders
where 1 = 1

