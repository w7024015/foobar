CREATE TABLE wns_nm_DD_UCID_HHI_DEMO_TEMP1 AS (
	SELECT A.*,GENDER AS GENDER,BIRTH_DATE,DERIVED_RACE,AGE_DAYS,AGE_YEARS,LAST_UPDATED_DATE AS INFO_CHANGED_DATE, CURRENT_DATE AS CREATED_DATE
	FROM  {{ ref('wns_nm_DD_UCID_HHI_INFO') }} A
	LEFT JOIN (
		SELECT A.*,
				UPPER(DERIVED_RACE)  AS DERIVED_RACE,
				(CURRENT_DATE -A.BIRTH_DATE) AS AGE_DAYS,
				(CURRENT_DATE -A.BIRTH_DATE)/365 AS AGE_YEARS
		FROM ANALYTICS.FND_CUSTOMER_MASTER A
		LEFT JOIN DEVELOPMENT.FND_CUST_DERIVED_RACE_REF B
			ON UPPER(A.LAST_NAME)=UPPER(B.SURNAME)) B
		ON A.SUBSCRIBER_KEY=B.MASTER_SUBSCRIBER_KEY);