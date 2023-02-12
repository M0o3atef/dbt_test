{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'email',
        'last_name',
        'first_name',
        'full_name',
    ]) }} as _airbyte_customers_hashid,
    tmp.*
from {{ ref('customers_ab2') }} tmp
-- customers
where 1 = 1

