

  create view "dev"."development"."wns_nm_DD_UCID_HHI_DEMO_TEMP2__dbt_tmp" as (
    CREATE TABLE  wns_nm_DD_UCID_HHI_DEMO_TEMP2 AS
	SELECT UCID,SUBSCRIBER_KEY,CARD_TYPE,EA_CODE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,
			DERIVED_RACE,BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
	FROM
		(SELECT UCID,SUBSCRIBER_KEY,CARD_TYPE,EA_CODE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,
				DERIVED_RACE,BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		FROM wns_nm_DD_UCID_HHI_DEMO_TEMP1_2
		WHERE UCID IN (
			SELECT UCID FROM (
				SELECT UCID, SUBSCRIBER_KEY, COUNT(*)AS CNT
				FROM wns_nm_DD_UCID_HHI_DEMO_TEMP1_2
				GROUP BY 1,2)
			WHERE CNT=1)
		ORDER BY UCID)
		UNION
		(SELECT UCID,SUBSCRIBER_KEY,CARD_TYPE,EA_CODE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,
				DERIVED_RACE,BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		FROM wns_nm_DD_UCID_HHI_DEMO_TEMP1_2
		WHERE UCID IN (
			SELECT UCID FROM (
				SELECT UCID, SUBSCRIBER_KEY, COUNT(*)AS CNT
				FROM wns_nm_DD_UCID_HHI_DEMO_TEMP1_2
				GROUP BY 1,2)
			WHERE CNT>1)
			AND CUSTOMER_NO IS NOT NULL
		GROUP BY UCID,SUBSCRIBER_KEY,CARD_TYPE,EA_CODE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,
				DERIVED_RACE,BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		ORDER BY UCID);
  ) ;
