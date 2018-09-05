<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2013, 2014                                -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->

<!-- ========================================================================= -->
<!--  Retrieve store tables                                                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_STORETYPE
	base_table=STORE
	sql=
	SELECT
   		STORETYPE
	FROM
	    STORE,
	    STOREENT
	WHERE
    	STORE.STORE_ID=STOREENT.STOREENT_ID
		AND STOREENT.MARKFORDELETE <> 1
		AND STORE.STORE_ID IN (?storeId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find all related stores which are currently open                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_OPEN_RELATED_STORES
	base_table=ATTRDESC
	sql=
	    SELECT STOREENT_ID, DISPLAYNAME
	      FROM STOREENTDS
	     WHERE STOREENT_ID IN (SELECT STORE_ID FROM STORE WHERE STATUS = 1)
	       AND STOREENT_ID IN (
	           SELECT STOREREL.RELATEDSTORE_ID
	             FROM STOREREL, STRELTYP
	            WHERE STOREREL.STORE_ID = ?storeId?
	              AND STOREREL.STATE = 1
	              AND STRELTYP.NAME = ?relationshipType?
	              AND STRELTYP.STRELTYP_ID = STOREREL.STRELTYP_ID
	           )
	     ORDER BY STOREENTDS.STOREENT_ID
END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  Populate expression for catfilter                                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_POPULATE_EXPRESSION
	base_table=EXPRESSION
	sql=
insert into EXPRESSION (EXPRESSION_ID, CATFILTER_ID, QUERY) VALUES (?expression_id?, ?catfilter_id?, ?query?)
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!--  Populate expression for catfilter with trading ID and member ID          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_POPULATE_EXPRESSION_WITH_TRADINGID_AND_MEMBERID
	base_table=EXPRESSION
	sql=
insert into EXPRESSION (EXPRESSION_ID, TRADING_ID, CATFILTER_ID, MEMBER_ID, QUERY) VALUES (?expression_id?, ?trading_id?, ?catfilter_id?, ?member_id?, ?query?)
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- Query TC ID and catfilter ID by trading ID and TC sub type                -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_QUERY_TC_BY_TRADINGID_AND_SUBTYPE
	base_table=TERMCOND
	sql=
SELECT TERMCOND_ID, BIGINTFIELD1 FROM TERMCOND WHERE TRADING_ID = ?trading_id? AND TCSUBTYPE_ID = ?tc_sub_type?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- Query TC ID and member ID by trading ID and TC sub type                   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_QUERY_PARTICIPNT_MEMBERID_BY_TERMCOND
	base_table=PARTICIPNT
	sql=
SELECT MEMBER_ID FROM PARTICIPNT WHERE TERMCOND_ID = ?termcond_id?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- Load all valid trading IDs                                                -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_LOAD_ALL_VALID_TRADING
	base_table=TRADING 
	dbtype=any
	sql=
SELECT TRADING_ID FROM TRADING WHERE (STARTTIME < ?current_time? OR STARTTIME IS NULL) AND (ENDTIME > ?current_time? OR ENDTIME IS NULL)
END_SQL_STATEMENT	
<!-- ========================================================================= -->
<!-- Query all expressions                                                     -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_QUERY_ALL_EXPRESSION
	base_table=EXPRESSION
	sql=
SELECT QUERY FROM  EXPRESSION
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- Query expression for catfilter 										   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_QUERY_EXPRESSION
	base_table=EXPRESSION
	sql=
SELECT QUERY FROM  EXPRESSION WHERE CATFILTER_ID = ?catfilter_id?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Update expression to catfilter 										   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_UPDATE_QUERY_TO_EXPRESSION
	base_table=EXPRESSION
	sql=
UPDATE  EXPRESSION SET QUERY=?query? WHERE CATFILTER_ID = ?catfilter_id?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Update contract_id to catfilter 										   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_UPDATE_CONTRACT_TO_EXPRESSION
	base_table=EXPRESSION
	sql=
UPDATE  EXPRESSION SET TRADING=?trading_id? WHERE CATFILTER_ID = ?catfilter_id?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Get parent categories for a category 									   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_SELECT_PARENT_CATGROUP
	base_table=CATGRPREL
	sql=
	SELECT CATGROUP_ID_PARENT FROM CATGRPREL, STORECAT 
	WHERE CATGROUP_ID_CHILD= ?catalogGroupId? AND CATGRPREL.CATALOG_ID=STORECAT.CATALOG_ID AND STORECAT.MASTERCATALOG='1'
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get flex flow by storeid and feature                                  -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=LOAD_FLEX_FLOW_BY_STOREID_AND_FEATURENAME
    base_table=DMEMSPOTDEF
	sql=
    select content from DMEMSPOTDEF 
    WHERE EMSPOT_ID IN (SELECT EMSPOT_ID FROM EMSPOT WHERE NAME = ?name? AND USAGETYPE='STOREFEATURE') 
    AND STOREENT_ID IN (?storeId?)
    AND CONTENTTYPE='FeatureEnabled'
END_SQL_STATEMENT

<!-- =========================================================================================================== -->
<!-- This SQL will return the store configuration based on the store ID and configuration name specified.       -->
<!-- @param STOREENT_ID The store IDs for which the parameter is to be retrieved							-->
<!-- @param NAME The name of the parameter to be retrieved.						-->
<!-- =========================================================================================================== -->
BEGIN_SQL_STATEMENT
	base_table=STORECONF
	name=IBM_LOAD_STORECONF_BY_NAME
	sql=
		SELECT 
			VALUE, STOREENT_ID
		FROM
			STORECONF
		WHERE
			STORECONF.STOREENT_ID IN (?storeId?) AND NAME = ?name? 
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Loading entitled contract for buyer                                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Load trading
	name=IBM_LOAD_TRADING
	base_table=TRADING 
	dbtype=any
	sql=
	SELECT T.trading_id, T.account_id, T.starttime, T.endtime FROM PARTICIPNT P, TRADING T, STORECNTR S WHERE T.trading_id = P.trading_id and T.trading_id = S.contract_id 
		and S.store_id =?store_id?  and P.partrole_id = 2 and P.termcond_id is null and (P.member_id = ?member_id? or P.member_id = ?org_id? or P.member_id is null) and T.state = 1 
		and T.markfordelete = 0 
	UNION  
	SELECT T.trading_id, T.account_id, T.starttime,  T.endtime FROM PARTICIPNT P, TRADING T, STORECNTR S, mbrrel M WHERE T.trading_id = P.trading_id 
		and T.trading_id = S.contract_id and S.store_id = ?store_id? and P.partrole_id = 2 and P.termcond_id is null and P.member_id = M.ancestor_id 
		and M.descendant_id = ?org_id? and T.state = 1 and T.markfordelete = 0 
 UNION 
 SELECT T.trading_id, T.account_id,  T.starttime, T.endtime FROM PARTICIPNT P, TRADING T, STORECNTR S, mbrgrpmbr M WHERE T.trading_id = P.trading_id 
 		and T.trading_id = S.contract_id and S.store_id = ?store_id? and P.partrole_id = 2 and P.termcond_id is null and P.member_id = M.mbrgrp_id 
 		and M.member_id = ?member_id? and M.exclude='0' and T.state = 1 and T.markfordelete = 0 
 order by trading_id
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find the default contract setting for an account                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Fetch default contract from account -->
	name=IBM_LOAD_DEFAULTCONTRACT_FROM_ACCOUNT
	base_table=ACCOUNT 
	dbtype=any
	sql=
	SELECT DEFAULTCONTRACT FROM ACCOUNT where ACCOUNT_ID in (?account_id?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find base contract for a reference contract                              -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Fetch base contract -->
	name=IBM_LOAD_BASE_CONTRACT
	base_table=store 
	dbtype=any
	sql=
	select A.contract_id, b.starttime,b.endtime FROM contract A, trading B  where  A.contract_id=B.trading_id and A.family_id in (select REFTRADING_ID from trading where trading_id =?tradingId?) and a.state = 3 and a.markfordelete = 0
	
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find active organization for a member                                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Fetch active organization  -->
	name=IBM_LOAD_ACTIVE_ORGANIATION
	base_table=mbrrel 
	dbtype=any
	sql=
	SELECT ANCESTOR_ID FROM MBRREL   WHERE (DESCENDANT_ID = ?member_id?) AND SEQUENCE = 1
	
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- To determine whether one member belongs to a membergroup, this will be used to determine
     whether the current caller apply to the precompiled expression            -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_IS_MEMBER_OF
	base_table=mbrgrpmbr 
	sql=
	select DESCENDANT_ID from MBRREL M WHERE M.ANCESTOR_ID = ?mbrgrp_id? AND M.DESCENDANT_ID = ?org_id?
	UNION
	SELECT MEMBER_ID FROM MBRGRPMBR M WHERE M.MBRGRP_ID = ?mbrgrp_id? AND M.MEMBER_ID = ?user_id? and exclude='0'
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Load entitlement expression by contract -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_LOAD_EXPRESSION_BY_CONTRACT_ID
	base_table=EXPRESSION
	sql=
	SELECT QUERY,MEMBER_ID,CATFILTER_ID FROM EXPRESSION WHERE TRADING_ID IN (?trading_id?) order by CATFILTER_ID
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine last cache invalidation replay                                 -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=FIND_LAST_CACHE_REPLAY
	base_table=CACHEIVL
	dbtype=db2
	sql=
	SELECT INSERTTIME FROM CACHEIVL
	 WHERE TEMPLATE = 'restart:'
	 ORDER BY INSERTTIME DESC
	 FETCH FIRST 1 ROW ONLY
	dbtype=oracle
	sql=
	SELECT INSERTTIME FROM CACHEIVL
	 WHERE TEMPLATE = 'restart:'
	   AND ROWNUM <= 1
	 ORDER BY INSERTTIME DESC
	sql=
	SELECT INSERTTIME FROM CACHEIVL
	 WHERE TEMPLATE = 'restart:'
	 ORDER BY INSERTTIME DESC
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine storeId for invalidation                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_STORE_FOR_INVALIDATION
	base_table=STORECAT
	sql=
	SELECT STORECAT.STOREENT_ID
	  FROM STORECAT
	 WHERE STORECAT.CATALOG_ID = ?masterCatalogId?
	   AND STORECAT.MASTERCATALOG = '1'
	 UNION
	SELECT STOREREL.STORE_ID
	  FROM STORECAT, STOREREL
	 WHERE STORECAT.CATALOG_ID = ?masterCatalogId?
	   AND STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STOREREL.RELATEDSTORE_ID
	   AND STOREREL.STRELTYP_ID = -4
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine catalogId for invalidation                                     -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_FOR_INVALIDATION
	base_table=STORECAT
	sql=
	SELECT SC.CATALOG_ID
	  FROM STORECAT SC
	 WHERE SC.STOREENT_ID IN (
	SELECT STORECAT.STOREENT_ID
	  FROM STORECAT
	 WHERE STORECAT.CATALOG_ID = ?masterCatalogId?
	   AND STORECAT.MASTERCATALOG = '1'
	 UNION
	SELECT STOREREL.STORE_ID
	  FROM STORECAT, STOREREL
	 WHERE STORECAT.CATALOG_ID = ?masterCatalogId?
	   AND STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STOREREL.RELATEDSTORE_ID
	   AND STOREREL.STRELTYP_ID = -4)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Retrieve all catalog given a store                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_BY_STORE
	base_table=STORECAT
	sql=
	SELECT CATALOG_ID
 	  FROM STORECAT
	 WHERE STOREENT_ID IN (?storeId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Fetch all attributes and related properties from SRCHATTR, SRCHATTRPROP, 
         FACET, FACETCATGRP, ATTR for workspace                                -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Fetch all attributes and related properties from SRCHATTR, SRCHATTRPROP, FACET, FACETCATGRP, ATTR for workspace-->
	name=IBM_Select_Search_Attributes_Properties_Workspace
	base_table=SRCHATTR
	sql=
		SELECT S.INDEXTYPE, S.INDEXSCOPE, S.IDENTIFIER, SP.PROPERTYNAME, 
			SP.PROPERTYVALUE, S.SRCHATTR_ID, F.SELECTION, F.MAX_DISPLAY, F.GROUP_ID
		FROM $SCHEMA$.SRCHATTR S
		LEFT OUTER JOIN $SCHEMA$.SRCHATTRPROP SP ON S.SRCHATTR_ID = SP.SRCHATTR_ID
		LEFT OUTER JOIN $SCHEMA$.FACET F ON S.SRCHATTR_ID = F.SRCHATTR_ID
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if attribute is linked to a product							   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATENTRYATTR
	base_table=CATENTRYATTR
	sql=
	SELECT COUNT(*) AS COUNT
	FROM CATENTRYATTR
	WHERE ATTR_ID = ?attributeId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if attribute is linked to a product							   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATENTRYATTR_WORKSPACE
	base_table=CATENTRYATTR
	sql=
	SELECT COUNT(*) AS COUNT
	FROM $SCHEMA$.CATENTRYATTR
	WHERE ATTR_ID = ?attributeId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get attribute name by identifier for workspace                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SEARCHABLE_ATTR_NAME_WORKSPACE
	base_table=ATTRDESC
	sql=
	select ATTR_ID,NAME 
	from $SCHEMA$.ATTRDESC WHERE ATTR_ID IN(SELECT ATTR_ID FROM $SCHEMA$.ATTR WHERE IDENTIFIER =?name? and storeent_id in (?storeent_id?) and SEARCHABLE=1) AND LANGUAGE_ID=?languageId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if indexing is being performed                                 -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IS_PERFORMING_INVENTORY_INDEXING
	base_table=TI_DELTA_INVENTORY
	sql=
	SELECT TI_DELTA_INVENTORY.CATENTRY_ID, TI_DELTA_INVENTORY.LASTUPDATE 
	  FROM TI_DELTA_INVENTORY
	 WHERE TI_DELTA_INVENTORY.MASTERCATALOG_ID = ?masterCatalogId?
       AND TI_DELTA_INVENTORY.ACTION = 'P'
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find catalog entry in TI_DELTA_INVENTORY table                           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_TI_DELTA_INVENTORY
	base_table=TI_DELTA_INVENTORY
	sql=
    SELECT ACTION FROM TI_DELTA_INVENTORY
     WHERE MASTERCATALOG_ID = ?masterCatalogId? 
	   AND CATENTRY_ID = ?catalogEntryId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a row into the inventory delta update table                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_TI_DELTA_INVENTORY
	base_table=TI_DELTA_INVENTORY
	sql=
	INSERT INTO TI_DELTA_INVENTORY (MASTERCATALOG_ID, CATENTRY_ID, ACTION) 
	VALUES (?masterCatalogId?, ?catalogEntryId?, ?action?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Update catalog entry in TI_DELTA_INVENTORY table                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=UPDATE_TI_DELTA_INVENTORY
	base_table=TI_DELTA_INVENTORY
	sql=
    UPDATE TI_DELTA_INVENTORY
       SET ACTION = ?action?
     WHERE MASTERCATALOG_ID = ?masterCatalogId? 
	   AND CATENTRY_ID = ?catalogEntryId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete a row into the inventory delta update table                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_TI_DELTA_INVENTORY
	base_table=TI_DELTA_INVENTORY
	sql=
	DELETE FROM TI_DELTA_INVENTORY
	 WHERE MASTERCATALOG_ID = ?masterCatalogId?
       AND ACTION IN (?action?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Count any action from the inventory delta update table                   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=COUNT_ANY_INVENTORY_INDEXING
	base_table=TI_DELTA_INVENTORY
	sql=
	SELECT COUNT(*) as ROWCOUNT
	  FROM TI_DELTA_INVENTORY
	 WHERE TI_DELTA_INVENTORY.MASTERCATALOG_ID = ?masterCatalogId?	
END_SQL_STATEMENT




