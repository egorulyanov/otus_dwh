with stg_well as (
    select
        WELL_NAME, 
        ACTIVE_WELLBORE_NUMBER, 
        WELL_CLASS, 
        SPUD_DATE
    from {{ ref('Well') }}
),

stg_well_reservoir as (
    select
	OFM_UniqueID,
        Reservoir_Name_Ru,
        Conduit
    from {{ ref('WellPool') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_well_reservoir.OFM_UniqueID']) }} as well_reservoir_key,
	WELL_NAME, 
	ACTIVE_WELLBORE_NUMBER, 
	WELL_CLASS, 
	SPUD_DATE, 
	OFM_UniqueID, 
	Reservoir_Name_Ru
from stg_well
join stg_well_reservoir on stg_well_reservoir.Conduit = stg_well.WELL_NAME
