<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2010                                      -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->


<!-- ========================================================================= -->
<!-- Get all the languages on the server                                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_ALL_LANGUAGE
	base_table=language
	sql=
	SELECT language_id,localename from language
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Get all the stores on the server                                          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_ALL_STORE
	base_table=store
	sql=
	SELECT store_id, directory from store
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!-- Get all the currencies on the server                                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IBM_ALL_CURRENCY
	base_table=curlist
	sql=
	SELECT distinct currstr from curlist
END_SQL_STATEMENT

