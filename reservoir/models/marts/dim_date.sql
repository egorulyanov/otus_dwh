with stg_date as (
    select * from {{ ref('date') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_date.full_dte']) }} as date_key,
    *
from stg_date
