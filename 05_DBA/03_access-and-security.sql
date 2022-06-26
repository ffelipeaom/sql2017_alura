
SELECT * FROM MASTER.SYS.sql_logins

SELECT NAME, LOGINPROPERTY(NAME, 'PasswordLastSetTime') FROM MASTER.SYS.sql_logins

CREATE LOGIN pedro WITH PASSWORD = 'pedro'

SELECT SERVERPROPERTY('DESKTOP-L41BHHJ') AS SERVER_NAME,
 NAME AS LOGIN_NAME FROM MASTER.SYS.sql_logins
 WHERE PWDCOMPARE(NAME, password_hash) = 1

 ALTER SERVER ROLE [dbcreator] ADD MEMBER [pedro]
 ALTER SERVER ROLE [dbcreator] DROP MEMBER [pedro]

 SELECT * FROM SYS.fn_builtin_permissions('') WHERE CLASS_DESC = 'SERVER'

 USE SUCOS_VENDAS
 CREATE LOGIN jorge WITH PASSWORD = 'jorge@123'
 CREATE USER jorge FOR LOGIN jorge

 USE SUCOS_VENDAS
 EXEC sp_addrolemember 'db_datareader', 'jorge'
 EXEC sp_addrolemember 'db_datawriter', 'jorge'
