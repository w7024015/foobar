CREATE TABLE wns_nm_DD_UCID_HHI_DEMO_TEMP1_2 AS (
	SELECT A.UCID, A.SUBSCRIBER_KEY , A.CUSTOMER_NO,A.CARD_TYPE,A.EA_CODE,A.INCOME_CLASS,A.HOUSEHOLD_INCOME_SUBRANGE,A.DERIVED_RACE,
			CASE WHEN B.AGE IS NULL THEN A.AGE_DAYS ELSE B.AGE END AS AGE_DAYS,
			CASE WHEN B.AGE_YEARS IS NULL THEN A.AGE_YEARS ELSE B.AGE_YEARS END AS AGE_YEARS,
			CASE WHEN B.GENDER IS NULL THEN A.GENDER ELSE B.GENDER END AS GENDER,
			CASE WHEN B.DOB IS NULL THEN A.BIRTH_DATE ELSE B.DOB END AS BIRTH_DATE,
			INFO_CHANGED_DATE,
			CREATED_DATE
	FROM wns_nm_DD_UCID_HHI_DEMO_TEMP1 A
	LEFT JOIN #wns_nm_DD_DEMOGOG_STAGING B
		ON A.SUBSCRIBER_KEY=B.SUBSCRIBER_KEY
			AND A.CUSTOMER_NO=B.CUSTOMER_NO);