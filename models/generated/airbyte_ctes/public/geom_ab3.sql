{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('geom_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('g'),
        'h',
        adapter.quote('id'),
    ]) }} as _airbyte_geom_hashid,
    tmp.*
from {{ ref('geom_ab2') }} tmp
-- geom
where 1 = 1

