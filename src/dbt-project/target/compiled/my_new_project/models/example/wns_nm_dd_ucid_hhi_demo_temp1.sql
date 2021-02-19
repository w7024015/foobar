SELECT A.*,GENDER AS GENDER,BIRTH_DATE,DERIVED_RACE,AGE_DAYS,AGE_YEARS,LAST_UPDATED_DATE AS INFO_CHANGED_DATE, CURRENT_DATE AS CREATED_DATE
	FROM  "dev"."development"."wns_nm_dd_ucid_hhi_info" A
	LEFT JOIN (
		SELECT A.*,
				UPPER(DERIVED_RACE)  AS DERIVED_RACE,
				(CURRENT_DATE -A.BIRTH_DATE) AS AGE_DAYS,
				(CURRENT_DATE -A.BIRTH_DATE)/365 AS AGE_YEARS
		FROM ANALYTICS.FND_CUSTOMER_MASTER A
		LEFT JOIN DEVELOPMENT.FND_CUST_DERIVED_RACE_REF B
			ON UPPER(A.LAST_NAME)=UPPER(B.SURNAME)) B
		ON A.SUBSCRIBER_KEY=B.MASTER_SUBSCRIBER_KEY