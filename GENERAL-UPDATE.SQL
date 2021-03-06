create or replace PROCEDURE             "GENERAL_UPDATE" (TABLE_NAME IN OUT VARCHAR2, UPDATE_DATA VARCHAR2, TABLE_WHERE VARCHAR2) AS 
DATA_INSERT varchar2(2000);
BEGIN

    SELECT  REPLACE(UPDATE_DATA,'''SYSTIMESTAMP''','SYSTIMESTAMP')     --Agrega comillas simples a los datos, y en donde este un 'SYSTIMESTAMP', se coloca SYSTIMESTAMP
    INTO    DATA_INSERT                                                         
	FROM    DUAL;

    EXECUTE IMMEDIATE
			'
			UPDATE  '||TABLE_NAME||' 
            SET     '||DATA_INSERT||' 
            WHERE   '||TABLE_WHERE;

    TABLE_NAME:=1;
    DBMS_OUTPUT.PUT_LINE('TABLE_NAME: ' || TABLE_NAME);        
    COMMIT;

EXCEPTION
	WHEN OTHERS THEN


		dbms_output.put_line('ENTRE EN ERRORES ==> ERROR :'||SQLCODE||' -ERROR- '||SQLERRM);
		ROLLBACK;
        TABLE_NAME:=0;
        DBMS_OUTPUT.PUT_LINE('TABLE_NAME: ' || TABLE_NAME);

END GENERAL_UPDATE;

--Author @GVELASQUEZ
