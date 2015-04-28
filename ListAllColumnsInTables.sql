SELECT  C.TABLE_SCHEMA ,
		C.TABLE_NAME ,
		Rows ,
        COLUMN_NAME ,
        DATA_TYPE 
FROM    information_schema.columns C
        JOIN INFORMATION_SCHEMA.TABLES T ON C.TABLE_NAME COLLATE DATABASE_DEFAULT = T.TABLE_NAME COLLATE DATABASE_DEFAULT
        JOIN ( SELECT   o.name ,
                        rows
               FROM     sysindexes i
                        JOIN sysobjects o ON o.id = i.id
               WHERE    indid < 2
                        AND type = 'U' AND ISNULL(OBJECTPROPERTY(OBJECT_ID(o.Name),'IsMSShipped'),0)=0
             ) RC ON RC.name = T.TABLE_NAME
WHERE   T.TABLE_TYPE = 'BASE TABLE'
ORDER BY T.TABLE_NAME ,
        ordinal_position
