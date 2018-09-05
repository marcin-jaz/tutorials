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
<!--  Retrieve rule last evaluation time                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_RULEBASEDCATEGORY_RULE
	base_table=CATGRPRULE
	sql=
	SELECT
   		*
	FROM
	    CATGRPRULE
	WHERE
    	CATGROUP_ID IN (?categoryId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Retrieve rule based category children                                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_RULEBASEDCATEGORY_CHILDREN
	base_table=CATGPENREL
	sql=
	SELECT
   		CATGPENREL.CATENTRY_ID,CATGPENREL.SEQUENCE
	FROM
	    CATGPENREL JOIN CATENTRY ON CATGPENREL.CATENTRY_ID=CATENTRY.CATENTRY_ID
	WHERE
    	CATGPENREL.CATALOG_ID=?catalogId? AND
    	CATGPENREL.CATGROUP_ID=?categoryId? AND
    	( CATGPENREL.SEQUENCE <> 0 OR
    	CATENTRY.CATENTTYPE_ID <> 'ItemBean' ) AND
    	CATENTRY.MARKFORDELETE = 0 ORDER BY CATGPENREL.SEQUENCE ASC
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Find all rule based categories eligible for evaluation                   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=FIND_ALL_RULE_BASED_CATEGORIES_FOR_EVAL
	base_table=CATGRPRULE
	sql=select 
			catgrprule.catgroup_id, 
			catgrprule.dmactivity_id, 
			catgrprule.evaltime, 
			catgrprule.showafter, 
			catgrprule.evaluating 
		from 
			catgroup, catgrprule 
		where 
			catgroup.catgroup_id=catgrprule.catgroup_id and 
			catgroup.dynamic=1 and 
			catgroup.markfordelete=0 and 
			(catgrprule.evaluating=0 or catgrprule.evaluating=2 or catgrprule.evaluating=-2)
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will synchronize the sequence of Catalog Entries to Catalog Group relation for the   -->
<!-- given Catalog Group Id and Catalog Links Catalog Id.                                          -->
<!-- @param sequence Sequence of child catalog entry.                                              -->
<!-- @param catalogEntryId Id of child catalog entry.                                              -->
<!-- @param catalogGroupID Id of parent catalog group.                                             -->
<!-- @param catalogID  The catalog id link for which relation has to be updated.                   --> 
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Update_RuleBasedCategoryCatEntrySequence
	base_table=CATGPENREL
	sql=
	
			UPDATE CATGPENREL SET CATGPENREL.SEQUENCE = ?sequence? 
			WHERE 
					CATGPENREL.CATENTRY_ID = ?catalogEntryId? AND 
					CATGPENREL.CATGROUP_ID = ?catalogGroupID? AND 
					CATGPENREL.CATALOG_ID = ?catalogID?	
					
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will select the evaluating column for a category.                                    -->
<!-- @param catalogGroupID Id of parent catalog group.                                             -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_RuleBasedCategory_isEvaluating
	base_table=CATGRPRULE
	sql=SELECT EVALUATING
			FROM
		CATGRPRULE 
			WHERE 
		CATGROUP_ID = ?catalogGroupID?
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will select all parent store ID and catalog ID for a given category.                 -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_RuleBasedCategory_storeAndCatalogSelection
	base_table=STORECGRP
	sql=
		SELECT 
			CATGRPREL.CATALOG_ID, STORECGRP.STOREENT_ID 
		FROM
			CATGRPREL,STORECGRP 
		WHERE
			STORECGRP.CATGROUP_ID=CATGRPREL.CATGROUP_ID_CHILD AND CATGRPREL.CATGROUP_ID_CHILD=?catalogGroupID?
	UNION
		SELECT 
			CATTOGRP.CATALOG_ID, STORECGRP.STOREENT_ID
		FROM 
			CATTOGRP,STORECGRP 
		WHERE
			STORECGRP.CATGROUP_ID=CATTOGRP.CATGROUP_ID AND CATTOGRP.CATGROUP_ID=?catalogGroupID?
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will update the evaluating column to '2' for all rule based categories.              -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Update_RuleBasedCategory_EvaluateAllIgnoreTimeInterval
	base_table=CATGRPRULE
	sql=
			UPDATE CATGRPRULE
				SET EVALUATING=2
			WHERE
				EVALUATING=0 OR EVALUATING=-2

END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will update the evaluating column and evaltime for a category.                       -->
<!-- @param evaltime Evaluation time of a catalog group rule.                                      -->
<!-- @param catalogGroupID Id of parent catalog group.                                             -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Update_RuleBasedCategory_FinishEvaluating
	base_table=CATGRPRULE
	dbtype=any
		sql=
			UPDATE CATGRPRULE 
				SET EVALUATING=0, 
				EVALTIME=?evaltime?			
			WHERE 
				CATGROUP_ID = ?catalogGroupID?
	dbtype=oracle
		sql=
			UPDATE CATGRPRULE 
				SET EVALUATING=0, 
				EVALTIME=TO_TIMESTAMP(?evaltime?, 'YYYY-MM-DD hh24:mi:ss.ff')
			WHERE 
				CATGROUP_ID = ?catalogGroupID?
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will update the evaluating column for a category.                                    -->
<!-- @param evaluating Evaluating a catalog group rule.                                            -->
<!-- @param catalogGroupID Id of parent catalog group.                                             -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Update_RuleBasedCategory_Evaluating
	base_table=CATGRPRULE
	sql=
	
			UPDATE CATGRPRULE 
				SET EVALUATING=?evaluating? 
			WHERE 
				CATGROUP_ID = ?catalogGroupID?	
				
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will select the parent category for a given category                                 -->
<!-- @param childCategoryId The category ID of the child category                                  -->
<!-- @param catalogId The ID of the catalog                                                        -->
<!-- @param languageId The language ID                                                             -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_RuleBasedCategoryEvaluation_GetParentCategory
	base_table=CATGRPREL
	sql=
			SELECT 
				CATGRPREL.CATGROUP_ID_PARENT
			from 
				CATGRPREL,CATGRPDESC,CATGROUP
			where 
				CATGRPREL.CATGROUP_ID_CHILD=?childCategoryId?
					and 
				CATGRPREL.catgroup_id_parent = CATGRPDESC.catgroup_id 
					and 
				CATGRPREL.catgroup_id_parent = CATGROUP.catgroup_id
					and 		
				CATGRPREL.catalog_id=?catalogId?
					and
				CATGRPDESC.LANGUAGE_ID = ?languageId? 
					and 
				CATGRPDESC.PUBLISHED = 1
					and 
				CATGROUP.MARKFORDELETE = 0
				
END_SQL_STATEMENT

<!-- ============================================================================================= -->
<!-- This SQL will select the child category for a given category                                  -->
<!-- @param parentCategoryId The category ID of the parent category                                -->
<!-- @param catalogId The ID of the catalog                                                        -->
<!-- @param languageId The language ID                                                             -->
<!-- ============================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_RuleBasedCategoryEvaluation_GetChildCategory
	base_table=CATGRPREL
	sql=
			SELECT 
				CATGRPREL.CATGROUP_ID_CHILD, CATGROUP.DYNAMIC
			from 
				CATGRPREL,CATGRPDESC,CATGROUP
			where 
				CATGRPREL.CATGROUP_ID_PARENT=?parentCategoryId?
					and 
				CATGRPREL.catgroup_id_child = CATGRPDESC.catgroup_id 
					and 
				CATGRPREL.catgroup_id_child = CATGROUP.catgroup_id
					and 							
				CATGRPREL.catalog_id=?catalogId?
					and
				CATGRPDESC.LANGUAGE_ID = ?languageId? 
					and 
				CATGRPDESC.PUBLISHED = 1
					and 
				CATGROUP.MARKFORDELETE = 0				
				
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select rows from the catalog entry workspace table by taskgroup          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_BY_TASKGROUP_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT DISTINCT WS.CATENTRY_ID, WS.MASTERCATALOG_ID, WS.ACTION, CE.MARKFORDELETE
	FROM $SCHEMA$.TI_CATENTRY_WS WS
	LEFT OUTER JOIN CATENTRY CE ON WS.CATENTRY_ID=CE.CATENTRY_ID
	WHERE 
	WS.TASKGROUP = ?taskGroupId? 
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get all store which use or share the master catalog   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_STORE_AND_STORETYPE_BY_MASTER_CATALOG
	base_table=STORE
	sql=
select STORE_ID,STORETYPE from store where store_id in (select storeent_id from storecat where catalog_id=?catalogId?  and mastercatalog='1') union select store_id,storetype from store where store_id in (SELECT STORE_ID FROM STOREREL REL WHERE STRELTYP_ID=-4 AND REL.relatedSTORE_ID IN (SELECT STOREENT_ID FROM STORECAT WHERE CATALOG_ID=?catalogId? and mastercatalog='1'))
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get all product,item, package from master catalog   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=SELECT_PRODUCT_ITEM_FOR_CATALOG
	base_table=CATENTRY
  sql=SELECT DISTINCT(CATENTRY.CATENTRY_ID) FROM CATENTRY,CATGPENREL WHERE CATENTRY.MARKFORDELETE=0 AND CATENTRY.CATENTRY_ID=CATGPENREL.CATENTRY_ID AND CATGPENREL.CATALOG_ID=?catalogId? AND CATENTRY.CATENTTYPE_ID IN('ProductBean','ItemBean')
END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  To get all bundle from master catalog   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=SELECT_COMPOSITE_CATENTRY_FOR_CATALOG
	base_table=CATENTRY
  sql=SELECT DISTINCT(CATENTRY.CATENTRY_ID) FROM CATENTRY,CATGPENREL WHERE CATENTRY.MARKFORDELETE=0 AND CATENTRY.CATENTRY_ID=CATGPENREL.CATENTRY_ID AND CATGPENREL.CATALOG_ID=?catalogId? AND CATENTRY.CATENTTYPE_ID IN('BundleBean')
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get all bundle component from master catalog   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=SELECT_COMPONENT_FOR_BUNDLE
	base_table=CATENTREL
  sql=SELECT CATENTRY_ID_CHILD, CATENTRY_ID_PARENT FROM CATENTREL WHERE CATENTRY_ID_PARENT IN (?bundleId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get currency by store   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_CURRENCY_BY_STORE
	base_table=CURLIST
  sql=SELECT CURRSTR,STOREENT_ID FROM CURLIST WHERE STOREENT_ID IN(?storeId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get contract by store   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_CONTRACT_BY_STORE
	base_table=CONTRACT
  sql=SELECT C.CONTRACT_ID,SC.STORE_ID FROM CONTRACT C, STORECNTR SC, TRADING T  WHERE C.CONTRACT_ID=SC.CONTRACT_ID AND C.CONTRACT_ID=T.TRADING_ID AND T.STATE=1 AND T.MARKFORDELETE = 0 AND (T.ENDTIME IS NULL OR ENDTIME > ?endtime?)  AND SC.STORE_ID in(?storeId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get catentry by store   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_CATENTRY_BY_STORE
	base_table=STORECENT
  sql=SELECT a.CATENTRY_ID,a.STOREENT_ID FROM STORECENT a, CATENTRY b WHERE a.STOREENT_ID IN (?storeId?) AND a.CATENTRY_ID=b.CATENTRY_ID AND b.CATENTTYPE_ID IN ('ProductBean','ItemBean','PackageBean') AND b.MARKFORDELETE = 0 order by a.catentry_id
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get catentry by store   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_CATENTRY_FROM_MASTER_CATALOG
	base_table=CATGPENREL
  sql=SELECT a.CATENTRY_ID FROM CATGPENREL A,CATENTRY B WHERE a.CATENTRY_ID=b.CATENTRY_ID  AND b.MARKFORDELETE = 0 AND A.CATALOG_ID = ?catalogId?
END_SQL_STATEMENT



<!-- ========================================================================= -->
<!--  To get store by catentry   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_STORE_BY_CATENTRY
	base_table=STORECENT
  sql=SELECT STOREENT_ID,A.CATENTRY_ID FROM STORECENT A,CATGPENREL B, CATENTRY C WHERE A.CATENTRY_ID IN (?catentryId?) AND A.CATENTRY_ID=B.CATENTRY_ID AND A.CATENTRY_ID=C.CATENTRY_ID AND C.MARKFORDELETE=0 AND B.CATALOG_ID=?catalogId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get store by contract   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_STORE_BY_CONTRACT
	base_table=STORECNTR
  sql=SELECT STORE_ID,CONTRACT_ID FROM STORECNTR A,TRADING B WHERE CONTRACT_ID IN (?contractId?) AND A.CONTRACT_ID=B.TRADING_ID AND B.STATE=1
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get assetstore by store   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_ASSETSTORE_BY_STORE
	base_table=STOREREL
  sql=SELECT relatedstore_id,store_id FROM storerel WHERE store_id IN (?storeId?) and streltyp_id = -4 order by sequence desc
END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  To get catentry with startvalue and endvalue   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_CATENTRY_BY_STARTVALUE_AND_ENDVALUE
	base_table=STORECENT,CATENTRY
	
	
  
	dbtype=oracle
	sql=SELECT CATENTRY_ID, CATENTTYPE_ID 
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY q.CATENTRY_ID) AS rn, 
        q.* 
        from 
  			(select distinct CATENTRY.CATENTRY_ID, CATENTRY.CATENTTYPE_ID FROM CATENTRY, STORECENT WHERE CATENTRY.MARKFORDELETE=0  AND CATENTRY.CATENTTYPE_ID IN('ProductBean','ItemBean','PackageBean') AND  CATENTRY.CATENTRY_ID=STORECENT.CATENTRY_ID AND STORECENT.STOREENT_ID=?storeId?) q
  		)
  WHERE rn BETWEEN ?start_value? AND ?end_value?
  
  dbtype=db2
	sql=SELECT CATENTRY_ID, CATENTTYPE_ID 
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY q.CATENTRY_ID) AS rn, 
        q.* 
        from 
  			(select distinct CATENTRY.CATENTRY_ID, CATENTRY.CATENTTYPE_ID FROM CATENTRY, STORECENT WHERE CATENTRY.MARKFORDELETE=0 AND CATENTRY.CATENTTYPE_ID IN('ProductBean','ItemBean','PackageBean') AND CATENTRY.CATENTRY_ID=STORECENT.CATENTRY_ID AND STORECENT.STOREENT_ID=?storeId?) q
  		)
  WHERE rn BETWEEN ?start_value? AND ?end_value?
  
  dbtype=os400
	sql=SELECT t.CATENTRY_ID, t.CATENTTYPE_ID 
  FROM ((SELECT ROW_NUMBER() OVER(ORDER BY q.CATENTRY_ID) AS rn, 
        q.* 
        from 
  			(select distinct CATENTRY.CATENTRY_ID, CATENTRY.CATENTTYPE_ID FROM CATENTRY, STORECENT WHERE CATENTRY.MARKFORDELETE=0  AND CATENTRY.CATENTTYPE_ID IN('ProductBean','ItemBean','PackageBean') AND  CATENTRY.CATENTRY_ID=STORECENT.CATENTRY_ID AND STORECENT.STOREENT_ID=?storeId?) q
  		)) as t
  WHERE t.rn BETWEEN ?start_value? AND ?end_value?


  dbtype=derby
  sql=SELECT a.CATENTRY_ID,a.STOREENT_ID FROM STORECENT a, CATENTRY b WHERE a.STOREENT_ID IN (?storeId?) AND a.CATENTRY_ID=b.CATENTRY_ID AND b.CATENTTYPE_ID IN ('ProductBean','ItemBean','PackageBean') AND b.MARKFORDELETE = 0 and a.catentry_id between  ?start_value? AND ?end_value?  order by a.catentry_id
  
 END_SQL_STATEMENT 
  
<!-- ========================================================================= -->
<!--  To get parent by catentry   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=FIND_PARENT_BY_CATENTRY
	base_table=CATENTREL
  sql=SELECT CATENTRY_ID_PARENT FROM CATENTREL WHERE CATENTRY_ID_PARENT IN(?catentryId?) AND CATRELTYPE_ID IN ('BUNDLE_COMPONENT') UNION SELECT CATENTRY_ID_PARENT FROM CATENTREL WHERE CATENTRY_ID_CHILD IN(?catentryId?) AND CATRELTYPE_ID IN ('BUNDLE_COMPONENT') 

END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get child for catentry   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=FIND_CHILD_BY_CATENTRY
	base_table=CATENTREL
  sql=SELECT CATENTRY_ID_CHILD,CATENTRY_ID_PARENT FROM CATENTREL WHERE CATENTRY_ID_PARENT IN(?catentryId?) AND CATRELTYPE_ID IN ('BUNDLE_COMPONENT')

END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  To get start time for contract   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=GET_STARTTIME_BY_CONTRACT
	base_table=TRADING
  sql=SELECT STARTTIME, TRADING_ID FROM TRADING WHERE TRADING_ID IN(?contractId?) 

END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  To get whether the specified catalog is master catalog   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
  name=IS_MASTER_CATALOG
	base_table=STORECAT
  sql=select CATALOG_ID from storecat where catalog_id=?catalogId?  and mastercatalog='1'
END_SQL_STATEMENT

<!-- =============================================================================== 
	Add new catalog group to catalog entry relations for SKUs of a product.
	This will set the sequence to 0 for all product level SKUs.
	@param catGroupId The catalog group id
	@param catEntryId The product id 
	@param catalogId The catalog id for the new relations
		
==================================================================================== -->
BEGIN_SQL_STATEMENT
	name=IBM_Insert_CreateCatalogGroupToCatalogEntryRelationsForSKUsForRuleBasedCategories	      
	base_table=CATGPENREL
	dbtype=oracle
	sql=
	INSERT INTO CATGPENREL (CATGROUP_ID, CATALOG_ID, CATENTRY_ID, LASTUPDATE)
	select TO_NUMBER(?catGroupId?), TO_NUMBER(?catalogId?), t1.catentry_id_child, SYSTIMESTAMP
	from catentrel t1
	where t1.catentry_id_parent=?catEntryId? and t1.CATRELTYPE_ID='PRODUCT_ITEM'
	   
	dbtype=db2
	sql=
	INSERT INTO CATGPENREL (CATGROUP_ID, CATALOG_ID, CATENTRY_ID, LASTUPDATE)
	select CAST(?catGroupId? as BIGINT), CAST(?catalogId? as BIGINT), t1.catentry_id_child, current timestamp
	from catentrel t1
	where t1.catentry_id_parent=?catEntryId? and t1.CATRELTYPE_ID='PRODUCT_ITEM'
	  
	sql=
	INSERT INTO CATGPENREL (CATGROUP_ID, CATALOG_ID, CATENTRY_ID, LASTUPDATE)
	select CAST(?catGroupId? as BIGINT), CAST(?catalogId? as BIGINT), t1.catentry_id_child, current timestamp
	from catentrel t1
	where t1.catentry_id_parent=?catEntryId? and t1.CATRELTYPE_ID='PRODUCT_ITEM'  
END_SQL_STATEMENT