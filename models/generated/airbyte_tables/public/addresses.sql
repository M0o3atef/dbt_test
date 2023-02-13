with addresses_ab1 as (
    select
        {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
        {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
        {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
        {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
        {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as {{ adapter.quote('state') }},
        {{ json_extract_scalar('_airbyte_data', ['street'], ['street']) }} as street,
        {{ json_extract_scalar('_airbyte_data', ['customer_id'], ['customer_id']) }} as customer_id,
        _airbyte_ab_id,
        _airbyte_emitted_at,
        {{ current_timestamp() }} as _airbyte_normalized_at
    from {{ source('public', '_airbyte_raw_addresses') }}
),

addresses_ab2 as (
    select
        cast({{ adapter.quote('id') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('id') }},
        cast(zip as {{ dbt_utils.type_string() }}) as zip,
        cast(city as {{ dbt_utils.type_string() }}) as city,
        cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
        cast({{ adapter.quote('state') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('state') }},
        cast(street as {{ dbt_utils.type_string() }}) as street,
        cast(customer_id as {{ dbt_utils.type_bigint() }}) as customer_id,
        _airbyte_ab_id,
        _airbyte_emitted_at,
        {{ current_timestamp() }} as _airbyte_normalized_at
    from addresses_ab1
),

addresses_ab3 as (
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
        *
    from addresses_ab2
)

select
    {{ adapter.quote('id') }},
    zip,
    city,
    {{ adapter.quote('type') }},
    {{ adapter.quote('state') }},
    street,
    customer_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addresses_hashid
from addresses_ab3