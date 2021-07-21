## From 0.22 to 0.23

### Remove old migrations

delete from schema_migrations where version <= '20200713104602';
delete from schema_migrations where version >= '20201008072251' and version <= '20201008072290';
delete from schema_migrations where version >= '20210108094308' and version <= '20210108094344';
delete from schema_migrations where version >= '20210531114501';

### Copy new migrations

In db/schema_migrations.sql
