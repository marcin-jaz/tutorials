BEGIN_SYMBOL_DEFINITIONS
	<!-- INVCNF table -->
	COLS:INVCNF=INVCNF:*

	<!-- INVCNFREL table -->
	COLS:INVCNFREL=INVCNFREL:*

	<!-- INVAVL table -->
	COLS:INVAVL=INVAVL:*

END_SYMBOL_DEFINITIONS

<!-- ============================================================= -->
<!-- This SQL will return all the inventory configuration .        -->
<!-- The access profiles that apply to this SQL are:               -->
<!-- IBM_Details_All                                               -->
<!-- ============================================================= -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/InventoryConfiguration+IBM_Details_All
	base_table=INVCNF
	sql=
		SELECT 
				INVCNF.$COLS:INVCNF$, INVCNFREL.$COLS:INVCNFREL$
		FROM
				INVCNF, INVCNFREL
		WHERE
				INVCNF.INVCNF_ID=INVCNFREL.INVCNF_ID
						
END_XPATH_TO_SQL_STATEMENT
