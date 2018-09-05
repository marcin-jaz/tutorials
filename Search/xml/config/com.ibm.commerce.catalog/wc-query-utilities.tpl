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
<!--  Get the index field and relevancy value from table SRCHPROPRELV         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_INDEXFIELD_INFORMATION_QUERY
	base_table=SRCHPROPRELV
	sql=
	SELECT INDEXFIELD, RELVALUE
	FROM SRCHPROPRELV
	WHERE CATALOG_ID=?catalogId? AND CATGROUP_ID=?catgroupId? AND STOREENT_ID=?storeentId?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_INDEXFIELD_INFORMATION_QUERY_WORKSPACE
	base_table=SRCHPROPRELV
	sql=
	SELECT INDEXFIELD, RELVALUE
	FROM $SCHEMA$.SRCHPROPRELV
	WHERE CATALOG_ID=?catalogId? AND CATGROUP_ID=?catgroupId? AND STOREENT_ID=?storeentId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Get the SRCHPROPRELV id from table SRCHPROPRELV                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SRCHPROPRELV_ID_QUERY
	base_table=SRCHPROPRELV
	sql=
	SELECT SRCHPROPRELV_ID
	FROM SRCHPROPRELV
	WHERE CATALOG_ID=?catalogId? AND CATGROUP_ID=?catgroupId? AND STOREENT_ID=?storeId? AND INDEXFIELD=?srchfieldName?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a record into SRCHPROPRELV                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_SRCHPROPRELV
	base_table=SRCHPROPRELV
	sql=
	INSERT INTO SRCHPROPRELV
	(SRCHPROPRELV_ID, CATGROUP_ID, CATALOG_ID, STOREENT_ID, RELVALUE, INDEXFIELD)
	VALUES
	(?srchproprelvId?, ?catgroupId?, ?catalogId?, ?storeId?, ?relValue?, ?srchfieldName?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete a record for SRCHPROPRELV                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_SRCHPROPRELV
	base_table=SRCHPROPRELV
	sql=
	DELETE FROM SRCHPROPRELV
	WHERE INDEXFIELD = ?srchfieldName?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Resolve FFMCENTER_ID from STLFFMREL table giving STLOC_ID       		   -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_STLFFMREL
	base_table=STLFFMREL
	sql=
	SELECT FFMCENTER_ID
	  FROM STLFFMREL
	 WHERE STLOC_ID = ?stloc_id?
END_SQL_STATEMENT

<!-- ======================================================================================= -->
<!--  Retrieve search configuration for given master catalog by all store's default language -->
<!-- ======================================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SRCHCONF_DEFAULT
	base_table=SRCHCONF
	dbtype=any
	sql=
	SELECT STORECAT.CATALOG_ID,
	       STORE.LANGUAGE_ID,
	       SRCHCONF.INDEXSCOPE,
		   SRCHCONF.CONFIG
	  FROM STORECAT, STORE, SRCHCONF
	 WHERE STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STORE.STORE_ID
	   AND STORE.STATUS = 1
	   AND CHAR(STORECAT.CATALOG_ID) = SRCHCONF.INDEXSCOPE
	   AND SRCHCONF.INDEXTYPE = ?indexType?
	dbtype=oracle
	sql=
	SELECT STORECAT.CATALOG_ID,
	       STORE.LANGUAGE_ID,
	       SRCHCONF.INDEXSCOPE,
		   SRCHCONF.CONFIG
	  FROM STORECAT, STORE, SRCHCONF
	 WHERE STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STORE.STORE_ID
	   AND STORE.STATUS = 1
	   AND TO_CHAR(STORECAT.CATALOG_ID) = SRCHCONF.INDEXSCOPE
	   AND SRCHCONF.INDEXTYPE = ?indexType?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if attribute is facetable, searchable, or merchandisable       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_ATTR
	base_table=ATTR
	sql=
	SELECT SEARCHABLE, FACETABLE, MERCHANDISABLE, STOREENT_ID, ATTRTYPE_ID, IDENTIFIER
	FROM ATTR
	WHERE ATTR_ID = ?attributeId?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_ATTR_WORKSPACE
	base_table=ATTR
	sql=
	SELECT SEARCHABLE, FACETABLE, MERCHANDISABLE, STOREENT_ID, ATTRTYPE_ID, IDENTIFIER
	FROM $SCHEMA$.ATTR
	WHERE ATTR_ID = ?attributeId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if attribute is facetable or searchable or merchandisable      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_ATTR_IDENTIFIER
	base_table=ATTR
	sql=
	SELECT SEARCHABLE, FACETABLE, MERCHANDISABLE, STOREENT_ID, ATTRTYPE_ID, ATTR_ID
	FROM ATTR
	WHERE IDENTIFIER = ?identifier?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_ATTR_IDENTIFIER_WORKSPACE
	base_table=ATTR
	sql=
	SELECT SEARCHABLE, FACETABLE, MERCHANDISABLE, STOREENT_ID, ATTRTYPE_ID, ATTR_ID
	FROM $SCHEMA$.ATTR
	WHERE IDENTIFIER = ?identifier?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Retrieve search configuration table                                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SRCHCONFEXT
	base_table=SRCHCONFEXT
	sql=
	SELECT CONFIG,
		   INDEXSUBTYPE
	  FROM SRCHCONFEXT
	 WHERE INDEXTYPE = ?indexType?
	   AND (LANGUAGE_ID = ?langId? OR LANGUAGE_ID is null)
	   AND INDEXSCOPE = ?masterCatalogId?	
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Retrieve search term association tables                                  -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SRCHTERMASSOCS
	base_table=SRCHTERMASSOC
	sql=
	SELECT
	    SRCHTERMASSOC.SRCHTERMASSOC_ID,
	    SRCHTERM.TERM,
	    SRCHTERMASSOC.ASSOCIATIONTYPE,
		SRCHTERM.TYPE
	FROM
	    SRCHTERM,
	    SRCHTERMASSOC
	WHERE
	    SRCHTERM.SRCHTERMASSOC_ID=SRCHTERMASSOC.SRCHTERMASSOC_ID
		AND SRCHTERMASSOC.LANGUAGE_ID=?languageId?
		AND SRCHTERMASSOC.STOREENT_ID IN (?storeId?)
	ORDER BY
    	SRCHTERMASSOC.SRCHTERMASSOC_ID
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_SRCHTERMASSOCS_WORKSPACE
	base_table=SRCHTERMASSOC
	sql=
	SELECT
	    STA.SRCHTERMASSOC_ID,
	    ST.TERM,
	    STA.ASSOCIATIONTYPE,
		ST.TYPE
	FROM
	    $SCHEMA$.SRCHTERM ST,
	    $SCHEMA$.SRCHTERMASSOC STA
	WHERE
	    ST.SRCHTERMASSOC_ID=STA.SRCHTERMASSOC_ID
		AND STA.LANGUAGE_ID=?languageId?
		AND STA.STOREENT_ID IN (?storeId?)
	ORDER BY
    	STA.SRCHTERMASSOC_ID
END_SQL_STATEMENT

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
<!--  Determine all facetable columns registered for search                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATEGORY_FACET_OVERRIDE
	base_table=FACETCATGRP
	sql=
	SELECT FACETCATGRP.SEQUENCE,FACETCATGRP.STOREENT_ID,FACETCATGRP.DISPLAYABLE,SRCHATTRPROP.PROPERTYVALUE,FACETCATGRP.CATGROUP_ID
	from FACETCATGRP, FACET, SRCHATTRPROP
	where  FACET.FACET_ID=FACETCATGRP.FACET_ID and 
		  FACET.SRCHATTR_ID=SRCHATTRPROP.SRCHATTR_ID and
		  CATGROUP_ID IN (?categoryId?, 0) and  		  
		  FACETCATGRP.storeent_id IN (?storeList?) and 
		  SRCHATTRPROP.PROPERTYNAME IN ('facet','facet-classicAttribute','facet-category','facet-range')
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_CATEGORY_FACET_OVERRIDE_WORKSPACE
	base_table=FACETCATGRP
	sql=
	SELECT FCG.SEQUENCE, FCG.STOREENT_ID, FCG.DISPLAYABLE, SAP.PROPERTYVALUE, FCG.CATGROUP_ID
	from $SCHEMA$.FACETCATGRP FCG, $SCHEMA$.FACET F, $SCHEMA$.SRCHATTRPROP SAP
	where  F.FACET_ID=FCG.FACET_ID and 
		  F.SRCHATTR_ID=SAP.SRCHATTR_ID and 
		  FCG.CATGROUP_ID IN (?categoryId?, 0) and  
		  FCG.storeent_id IN (?storeList?) and 
		  SAP.PROPERTYNAME IN ('facet','facet-classicAttribute','facet-category','facet-range')
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facetable columns registered in the table SRCHATTRPROP.    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_COLUMNS_SRCHATTRPROP
	base_table=SRCHATTRPROP
	sql=
	select PROPERTYNAME,PROPERTYVALUE 
	from SRCHATTRPROP LEFT JOIN SRCHATTR on 
	SRCHATTRPROP.SRCHATTR_ID=SRCHATTR.SRCHATTR_ID 
	where indextype=?indexType? and propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
	and indexscope in ('0', ?masterCatalogId?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_COLUMNS_SRCHATTRPROP_WORKSPACE
	base_table=SRCHATTRPROP
	sql=
	select PROPERTYNAME,PROPERTYVALUE 
	from $SCHEMA$.SRCHATTRPROP SAP
	LEFT JOIN $SCHEMA$.SRCHATTR SA on 
	SAP.SRCHATTR_ID=SA.SRCHATTR_ID 
	where indextype=?indexType? and propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
	and indexscope in ('0', ?masterCatalogId?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the display columns registered in the table SRCHATTRPROP.    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_DISPLAYABLE_COLUMNS_SRCHATTRPROP
	base_table=SRCHATTRPROP
	sql=
	select PROPERTYNAME,PROPERTYVALUE,INDEXSCOPE 
	from SRCHATTRPROP LEFT JOIN SRCHATTR on 
	SRCHATTRPROP.SRCHATTR_ID=SRCHATTR.SRCHATTR_ID 
	where indextype=?indexType? and propertyname in ('display')
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facet information                                          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION
	base_table=FACET
	sql=
	select 
	srchattr.srchattr_id as srchattr_id,
	srchattrprop.propertyname as propertyname,
	srchattrprop.propertyvalue as propertyvalue,
	srchattr.identifier as srchattridentifier,
	facet.facet_id as facet_id,
	facet.attr_id as attr_id,
	facet.selection as selection,
	facet.keyword_search as keyword_search,
	facet.zero_display as zero_display,
	facet.storeent_id as storeent_id,
	facet.max_display as max_display,
	facet.sequence as sequence,
	facet.sort_order as sort_order,
	facet.group_id as group_id,
	facet.field1 as ffield1,
	facet.field2 as ffield2,
	facet.field3 as ffield3,
	facetdesc.name as fname,
	facetdesc.language_id as flang,
	facetdesc.description as fdesc,
	facetdesc.field1 as fdescfield1,
	facetdesc.field2 as fdescfield2,
	facetdesc.field3 as fdescfield3,
	attr.identifier as attridentifier,
	attr.attrtype_id as attrtype,
	attr.sequence as attrsequence,
	attr.facetable as facetable,
	attrdesc.name as attrname,
	attrdesc.language_id as attrlang,
	attrdesc.description as attrdesc 
	from srchattrprop 
	LEFT JOIN srchattr ON srchattrprop.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facet ON facet.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facetdesc ON facet.facet_id=facetdesc.facet_id and facetdesc.language_id=?languageId?
	LEFT JOIN attr on facet.attr_id=attr.attr_id
	LEFT JOIN attrdesc on attr.attr_id=attrdesc.attr_id and attrdesc.language_id=?languageId?
	where 
	srchattrprop.propertyname in ('facet','facet-classicAttribute','facet-category','facet-range') and 
	srchattr.indextype=?indexType? and 
	srchattrprop.propertyvalue in (?propertyValue?) and
	facet.storeent_id IN (?storeList?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION_WORKSPACE
	base_table=FACET
	sql=
	select 
	SA.srchattr_id as srchattr_id,
	SAP.propertyname as propertyname,
	SAP.propertyvalue as propertyvalue,
	SA.identifier as srchattridentifier,
	F.facet_id as facet_id,
	F.attr_id as attr_id,
	F.selection as selection,
	F.keyword_search as keyword_search,
	F.zero_display as zero_display,
	F.storeent_id as storeent_id,
	F.max_display as max_display,
	F.sequence as sequence,
	F.sort_order as sort_order,
	F.group_id as group_id,
	F.field1 as ffield1,
	F.field2 as ffield2,
	F.field3 as ffield3,
	FD.name as fname,
	FD.language_id as flang,
	FD.description as fdesc,
	FD.field1 as fdescfield1,
	FD.field2 as fdescfield2,
	FD.field3 as fdescfield3,
	A.identifier as attridentifier,
	A.attrtype_id as attrtype,
	A.sequence as attrsequence,
	A.facetable as facetable,
	AD.name as attrname,
	AD.language_id as attrlang,
	AD.description as attrdesc 
	from $SCHEMA$.srchattrprop SAP
	LEFT JOIN $SCHEMA$.srchattr SA ON SAP.srchattr_id=SA.srchattr_id 
	LEFT JOIN $SCHEMA$.facet F ON F.srchattr_id=SA.srchattr_id 
	LEFT JOIN $SCHEMA$.facetdesc FD ON F.facet_id=FD.facet_id and FD.language_id=?languageId?
	LEFT JOIN $SCHEMA$.attr A on F.attr_id=A.attr_id
	LEFT JOIN $SCHEMA$.attrdesc AD on A.attr_id=AD.attr_id and AD.language_id=?languageId?
	where 
	SAP.propertyname in ('facet','facet-classicAttribute','facet-category','facet-range') and 
	SA.indextype=?indexType? and 
	SAP.propertyvalue in (?propertyValue?) and
	F.storeent_id IN (?storeList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facet information                                          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION_FOR_KEYWORD_SEARCH
	base_table=FACET
	sql=
	select 
	srchattr.srchattr_id as srchattr_id,
	srchattrprop.propertyname as propertyname,
	srchattrprop.propertyvalue as propertyvalue,
	srchattr.identifier as srchattridentifier,
	facet.facet_id as facet_id,
	facet.attr_id as attr_id,
	facet.selection as selection,
	facet.keyword_search as keyword_search,
	facet.zero_display as zero_display,
	facet.storeent_id as storeent_id,
	facet.max_display as max_display,
	facet.sequence as sequence,
	facet.group_id as group_id,
	facet.sort_order as sort_order,
	facet.field1 as ffield1,
	facet.field2 as ffield2,
	facet.field3 as ffield3,
	facetdesc.name as fname,
	facetdesc.language_id as flang,
	facetdesc.description as fdesc,
	facetdesc.field1 as fdescfield1,
	facetdesc.field2 as fdescfield2,
	facetdesc.field3 as fdescfield3,
	attr.identifier as attridentifier,
	attr.attrtype_id as attrtype,
	attr.sequence as attrsequence,
	attr.facetable as facetable,
	attrdesc.name as attrname,
	attrdesc.language_id as attrlang,
	attrdesc.description as attrdesc 
	from srchattrprop 
	JOIN srchattr ON srchattrprop.srchattr_id=srchattr.srchattr_id 
	JOIN facet ON facet.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facetdesc ON facet.facet_id=facetdesc.facet_id and facetdesc.language_id=?languageId?
	LEFT JOIN attr on facet.attr_id=attr.attr_id 
	LEFT JOIN attrdesc on attr.attr_id=attrdesc.attr_id and attrdesc.language_id=?languageId?
	where 
	facet.keyword_search=1 and
	srchattr.indextype=?indexType? and 
	srchattrprop.propertyname IN ('facet','facet-classicAttribute','facet-category','facet-range') and 
	facet.storeent_id IN (?storeList?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION_FOR_KEYWORD_SEARCH_WORKSPACE
	base_table=FACET
	sql=
	select 
	SA.srchattr_id as srchattr_id,
	SAP.propertyname as propertyname,
	SAP.propertyvalue as propertyvalue,
	SA.identifier as srchattridentifier,
	F.facet_id as facet_id,
	F.attr_id as attr_id,
	F.selection as selection,
	F.keyword_search as keyword_search,
	F.zero_display as zero_display,
	F.storeent_id as storeent_id,
	F.max_display as max_display,
	F.sequence as sequence,
	F.group_id as group_id,
	F.sort_order as sort_order,
	F.field1 as ffield1,
	F.field2 as ffield2,
	F.field3 as ffield3,
	FD.name as fname,
	FD.language_id as flang,
	FD.description as fdesc,
	FD.field1 as fdescfield1,
	FD.field2 as fdescfield2,
	FD.field3 as fdescfield3,
	A.identifier as attridentifier,
	A.attrtype_id as attrtype,
	A.sequence as attrsequence,
	A.facetable as facetable,
	AD.name as attrname,
	AD.language_id as attrlang,
	AD.description as attrdesc 
	from $SCHEMA$.srchattrprop SAP
	JOIN $SCHEMA$.srchattr SA ON SAP.srchattr_id=SA.srchattr_id 
	JOIN $SCHEMA$.facet F ON F.srchattr_id=SA.srchattr_id 
	LEFT JOIN $SCHEMA$.facetdesc FD ON F.facet_id=FD.facet_id and FD.language_id=?languageId?
	LEFT JOIN $SCHEMA$.attr A on F.attr_id=A.attr_id 
	LEFT JOIN $SCHEMA$.attrdesc AD on A.attr_id=AD.attr_id and AD.language_id=?languageId?
	where 
	F.keyword_search=1 and
	SA.indextype=?indexType? and 
	SAP.propertyname IN ('facet','facet-classicAttribute','facet-category','facet-range') and 
	F.storeent_id IN (?storeList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the image and sequence of the facetable attribute values       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_VALUE_IMAGE_AND_SEQUENCE
	base_table=ATTRDICTSRCHCONF
	sql=
	select distinct ADSC.SRCHFIELDNAME, AVD.value, AV.storeent_id, AVD.sequence, AVD.image1, AVD.image2 
	from 
	  attrdictsrchconf ADSC, attr A, attrval AV, attrvaldesc AVD
	where 
	  ADSC.ATTR_ID is not NULL and  
	  ADSC.attr_id = A.attr_id and
	  ADSC.mastercatalog_id = ?catalogId? and
	  ADSC.srchfieldname in (?searchFieldName?) and
	  A.storeent_id in (?storeList?) and
	  A.facetable = 1 and
	  AV.attr_id = A.attr_id and
	  AV.storeent_id in (?storeList?) and
	  AV.attrval_id = AVD.attrval_id and
	  AVD.language_id = ?languageId?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACET_VALUE_IMAGE_AND_SEQUENCE_WORKSPACE
	base_table=ATTRDICTSRCHCONF
	sql=
	select distinct ADSC.SRCHFIELDNAME, AVD.value, AV.storeent_id, AVD.sequence, AVD.image1, AVD.image2 
	from 
	  $SCHEMA$.attrdictsrchconf ADSC, $SCHEMA$.attr A, $SCHEMA$.attrval AV, $SCHEMA$.attrvaldesc AVD
	where 
	  ADSC.ATTR_ID is not NULL and  
	  ADSC.attr_id = A.attr_id and
	  ADSC.mastercatalog_id = ?catalogId? and
	  ADSC.srchfieldname in (?searchFieldName?) and
	  A.storeent_id in (?storeList?) and
	  A.facetable = 1 and
	  AV.attr_id = A.attr_id and
	  AV.storeent_id in (?storeList?) and
	  AV.attrval_id = AVD.attrval_id and
	  AVD.language_id = ?languageId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facet configuration for a list of search columns           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_CONFIGURATION_FOR_SEARCH_COLUMNS
	base_table=FACET
	sql=
	select propertyvalue, selection, sort_order, keyword_search, zero_display, max_display from 
	srchattrprop join facet on srchattrprop.srchattr_id=facet.srchattr_id 
	where propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
		and storeent_id in (?storeList?)
		and propertyvalue in (?propertyValueList?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACET_CONFIGURATION_FOR_SEARCH_COLUMNS_WORKSPACE
	base_table=FACET
	sql=
	select propertyvalue, selection, sort_order, keyword_search, zero_display, max_display from 
	$SCHEMA$.srchattrprop SAP join $SCHEMA$.facet F on SAP.srchattr_id=F.srchattr_id 
	where propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
		and storeent_id in (?storeList?)
		and propertyvalue in (?propertyValueList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the order of facets for a given category                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_CATEGORY_NAVIGATION
	base_table=FACET
	sql=
	SELECT FACET.SRCHATTR_ID, COALESCE(FACETCATGRP.SEQUENCE, FACET.SEQUENCE) SEQUENCE
	FROM FACET
	  LEFT OUTER JOIN FACETCATGRP ON FACET.FACET_ID = FACETCATGRP.FACET_ID 
	  		AND FACETCATGRP.CATGROUP_ID=?catalogGroupId?
	  		<!-- AND FACETCATGRP.STOREENT_ID in ($STOREPATH:catalog$) -->
	  		<!-- temporarily using the store id parameter instead of the STOREPATH tag; pending on BCS availability -->
	  		AND FACETCATGRP.STOREENT_ID in (?storeId?) 
	WHERE FACET.SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_CATEGORY_NAVIGATION_WORKSPACE
	base_table=FACET
	sql=
	SELECT F.SRCHATTR_ID, COALESCE(FCG.SEQUENCE, F.SEQUENCE) SEQUENCE
	FROM $SCHEMA$.FACET F
	  LEFT OUTER JOIN $SCHEMA$.FACETCATGRP FCG ON F.FACET_ID = FCG.FACET_ID 
	  		AND FCG.CATGROUP_ID=?catalogGroupId?
	  		AND FCG.STOREENT_ID in (?storeId?) 
	WHERE F.SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the order of facets for keyword search                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_KEYWORD_SEARCH 
	base_table=FACET
	sql=
	SELECT FACET.SRCHATTR_ID, FACET.SEQUENCE
	FROM FACET
	WHERE FACET.SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_KEYWORD_SEARCH_WORKSPACE
	base_table=FACET
	sql=
	SELECT SRCHATTR_ID, SEQUENCE
	FROM $SCHEMA$.FACET
	WHERE SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	<!-- Fetch all attributes and related properties from SRCHATTR, SRCHATTRPROP, FACET, FACETCATGRP, ATTR -->
	name=IBM_Select_Search_Attributes_Properties
	base_table=SRCHATTR
	sql=
		SELECT SRCHATTR.INDEXTYPE, SRCHATTR.INDEXSCOPE, SRCHATTR.IDENTIFIER, SRCHATTRPROP.PROPERTYNAME, 
			SRCHATTRPROP.PROPERTYVALUE, SRCHATTR.SRCHATTR_ID, FACET.SELECTION, FACET.MAX_DISPLAY, FACET.GROUP_ID
		FROM SRCHATTR
		LEFT OUTER JOIN SRCHATTRPROP ON SRCHATTR.SRCHATTR_ID = SRCHATTRPROP.SRCHATTR_ID
		LEFT OUTER JOIN FACET ON SRCHATTR.SRCHATTR_ID = FACET.SRCHATTR_ID
END_SQL_STATEMENT

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
<!--  To get attribute name by identifier                                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SEARCHABLE_ATTR_NAME
	base_table=ATTRDESC
	sql=
	select ATTR_ID,NAME 
	from ATTRDESC WHERE ATTR_ID IN(SELECT ATTR_ID FROM ATTR WHERE IDENTIFIER =?name? and storeent_id in (?storeent_id?) and SEARCHABLE=1) AND LANGUAGE_ID=?languageId?
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
<!--  Get attribute id for a given category                                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_ATTR_ID_FOR_CATEGORY
	base_table=FACET
	sql=
		SELECT attr_id
		FROM
			facet
		WHERE
    		attr_id IN
    	(
	        SELECT DISTINCT attr_id
	        FROM
	            catentryattr
	        WHERE
	            catentry_id IN
	            (
	                SELECT
	                    catentry_id
	                FROM
	                    catgpenrel
	                WHERE
	                    catgroup_id IN (?catgroupId?)
	                AND catalog_id IN (?catalogId?)
	            )
    	)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_ATTR_ID_FOR_CATEGORY_WORKSPACE
	base_table=FACET
	sql=
		SELECT attr_id
		FROM
			$SCHEMA$.facet
		WHERE
    		attr_id IN
    	(
	        SELECT DISTINCT attr_id
	        FROM
	            $SCHEMA$.catentryattr
	        WHERE
	            catentry_id IN
	            (
	                SELECT
	                    catentry_id
	                FROM
	                    $SCHEMA$.catgpenrel
	                WHERE
	                    catgroup_id IN (?catgroupId?)
	                AND catalog_id IN (?catalogId?)
	            )
    	)
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
<!--  Get catalog id from storecat                                             -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_ID_FROM_STORECAT
	base_table=storecat
	sql=
	SELECT CATALOG_ID FROM STORECAT WHERE STOREENT_ID IN (?storeIds?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_ID_FROM_STORECAT_WORKSPACE
	base_table=storecat
	sql=
	SELECT CATALOG_ID FROM $SCHEMA$.STORECAT WHERE STOREENT_ID IN (?storeIds?)
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

<!-- ===========================================================================
     Query to retrieve the catalog override group id for a store.
	 @param storeId
		The unique identifier for store
     =========================================================================== -->
BEGIN_SQL_STATEMENT
  name=IBM_Select_OverrideGroupID_By_StoreID
  base_table=STORECATOVRGRP
  sql= SELECT STORECATOVRGRP.CATOVRGRP_ID 
  		FROM 
  			STORECATOVRGRP 
  		WHERE 
  			STORECATOVRGRP.STOREENT_ID IN (?storeId?)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
  name=IBM_Select_OverrideGroupID_By_StoreID_Workspace
  base_table=STORECATOVRGRP
  sql= SELECT CATOVRGRP_ID 
  		FROM 
  			$SCHEMA$.STORECATOVRGRP 
  		WHERE 
  			STOREENT_ID IN (?storeId?)
END_SQL_STATEMENT

<!-- ===========================================================================
     Query to retrieve the catalog entry description for the given catalog entries and language ids.
     @param UniqueID List of unique identifiers for catalog entries
     @param language The language ids.     
     =========================================================================== -->
BEGIN_SQL_STATEMENT
	name=IBM_Get_CatentryDesc_By_LangId_And_CatentryId
	base_table=CATENTDESC
	sql=
		SELECT CATENTRY_ID, NAME, SHORTDESCRIPTION, LONGDESCRIPTION, KEYWORD, THUMBNAIL, FULLIMAGE FROM 
			CATENTDESC 
		WHERE CATENTRY_ID IN (?UniqueID?) AND LANGUAGE_ID IN (?language?)
		ORDER BY CATENTRY_ID, LANGUAGE_ID
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=IBM_Get_CatentryDesc_By_LangId_And_CatentryId_Workspace
	base_table=CATENTDESC
	sql=
		SELECT CATENTRY_ID, NAME, SHORTDESCRIPTION, LONGDESCRIPTION, KEYWORD, THUMBNAIL, FULLIMAGE FROM 
			$SCHEMA$.CATENTDESC 
		WHERE CATENTRY_ID IN (?UniqueID?) AND LANGUAGE_ID IN (?language?)
		ORDER BY CATENTRY_ID, LANGUAGE_ID
END_SQL_STATEMENT

<!-- ===========================================================================
     Query to retrieve the catalog entry description override for the given catalog entries, overide group and language ids.
     @param UniqueID List of unique identifiers for catalog entries
     @param catOverrideGroupID The unique identifier of the catalog override group.  
     @param language The language ids.
     =========================================================================== -->
BEGIN_SQL_STATEMENT
	name=IBM_Get_CatentryDescOverride_By_LangId_And_CatentryId_And_GroupId
	base_table=CATENTDESCOVR
	sql=
		SELECT CATENTRY_ID, NAME, SHORTDESCRIPTION, LONGDESCRIPTION, KEYWORD, THUMBNAIL, FULLIMAGE  FROM 
		CATENTDESCOVR WHERE 
		CATENTDESCOVR.CATENTRY_ID IN (?UniqueID?) AND 
		CATENTDESCOVR.CATOVRGRP_ID = ?catOverrideGroupID?  AND 
		CATENTDESCOVR.LANGUAGE_ID IN (?language?) 	
		ORDER BY CATENTDESCOVR.CATENTRY_ID, CATENTDESCOVR.LANGUAGE_ID
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=IBM_Get_CatentryDescOverride_By_LangId_And_CatentryId_And_GroupId_Workspace
	base_table=CATENTDESCOVR
	sql=
		SELECT CATENTRY_ID, NAME, SHORTDESCRIPTION, LONGDESCRIPTION, KEYWORD, THUMBNAIL, FULLIMAGE  FROM 
		$SCHEMA$.CATENTDESCOVR WHERE 
		CATENTRY_ID IN (?UniqueID?) AND 
		CATOVRGRP_ID = ?catOverrideGroupID?  AND 
		LANGUAGE_ID IN (?language?) 	
		ORDER BY CATENTRY_ID, LANGUAGE_ID
END_SQL_STATEMENT

<!-- ========================================================= -->
<!-- ===== Get default override group of the given store ===== -->
<!-- ========================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Get_DefaultCatalogOverrideGroupForStore
	base_table=CATOVRGRP
	sql=
		SELECT CATOVRGRP_ID
		FROM CATOVRGRP WHERE STOREENT_ID=?storeId?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=IBM_Get_DefaultCatalogOverrideGroupForStore_Workspace
	base_table=CATOVRGRP
	sql=
		SELECT CATOVRGRP_ID
		FROM $SCHEMA$.CATOVRGRP WHERE STOREENT_ID=?storeId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert search related statistics                                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_Admin_Insert_InsertSearchStatistics
    base_table=SRCHSTAT
    dbtype=any
	sql=
    INSERT INTO SRCHSTAT
           (SRCHSTAT_ID, KEYWORD, LANGUAGE_ID, STOREENT_ID, CATALOG_ID, KEYWORDCOUNT, SEARCHCOUNT, SUGGESTIONCOUNT, SUGGESTION, LOGDETAIL, LOGDATE)
    VALUES (?SRCHSTAT_ID?, ?KEYWORD?, ?LANGUAGE_ID?, ?STOREENT_ID?, ?CATALOG_ID?, ?KEYWORDCOUNT?, ?SEARCHCOUNT?, ?SUGGESTIONCOUNT?, ?SUGGESTION?, ?LOGDETAIL?, ?LOGDATE?)
	dbtype=oracle
	sql=
    INSERT INTO SRCHSTAT
           (SRCHSTAT_ID, KEYWORD, LANGUAGE_ID, STOREENT_ID, CATALOG_ID, KEYWORDCOUNT, SEARCHCOUNT, SUGGESTIONCOUNT, SUGGESTION, LOGDETAIL, LOGDATE)
    VALUES (?SRCHSTAT_ID?, ?KEYWORD?, ?LANGUAGE_ID?, ?STOREENT_ID?, ?CATALOG_ID?, ?KEYWORDCOUNT?, ?SEARCHCOUNT?, ?SUGGESTIONCOUNT?, ?SUGGESTION?, ?LOGDETAIL?, TO_TIMESTAMP(?LOGDATE?, 'YYYY-MM-DD hh24:mi:ss.ff'))
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Get srchstat id from SRCHSTAT                                            -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=GET_SRCHSTAT_ID_FROM_SRCHSTAT
    base_table=SRCHSTAT
	sql=
    SELECT MAX(SRCHSTAT_ID) SRCHSTAT_ID FROM SRCHSTAT
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To get flex flow by storeid and feature                                           -->
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

<!-- ================================================================================================= -->
<!-- This SQL query will return records for Merchandising Associations from MASSOCCECE table.		   -->
<!-- ================================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_MERCHANDISING_ASSOCIATIONS_BY_CATALOG_ENTRY_ID
    base_table=MASSOCCECE
	sql=
	SELECT MASSOCTYPE_ID,
		   QUANTITY,
		   CATENTRY_ID_FROM,
		   CATENTRY_ID_TO
	  FROM 
	  MASSOCCECE  
	  WHERE CATENTRY_ID_FROM IN (?UniqueID?) AND
        	STORE_ID IN (?StorePath?)
	  ORDER BY
				CATENTRY_ID_FROM, RANK   			
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=IBM_GET_MERCHANDISING_ASSOCIATIONS_BY_CATALOG_ENTRY_ID_WORKSPACE
    base_table=MASSOCCECE
	sql=
	SELECT MASSOCTYPE_ID,
		   QUANTITY,
		   CATENTRY_ID_FROM,
		   CATENTRY_ID_TO
	  FROM 
	  	   $SCHEMA$.MASSOCCECE  
	  WHERE CATENTRY_ID_FROM IN (?UniqueID?) AND
        	STORE_ID IN (?StorePath?)
	  ORDER BY
			CATENTRY_ID_FROM, RANK   			
END_SQL_STATEMENT

<!-- ========================================================================================================================= -->
<!-- This SQL query will return records for Merchandising Associations from MASSOCCECE table with specified association types. -->
<!-- ========================================================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_MERCHANDISING_ASSOCIATIONS_BY_CATALOG_ENTRY_ID_AND_ASSOCIATION_TYPE
    base_table=MASSOCCECE
	sql=
	SELECT MASSOCTYPE_ID,
		   QUANTITY,
		   CATENTRY_ID_FROM,
		   CATENTRY_ID_TO
	  FROM 
	  MASSOCCECE  
	  WHERE CATENTRY_ID_FROM IN (?UniqueID?) AND 
	  		MASSOCCECE.MASSOCTYPE_ID IN (?AssociationType?) AND
        	STORE_ID IN (?StorePath?)
	  ORDER BY
				CATENTRY_ID_FROM, RANK   			
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=IBM_GET_MERCHANDISING_ASSOCIATIONS_BY_CATALOG_ENTRY_ID_AND_ASSOCIATION_TYPE_WORKSPACE
    base_table=MASSOCCECE
	sql=
	SELECT MASSOCTYPE_ID,
		   QUANTITY,
		   CATENTRY_ID_FROM,
		   CATENTRY_ID_TO
	  FROM 
	  	   $SCHEMA$.MASSOCCECE  
	  WHERE CATENTRY_ID_FROM IN (?UniqueID?) AND 
	  		MASSOCCECE.MASSOCTYPE_ID IN (?AssociationType?) AND
        	STORE_ID IN (?StorePath?)
	  ORDER BY
			CATENTRY_ID_FROM, RANK   			
END_SQL_STATEMENT

<!-- ======================================================================================= -->
<!--  Retrieve search configuration for given master catalog by all store's default language -->
<!-- ======================================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_SRCHCONF_DEFAULT
	base_table=SRCHCONF
	dbtype=any
	sql=
	SELECT STORECAT.CATALOG_ID,
	       STORE.LANGUAGE_ID,
	       SRCHCONF.INDEXSCOPE,
		   SRCHCONF.CONFIG
	  FROM STORECAT, STORE, SRCHCONF
	 WHERE STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STORE.STORE_ID
	   AND STORE.STATUS = 1
	   AND CHAR(STORECAT.CATALOG_ID) = SRCHCONF.INDEXSCOPE
	   AND SRCHCONF.INDEXTYPE = ?indexType?
	dbtype=oracle
	sql=
	SELECT STORECAT.CATALOG_ID,
	       STORE.LANGUAGE_ID,
	       SRCHCONF.INDEXSCOPE,
		   SRCHCONF.CONFIG
	  FROM STORECAT, STORE, SRCHCONF
	 WHERE STORECAT.MASTERCATALOG = '1'
	   AND STORECAT.STOREENT_ID = STORE.STORE_ID
	   AND STORE.STATUS = 1
	   AND TO_CHAR(STORECAT.CATALOG_ID) = SRCHCONF.INDEXSCOPE
	   AND SRCHCONF.INDEXTYPE = ?indexType?
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
<!-- To get member roles for a user under an organization                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_MEMBER_ROLES_IN_ORG
	base_table=mbrrole 
	sql=
	SELECT role_id from mbrrole where member_id = ?member_id? and orgentity_id=?orgentity_id?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- To get the register type and last session timestamp for a user            -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_USER_REGISTER_TYPE_AND_LAST_SESSION
	base_table=users
	sql=
	SELECT registertype, lastsession from users where users_id = ?users_id?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- To get the context start time by an activity ID                           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_CONTEXT_MGMT_STARTTIME_BY_ACTIVITY_ID
	base_table=ctxmgmt
	sql=
	SELECT starttime from ctxmgmt where activity_id= ?activity_id?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- To get context data by context name and activity ID                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_CONTEXT_DATA_BY_NAME_AND_ACTIVITY_ID
	base_table=ctxdata
	sql=
	SELECT servalue from ctxdata where name= ?name? and activity_id= ?activity_id?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!-- To get activity ID by user Id, caller Id, store Id and status             -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_ACTIVITY_ID_BY_USER_ID_CALLER_ID_STORE_ID_AND_STATUS
	base_table=ctxmgmt
	sql=
	SELECT activity_id from ctxmgmt where caller_id= ?caller_id? and runas_id= ?runas_id? and store_id= ?store_id? and status= ?status?
END_SQL_STATEMENT
<!-- ================================================================================================= -->
<!-- This SQL query will return records for Sterling Configurator MetaData from CSEDITATT  table.		   -->
<!-- ================================================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_GET_STERLING_CONFIGURATOR_METADATA_BY_STORE_ID
    base_table=CSEDITATT
	sql=
		SELECT 	
				CONNSPECATTNAME,
		   		CONNSPECATTVALUE,
		   		ACTIVE
	  	FROM 
	  			CSEDITATT,STORETRANS   
	  	WHERE 	
	  			CSEDITATT.STORE_ID IN (?STORE_ID?) AND
        		CONNSPECATTNAME IN (?CONNSPECATTNAME?) AND
        		STORETRANS.TRANSPORT_ID =(SELECT TRANSPORT_ID FROM TRANSPORT WHERE NAME='Configurator') AND
        		CSEDITATT.STORE_ID = STORETRANS.STORE_ID
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Get the store id where the category belongs to                           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_STORE_ID_FROM_STORECGRP
	base_table=storecgrp
	sql=
	SELECT STOREENT_ID FROM STORECGRP WHERE CATGROUP_ID=?catgroupId?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
	name=SELECT_STORE_ID_FROM_STORECGRP_WORKSPACE
	base_table=storecgrp
	sql=
	SELECT STOREENT_ID FROM $SCHEMA$.STORECGRP WHERE CATGROUP_ID=?catgroupId?
END_SQL_STATEMENT
<!-- ========================================================================= -->
<!--  Find organization for a member with organization participant role        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	<!-- Fetch active organization which the user play "Organization Participant" role in  -->
	name=IBM_GET_ORG_WITH_ORGANIZATION_PARTICIPANT_ROLE
	base_table=mbrrel 
	dbtype=any
	sql=
	SELECT  ORGENTITY_ID FROM MBRROLE   WHERE (MEMBER_ID = ?member_id?) AND (ROLE_ID IN (SELECT ROLE_ID FROM ROLE WHERE NAME = 'Organization Participant'))
END_SQL_STATEMENT
