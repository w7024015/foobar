SELECT UCID,CARD_TYPE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,DERIVED_RACE,
			BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
	FROM
		(SELECT UCID,CARD_TYPE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,DERIVED_RACE,    
				BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		FROM {{ ref('wns_nm_DD_UCID_HHI_DEMO_TEMP2') }} 
		WHERE UCID IN (
			SELECT UCID FROM (
				SELECT UCID, COUNT(*)AS CNT
				FROM {{ ref('wns_nm_DD_UCID_HHI_DEMO_TEMP2') }} 
				GROUP BY 1)
			WHERE CNT=1)
		ORDER BY UCID)
		UNION
		(SELECT UCID,CARD_TYPE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,DERIVED_RACE,
				BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		FROM {{ ref('wns_nm_DD_UCID_HHI_DEMO_TEMP2') }} 
		WHERE UCID IN (
			SELECT UCID FROM (
				SELECT UCID, COUNT(*)AS CNT
				FROM {{ ref('wns_nm_DD_UCID_HHI_DEMO_TEMP2') }} 
				GROUP BY 1)
			WHERE CNT>1)
		AND SUBSCRIBER_KEY IS NOT NULL
		GROUP BY UCID,CARD_TYPE,INCOME_CLASS,HOUSEHOLD_INCOME_SUBRANGE,DERIVED_RACE,
				BIRTH_DATE,AGE_DAYS,AGE_YEARS,GENDER,INFO_CHANGED_DATE,CREATED_DATE
		ORDER BY UCID)