

  create view "dev"."development"."wns_nm_dd_tt_ucid_reftable__dbt_tmp" as (
    SELECT perm_ucid_hashed as ucid, SUBSCRIBER_KEY,CUSTOMER_NO,'CARDS' AS CARD_TYPE
	FROM DEVELOPMENT.DIM_CUSTOMER_CARD_MAPPING
	GROUP BY 1,2,3,4
  ) ;
