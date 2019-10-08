-- CA Technologies
-- Database data for MAG
--
-- run this command on command line to create the Cassandra schema: cqlsh -k <keyspace> -f <this-file-name>.cql
--
-- MAG Manager:
INSERT INTO oauth_client (client_ident, name, description, organization, registered_by, type, created, custom)
VALUES ('18661300-45df-4cdc-826f-23e402275463', 'MAG Manager', 'MAG Manager is used to manage registered devices', 'CA Technologies', 'admin', 'confidential', unixTimestampOf(now()), '{}');

INSERT INTO oauth_client_name (client_ident, name, organization)
VALUES ('18661300-45df-4cdc-826f-23e402275463', 'MAG Manager', 'CA Technologies');

INSERT INTO oauth_client_org (client_ident, organization)
VALUES ('18661300-45df-4cdc-826f-23e402275463', 'CA Technologies');

-- Credentials for MAG Manager:
INSERT INTO oauth_client_key (client_key, secret, status, created_by, client_ident, callback, scope, environment, created, custom, master)
VALUES ('18661300-45df-4cdc-826f-23e402275463', '171f6a0b-deee-44a9-89fe-8dda80b67cba', 'ENABLED', 'admin', '18661300-45df-4cdc-826f-23e402275463', 'YOUR_SSG/mag/manager', 'openid profile email user_role', 'MAGServer', unixTimestampOf(now()), '{}', 0);

INSERT INTO oauth_client_key_user (client_key, created_by, client_ident)
VALUES ('18661300-45df-4cdc-826f-23e402275463', 'admin', '18661300-45df-4cdc-826f-23e402275463');

-- OAuth Server to support 'local' social login:
INSERT INTO oauth_client (client_ident, name, description, organization, registered_by, type, created, custom)
VALUES ('c716ac35-ae5b-4870-bfa1-5530c65952f9', 'MAG Authorization Server', 'Used to support social login via the MAG', 'CA Technologies', 'admin', 'confidential', unixTimestampOf(now()), '{}');

INSERT INTO oauth_client_name (client_ident, name, organization)
VALUES ('c716ac35-ae5b-4870-bfa1-5530c65952f9', 'MAG Authorization Server', 'CA Technologies');

INSERT INTO oauth_client_org (client_ident, organization)
VALUES ('c716ac35-ae5b-4870-bfa1-5530c65952f9', 'CA Technologies');

-- Credentials for OAuth Server to support 'local' social login:
INSERT INTO oauth_client_key (client_key, secret, expiration, status, created, created_by, client_ident, callback, scope, environment, custom, master)
VALUES ('c716ac35-ae5b-4870-bfa1-5530c65952f9', '269957e2-5bc0-4a59-b0b5-c37e88460159', 0, 'ENABLED', unixTimestampOf(now()), 'admin', 'c716ac35-ae5b-4870-bfa1-5530c65952f9', 'YOUR_SSG/auth/oauth/v2/authorize/login?action=login&provider=enterprise', 'openid profile email', 'MAGServer', '{}', 0);

INSERT INTO oauth_client_key_user (client_key, created_by, client_ident)
VALUES ('c716ac35-ae5b-4870-bfa1-5530c65952f9', 'admin', 'c716ac35-ae5b-4870-bfa1-5530c65952f9');
