{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('addresses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'zip',
        'city',
        adapter.quote('type'),
        adapter.quote('state'),
        'street',
        'customer_id',
    ]) }} as _airbyte_addresses_hashid,
    tmp.*
from {{ ref('addresses_ab2') }} tmp
-- addresses
where 1 = 1

