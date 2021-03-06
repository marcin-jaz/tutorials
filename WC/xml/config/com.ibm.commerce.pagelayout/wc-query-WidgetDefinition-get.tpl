BEGIN_SYMBOL_DEFINITIONS
	
	<!-- The table for noun WidgetDefinition  -->
	
	    <!-- PLWIDGETDEF table -->
		<!-- Defining all columns of the table -->
		COLS:PLWIDGETDEF = PLWIDGETDEF:* 	
		COLS:PLWIDGETDEF:PLWIDGETDEF_ID = PLWIDGETDEF:PLWIDGETDEF_ID
		COLS:PLWIDGETDEF:IDENTIFIER = PLWIDGETDEF:IDENTIFIER
		COLS:PLWIDGETDEF:STOREENT_ID = PLWIDGETDEF:STOREENT_ID
		COLS:PLWIDGETDEF:WIDGETTYPE = PLWIDGETDEF:WIDGETTYPE
		COLS:PLWIDGETDEF:UI_OBJECT_NAME=PLWIDGETDEF:UI_OBJECT_NAME
		COLS:PLWIDGETDEF:STATE = PLWIDGETDEF:STATE
		COLS:PLWIDGETDEF:VENDOR = PLWIDGETDEF:VENDOR
		COLS:PLWIDGETDEF:JSPPATH = PLWIDGETDEF:JSPPATH
		COLS:PLWIDGETDEF:DEFINITIONXML = PLWIDGETDEF:DEFINITIONXML
		COLS:PLWIDGETDEF:CREATEDATE = PLWIDGETDEF:CREATEDATE
		COLS:PLWIDGETDEF:LASTUPDATE = PLWIDGETDEF:LASTUPDATE
		
		<!-- PLWIDGETDEFDESC table -->
		COLS:PLWIDGETDEFDESC = PLWIDGETDEFDESC:*
		COLS:PLWIDGETDEFDESC:PLWIDGETDEF_ID = PLWIDGETDEFDESC:PLWIDGETDEF_ID
		COLS:DISPLAYNAME = PLWIDGETDEFDESC:DISPLAYNAME
		COLS:DESCRIPTION = PLWIDGETDEFDESC:DESCRIPTION
		COLS:LANGUAGE_ID = PLWIDGETDEFDESC:LANGUAGE_ID
		
		<!-- PLSTOREWIDGET table -->
		COLS:PLSTOREWIDGET = PLSTOREWIDGET:*
		COLS:PLSTOREWIDGET_ID = PLSTOREWIDGET:PLSTOREWIDGET_ID
		COLS:STOREENT_ID = PLSTOREWIDGET:STOREENT_ID
		COLS:PLWIDGETDEF_ID = PLSTOREWIDGET:PLWIDGETDEF_ID
		COLS:STATE = PLSTOREWIDGET:STATE
		
		
END_SYMBOL_DEFINITIONS

<!-- ============================================================== -->
<!-- This query fetches the widget definitions applicable for the store.-->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition
	base_table=PLWIDGETDEF
	sql=
			SELECT 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$ 	     			
	     	FROM
	     				PLWIDGETDEF		
	     				JOIN PLSTOREWIDGET ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID)			               
					              
			WHERE
					PLSTOREWIDGET.STATE = 1 AND
					PLSTOREWIDGET.STOREENT_ID in ($STOREPATH:view$)		
END_XPATH_TO_SQL_STATEMENT

<!-- ================================================================================================= -->
<!-- This query fetches the widget definitions that applicable for the store with specific widget type.-->
<!-- @param WidgetType The type of the widget definition                                               -->
<!-- ================================================================================================= -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetType=]
	base_table=PLWIDGETDEF
	sql=
			SELECT 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$ 	     			
	     	FROM
	     				PLWIDGETDEF		
	     				JOIN PLSTOREWIDGET ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID)
	     				LEFT OUTER JOIN PLWIDGETDEFDESC ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLWIDGETDEFDESC.PLWIDGETDEF_ID AND PLWIDGETDEFDESC.LANGUAGE_ID IN ($CONTROL:LANGUAGES$))			               
					              
			WHERE
					PLWIDGETDEF.WIDGETTYPE = ?WidgetType? AND
					PLSTOREWIDGET.STATE = 1 AND
					PLSTOREWIDGET.STOREENT_ID in ($STOREPATH:view$)
			ORDER BY 
				    PLWIDGETDEFDESC.DISPLAYNAME	
END_XPATH_TO_SQL_STATEMENT

<!-- ============================================================== -->
<!-- This query fetches the widget definition based on the unique ID--> 
<!-- specified.														-->
<!-- @param UniqueID The unique ID of the widget definition         -->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetDefinitionIdentifier[(UniqueID=)]]	
	base_table=PLWIDGETDEF
	sql=
			SELECT 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$ 	     			
	     	FROM
	     				PLWIDGETDEF		    
	     				JOIN PLSTOREWIDGET ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID)          
			WHERE
			        PLWIDGETDEF.PLWIDGETDEF_ID IN (?UniqueID?) AND
			        PLWIDGETDEF.STATE = 1 AND PLSTOREWIDGET.STATE = 1
END_XPATH_TO_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- This query is used for caching the widget definition based on UniqueID.   -->
<!-- The query does not make use of contextual 								   --> 
<!-- information. The query is tied to IBM_Store_Summary access profile. -->
<!-- This profile returns the following info:                 		-->
<!-- PLWIDGETDEF						                    		-->
<!-- 	1) PLWIDGETDEF_ID						                    -->
<!-- 	2) STOREENT_ID							                    -->
<!-- 	3) IDENTIFIER							                    -->
<!-- 	4) WIDGETTYPE							                    -->
<!-- 	5) JSPPATH							                   		-->
<!-- 	6) DEFINITIONXML					                   		-->
<!-- 	6) DEFINITIONXML					                   		-->
<!-- PLSTOREWIDGET						                    		-->
<!-- 	All columns								                    -->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetDefinitionIdentifier[UniqueID=] and SubscribingStoreId=]+IBM_Store_Summary	
	base_table=PLWIDGETDEF
	sql=
			SELECT 	     
			            PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$,				 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:JSPPATH$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$,
	     				PLSTOREWIDGET.$COLS:PLSTOREWIDGET$	     				 
	     	FROM
	     				PLWIDGETDEF, PLSTOREWIDGET  
			WHERE
			        PLWIDGETDEF.PLWIDGETDEF_ID IN (?UniqueID?) AND
			        PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID
			        AND PLSTOREWIDGET.STOREENT_ID = ?SubscribingStoreId?
			        AND PLSTOREWIDGET.STATE = 1
END_XPATH_TO_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- This query is used for caching the widget definition based on Identifier  --> 
<!-- and store Id specified..   -->
<!-- The query does not make use of contextual 								   --> 
<!-- information. The query is tied to IBM_Store_Summary access profile. -->
<!-- This profile returns the following info:                 		-->
<!-- PLWIDGETDEF						                    		-->
<!-- 	1) PLWIDGETDEF_ID						                    -->
<!-- 	2) STOREENT_ID							                    -->
<!-- 	3) IDENTIFIER							                    -->
<!-- 	4) WIDGETTYPE							                    -->
<!-- 	5) JSPPATH							                   		-->
<!-- 	6) DEFINITIONXML					                   		-->
<!-- PLSTOREWIDGET						                    		-->
<!-- 	All columns								                    -->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetDefinitionIdentifier[WidgetDefinitionExternalIdentifier[Identifier= and StoreIdentifier[UniqueID=]]] and SubscribingStoreId=]+IBM_Store_Summary	
	base_table=PLWIDGETDEF
	sql=
			SELECT 	     
			            PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$,				 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:JSPPATH$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$,
	     				PLSTOREWIDGET.$COLS:PLSTOREWIDGET$	     				 
	     	FROM
	     				PLWIDGETDEF, PLSTOREWIDGET  
			WHERE
			        PLWIDGETDEF.IDENTIFIER = ?Identifier? AND
			        PLWIDGETDEF.STOREENT_ID = ?UniqueID? AND 
			        PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID
			        AND PLSTOREWIDGET.STOREENT_ID = ?SubscribingStoreId?
			        AND PLSTOREWIDGET.STATE = 1
END_XPATH_TO_SQL_STATEMENT

<!-- ============================================================== -->
<!-- This query is used to fetch widget definition based on identifier specified.-->
<!-- The query is not used for caching. This profile returns the following info: -->
<!-- PLWIDGETDEF						                    		-->
<!-- 	1) PLWIDGETDEF_ID						                    -->
<!-- 	2) STOREENT_ID							                    -->
<!-- 	3) IDENTIFIER							                    -->
<!-- 	4) WIDGETTYPE							                    -->
<!-- 	5) JSPPATH							                   		-->
<!-- 	6) DEFINITIONXML					                   		-->
<!-- PLSTOREWIDGET						                    		-->
<!-- 	All columns								                    -->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetDefinitionIdentifier[WidgetDefinitionExternalIdentifier[(Identifier=)]]]+IBM_Store_Summary	
	base_table=PLWIDGETDEF
	sql=
			SELECT 	     
			            PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$,				 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:JSPPATH$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$,
	     				PLSTOREWIDGET.$COLS:PLSTOREWIDGET$	     				 
	     	FROM
	     				PLWIDGETDEF, PLSTOREWIDGET  
			WHERE
			        PLWIDGETDEF.IDENTIFIER IN (?Identifier?) AND
			        PLWIDGETDEF.STOREENT_ID IN ($STOREPATH:view$) AND
			        PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID
			        AND PLSTOREWIDGET.STOREENT_ID IN ($STOREPATH:view$)
			        AND PLSTOREWIDGET.STATE = 1
END_XPATH_TO_SQL_STATEMENT

<!-- ============================================================== -->
<!-- This query is used to fetch widget definition based on uniqueID specified.-->
<!-- The query is not used for caching. This profile returns the following info: -->
<!-- This profile returns the following info:                 		-->
<!-- PLWIDGETDEF						                    		-->
<!-- 	1) PLWIDGETDEF_ID						                    -->
<!-- 	2) STOREENT_ID							                    -->
<!-- 	3) IDENTIFIER							                    -->
<!-- 	4) WIDGETTYPE							                    -->
<!-- 	5) JSPPATH							                   		-->
<!-- 	6) DEFINITIONXML					                   		-->
<!-- PLSTOREWIDGET						                    		-->
<!-- 	All columns								                    -->
<!-- ============================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/WidgetDefinition[WidgetDefinitionIdentifier[(UniqueID=)]]+IBM_Store_Summary	
	base_table=PLWIDGETDEF
	sql=
			SELECT 	     
			            PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$,				 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:JSPPATH$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$,
	     				PLSTOREWIDGET.$COLS:PLSTOREWIDGET$	     				 
	     	FROM
	     				PLWIDGETDEF, PLSTOREWIDGET  
			WHERE
			        PLWIDGETDEF.PLWIDGETDEF_ID IN (?UniqueID?) AND
			        PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID
			        AND PLSTOREWIDGET.STOREENT_ID IN ($STOREPATH:view$)
			        AND PLSTOREWIDGET.STATE = 1
END_XPATH_TO_SQL_STATEMENT

<!-- 
The xpath /WidgetDefinition
The access profile IBM_Admin_Summary 
/WidgetIdentifier/UniqueID
/WidgetIdentifier/ExternalIdentifier/Identifier
/WidgetIdentifier/ExternalIdentifier/StoreIdentifier/UniqueID
/WidgetType
/State
/Description ( /DisplayName, /Description, @language based on the datalanguageIds parameter)
TODO association SQL should not do join on PLSTOREWIDGET... should be done in XPATH TO SQL 
-->

BEGIN_ASSOCIATION_SQL_STATEMENT
	name=IBM_WidgetDefinition_Admin_Summary
	base_table=PLWIDGETDEF
	sql=
			SELECT 	     
			            PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$,				 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$, 
	     				PLWIDGETDEFDESC.$COLS:DISPLAYNAME$,
	     				PLWIDGETDEFDESC.$COLS:DESCRIPTION$,
	     				PLWIDGETDEFDESC.$COLS:LANGUAGE_ID$,
	     				PLWIDGETDEFDESC.$COLS:PLWIDGETDEFDESC:PLWIDGETDEF_ID$
	     	FROM
	     				PLWIDGETDEF					               
					               JOIN PLSTOREWIDGET ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID)
					               LEFT OUTER JOIN PLWIDGETDEFDESC ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLWIDGETDEFDESC.PLWIDGETDEF_ID AND PLWIDGETDEFDESC.LANGUAGE_ID IN ($CONTROL:LANGUAGES$))
					               
					
			WHERE
					PLWIDGETDEF.PLWIDGETDEF_ID IN ($ENTITY_PKS$) AND
					PLSTOREWIDGET.STATE=1 AND
					PLSTOREWIDGET.STOREENT_ID in ($STOREPATH:view$)		
END_ASSOCIATION_SQL_STATEMENT



<!--
IBM_Admin_Summary
+
/Vendor
/Path
/DefinitionXML
/ConfigurableSlot (/InternalSlotId, /PositionProperty, /SlotType, /AllottedWidget)
/LastUpdate
/CreatedDate
/WidgetProperty
TODO association SQL should not do join on PLSTOREWIDGET... should be done in XPATH TO SQL 
-->

BEGIN_ASSOCIATION_SQL_STATEMENT
	name=IBM_WidgetDefinition_Admin_All
	base_table=PLWIDGETDEF
	sql=
			SELECT 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:PLWIDGETDEF_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:IDENTIFIER$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STOREENT_ID$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:WIDGETTYPE$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:UI_OBJECT_NAME$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:STATE$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:VENDOR$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:JSPPATH$,
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:DEFINITIONXML$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:CREATEDATE$, 
	     				PLWIDGETDEF.$COLS:PLWIDGETDEF:LASTUPDATE$, 
	     				PLWIDGETDEFDESC.$COLS:DISPLAYNAME$,
	     				PLWIDGETDEFDESC.$COLS:DESCRIPTION$,
	     				PLWIDGETDEFDESC.$COLS:LANGUAGE_ID$,
	     				PLWIDGETDEFDESC.$COLS:PLWIDGETDEFDESC:PLWIDGETDEF_ID$
	     	FROM
	     				PLWIDGETDEF					               
					               JOIN PLSTOREWIDGET ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLSTOREWIDGET.PLWIDGETDEF_ID)
					               LEFT OUTER JOIN PLWIDGETDEFDESC ON (PLWIDGETDEF.PLWIDGETDEF_ID = PLWIDGETDEFDESC.PLWIDGETDEF_ID AND PLWIDGETDEFDESC.LANGUAGE_ID IN ($CONTROL:LANGUAGES$))					               
					               
					
			WHERE
			        PLWIDGETDEF.PLWIDGETDEF_ID IN ($ENTITY_PKS$) AND
					PLSTOREWIDGET.STATE=1 AND
					PLSTOREWIDGET.STOREENT_ID in ($STOREPATH:view$)	
END_ASSOCIATION_SQL_STATEMENT


<!-- ========================================================= -->
<!-- WidgetDefinition All Access Profile. This access     -->
<!-- profile is used to get the information for the      -->
<!-- widgets subscribed to a store.												       -->
<!-- This profile returns the following info:                  -->
<!-- 	1) WidgetDefinition information	                       -->
<!-- ========================================================= -->
BEGIN_PROFILE
  name=IBM_Admin_All
  BEGIN_ENTITY
    base_table=PLWIDGETDEF
    associated_sql_statement=IBM_WidgetDefinition_Admin_All
  END_ENTITY
END_PROFILE

<!-- ========================================================= -->
<!-- WidgetDefinition Summary Access Profile. This access     -->
<!-- profile is used to get the information for the      -->
<!-- widgets subscribed to a store.												       -->
<!-- This profile returns the following info:                  -->
<!-- 	1) WidgetDefinition summary information	                       -->
<!-- ========================================================= -->
BEGIN_PROFILE
  name=IBM_Admin_Summary
  BEGIN_ENTITY
    base_table=PLWIDGETDEF
    associated_sql_statement=IBM_WidgetDefinition_Admin_Summary
  END_ENTITY
END_PROFILE    
