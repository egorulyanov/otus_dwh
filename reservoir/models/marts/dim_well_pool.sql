with stg_reservoir as (
    select
        LITHOSTRATIGRAPHIC_UNIT_NAME,
        REGIONAL_STAGE,
	PRODUCTION_RESERVOIR
    from {{ ref('Reservoir') }}
),

stg_pool as (
    select
	Код,
        Reservoir_Name_Ru,
        OFM_UniqueID,
        Pool_Cadastr_num
    from {{ ref('WellPool') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_pool.Код']) }} as well_pool_key,
    LITHOSTRATIGRAPHIC_UNIT_NAME,    
    REGIONAL_STAGE,
    OFM_UniqueID,
    Reservoir_Name_Ru
from stg_reservoir 
join stg_pool on stg_reservoir.PRODUCTION_RESERVOIR = stg_pool.Reservoir_Name_Ru 
