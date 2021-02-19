-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail
select
    count(*) as total_amount
from {{ ref('wns_nm_dd_ucid_hhi_demo_temp3' )}}
having not(total_amount >= 1)
