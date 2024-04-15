CREATE USER [swaappuser] WITH PASSWORD = 'BostonScientific@123';

ALTER ROLE db_datareader ADD MEMBER [swaappuser];
ALTER ROLE db_datawriter ADD MEMBER [swaappuser];
GRANT EXECUTE ON SCHEMA::dbo TO [swaappuser];

GRANT EXECUTE ANY EXTERNAL ENDPOINT TO [swaappuser];