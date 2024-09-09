with stg_monthly_prod as (
SELECT UniqueId, 
	Date, 
	Oil, 
	Gas, 
	Water, 
	Liquid, 
	WellUptimeDays
    from {{ ref('MonthlyProd') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['Date']) }} as date_key,
    {{ dbt_utils.generate_surrogate_key(['UniqueId']) }} as well_reservoir_key,
	Date, 
	Oil, 
	Gas, 
	Water, 
	Liquid, 
	WellUptimeDays
from stg_monthly_prod

