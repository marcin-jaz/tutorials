BEGIN_SQL_STATEMENT
  base_table=PREVIEWTOKEN
  name=INSERT_PREVIEWTOKEN
  sql=INSERT INTO PREVIEWTOKEN (PREVIEWTOKEN_ID, STOREENT_ID, USERS_ID, STARTDATE, ENDDATE, STATUS, PASSWORD, SALT, CTXDATA, PROPERTIES, OPTCOUNTER)
  VALUES (?PREVIEWTOKEN_ID?, ?STOREENT_ID?, ?USERS_ID?, ?STARTDATE?, ?ENDDATE?, ?STATUS?, ?PASSWORD?, ?SALT?, ?CTXDATA?, ?PROPERTIES?, 0)
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
  base_table=PREVIEWTOKEN
  name=SELECT_PREVIEWTOKEN_BY_ID
  sql=SELECT * FROM PREVIEWTOKEN WHERE PREVIEWTOKEN_ID = ?PREVIEWTOKEN_ID?
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
  base_table=PREVIEWTOKEN
  name=SELECT_VALID_PREVIEWTOKEN_BY_ID
  dbtype=db2
  sql=SELECT * FROM PREVIEWTOKEN WHERE PREVIEWTOKEN_ID = ?PREVIEWTOKEN_ID? AND STARTDATE <= CURRENT TIMESTAMP AND ENDDATE > CURRENT TIMESTAMP AND STATUS = 'A'
  dbtype=any
  sql=SELECT * FROM PREVIEWTOKEN WHERE PREVIEWTOKEN_ID = ?PREVIEWTOKEN_ID? AND STARTDATE <= CURRENT_TIMESTAMP AND ENDDATE > CURRENT_TIMESTAMP AND STATUS = 'A'
END_SQL_STATEMENT

BEGIN_SQL_STATEMENT
  base_table=PREVIEWTOKEN
  name=UPDATE_PREVIEWTOKEN_STATUS
  sql=UPDATE PREVIEWTOKEN SET STATUS=?STATUS? WHERE PREVIEWTOKEN_ID = ?PREVIEWTOKEN_ID?
END_SQL_STATEMENT