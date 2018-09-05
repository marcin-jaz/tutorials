<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2007, 2013                                -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->
BEGIN_SYMBOL_DEFINITIONS

	<!-- DMACTIVITY table -->
	COLS:DMACTIVITY=DMACTIVITY:*
	
	<!-- DMELEMENT table -->
	COLS:DMELEMENT=DMELEMENT:*
	
	<!-- DMELEMENTNVP table -->
	COLS:DMELEMENTNVP=DMELEMENTNVP:*
	
	COLS:DMACTIVITY_NAME=DMACTIVITY:DMACTIVITY_ID, NAME, DMCAMPAIGN_ID, OPTCOUNTER			
	COLS:DMELEMENT_JOIN=DMELEMENT:DMELEMENT_ID, DMACTIVITY_ID, OPTCOUNTER
	COLS:DMELEMENTNVP_JOIN=DMELEMENTNVP:DMELEMENT_ID, OPTCOUNTER	
						
END_SYMBOL_DEFINITIONS

<!-- ======================================================================== -->
<!-- This SQL will return the data of the Activity noun                       -->
<!-- that has a name and corresponding values.                                -->
<!-- The access profiles that apply to this SQL are: IBM_Admin_Details        -->
<!-- @param Name The business object name.                                    -->
<!-- @param Value The business object values.                                  -->
<!-- ======================================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	<!-- fetch the activities associated with a name and multiple values -->
	name=/Activity[CampaignElement[Name= and (Value=)]]+IBM_Admin_Details
	base_table=DMACTIVITY
	sql=
		SELECT 
				DMACTIVITY.$COLS:DMACTIVITY$, DMELEMENT.$COLS:DMELEMENT$, DMELEMENTNVP.$COLS:DMELEMENTNVP$
		FROM
				DMACTIVITY, DMELEMENT, DMELEMENTNVP
		WHERE
		    DMACTIVITY.STOREENT_ID in ($STOREPATH:campaigns$) AND
				DMACTIVITY.DMACTIVITY_ID = DMELEMENT.DMACTIVITY_ID AND
				DMELEMENT.DMELEMENT_ID = DMELEMENTNVP.DMELEMENT_ID AND
				DMACTIVITY.DMTEMPLATETYPE_ID IS NULL AND
				DMELEMENTNVP.NAME = ?Name? AND
				DMELEMENTNVP.VALUE in (?Value?) AND
				(DMACTIVITY.UIDISPLAYABLE IS NULL OR DMACTIVITY.UIDISPLAYABLE = 1)
    ORDER BY DMACTIVITY.NAME				
  paging_count
  sql =
    SELECT  
        COUNT(*) as countrows    
		FROM
				DMACTIVITY, DMELEMENT, DMELEMENTNVP
		WHERE
		    DMACTIVITY.STOREENT_ID in ($STOREPATH:campaigns$) AND
				DMACTIVITY.DMACTIVITY_ID = DMELEMENT.DMACTIVITY_ID AND
				DMELEMENT.DMELEMENT_ID = DMELEMENTNVP.DMELEMENT_ID AND
				DMACTIVITY.DMTEMPLATETYPE_ID IS NULL AND
				DMELEMENTNVP.NAME = ?Name? AND
				DMELEMENTNVP.VALUE in (?Value?) AND
				(DMACTIVITY.UIDISPLAYABLE IS NULL OR DMACTIVITY.UIDISPLAYABLE = 1)

END_XPATH_TO_SQL_STATEMENT

<!-- ======================================================================== -->
<!-- This SQL will return the name of the Activity noun                       -->
<!-- that has a name value pair that matches the specified name and value.    -->
<!-- The access profiles that apply to this SQL are: IBM_Admin_ActivityName   -->
<!-- Note that this query returns activites from all stores.                  -->
<!-- If you only want activites from the current store, then use the          -->
<!-- IBM_Admin_ActivityName access profile.                                   -->
<!-- @param Name The business object name.                                    -->
<!-- @param Value The business object value.                                  -->
<!-- ======================================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	<!-- fetch the activities associated with a name value pair -->
	name=/Activity[CampaignElement[Name= and (Value=)]]+IBM_Admin_ActivityName
	base_table=DMACTIVITY
	sql=
		SELECT 
				DMACTIVITY.$COLS:DMACTIVITY_NAME$, DMELEMENT.$COLS:DMELEMENT_JOIN$, DMELEMENTNVP.$COLS:DMELEMENTNVP_JOIN$
		FROM
				DMACTIVITY, DMELEMENT, DMELEMENTNVP
		WHERE
				DMACTIVITY.DMACTIVITY_ID = DMELEMENT.DMACTIVITY_ID AND
				DMELEMENT.DMELEMENT_ID = DMELEMENTNVP.DMELEMENT_ID AND
				DMACTIVITY.DMTEMPLATETYPE_ID IS NULL AND
				DMELEMENTNVP.NAME = ?Name? AND
				DMELEMENTNVP.VALUE = ?Value? AND
				(DMACTIVITY.UIDISPLAYABLE IS NULL OR DMACTIVITY.UIDISPLAYABLE = 1)
    ORDER BY DMACTIVITY.NAME				
  paging_count
  sql =
    SELECT  
        COUNT(*) as countrows    
		FROM
				DMACTIVITY, DMELEMENT, DMELEMENTNVP
		WHERE
				DMACTIVITY.DMACTIVITY_ID = DMELEMENT.DMACTIVITY_ID AND
				DMELEMENT.DMELEMENT_ID = DMELEMENTNVP.DMELEMENT_ID AND
				DMACTIVITY.DMTEMPLATETYPE_ID IS NULL AND
				DMELEMENTNVP.NAME = ?Name? AND
				DMELEMENTNVP.VALUE = ?Value? AND
				(DMACTIVITY.UIDISPLAYABLE IS NULL OR DMACTIVITY.UIDISPLAYABLE = 1)

END_XPATH_TO_SQL_STATEMENT
