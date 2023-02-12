{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_on_hand_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'quantity',
        'product_id',
    ]) }} as _airbyte_products_on_hand_hashid,
    tmp.*
from {{ ref('products_on_hand_ab2') }} tmp
-- products_on_hand
where 1 = 1

