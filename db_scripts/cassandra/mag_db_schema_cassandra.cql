-- CA Technologies
-- Cassandra schema for MAG
--
-- run this command on command line to create the Cassandra schema: cqlsh -k <keyspace> -f <this-file-name>.cql
--
CREATE TABLE mag_msso_device (
  magidentifier varchar,
  username varchar,                // The username who registered this device
  deviceid varchar,
  devicename varchar,
  devicestatus varchar,
  certdn varchar,                  // The complete DN of the cert
  created bigint,
  updated bigint,
  multiuser varchar,               // indicates whether this device provides multiuser support
  csr_base64 varchar,                        // the certificate signing request used when device first registered
  signed_cert_base64 varchar,      // the currently active base64 encoded ca_msso signed cert
  grace_expiration bigint,         // This is the grace expiry date of the device certificate, it is calculated based on certificate expiry + configured accept_expiry time period
  PRIMARY KEY (magidentifier)
);
CREATE INDEX ON mag_msso_device (devicestatus);

-- Holds a list of all devices and their clients. Used with MAG Manager
-- In SQL based database schemas this table does not exist but mag_device_app instead
CREATE TABLE mag_msso_device_overview (
  magidentifier varchar,
  username varchar,
  devicename varchar,
  devicestatus varchar,
  certdn varchar,
  created bigint,
  deviceid varchar,
  updated bigint,
  multiuser varchar,
  client_key varchar,
  access_token varchar,
  csr_base64 varchar,
  signed_cert_base64 varchar,
  grace_expiration bigint,
  PRIMARY KEY (magidentifier, client_key)
);

-- Used to keep track of all devices per user
CREATE TABLE mag_msso_device_user (
	username varchar,
	magidentifier varchar,
	PRIMARY KEY (username, magidentifier)
);

-- Used to keep DN unique
CREATE TABLE mag_msso_device_certdn (
  certdn varchar PRIMARY KEY,
  magidentifier varchar
);

-- Used to keep deviceID unique
CREATE TABLE mag_msso_device_deviceid (
  deviceid varchar PRIMARY KEY,
  magidentifier varchar
);

-- Used for several queries mainly with MAG Manager
CREATE TABLE mag_msso_device_username_view (
 magidentifier varchar,
  username varchar,                // The username who registered this device
  deviceid varchar,
  devicename varchar,
  devicestatus varchar,
  certdn varchar,                  // The complete DN of the cert
  created bigint,
  updated bigint,
  multiuser varchar,          // indicates whether this device provides multiuser support
    csr_base64 varchar,
    signed_cert_base64 varchar,
    grace_expiration bigint,
  PRIMARY KEY (username, deviceid, devicename)
);
-- Used to lookup a device - app mapping by access_token
CREATE TABLE mag_msso_device_overview_token (
  magidentifier varchar,
  client_key varchar,
  access_token varchar,
  PRIMARY KEY (access_token)
);

CREATE TABLE mag_version (
  current_version varchar,
  PRIMARY KEY (current_version)
);
INSERT INTO mag_version (current_version) VALUES ('mag4.2.00');

-- used with MAG OTP
CREATE TABLE mag_otp_records (
  user_id varchar,
  otp varchar,
  retry_count int,
  expiration_time bigint,
  next_allowed_time bigint ,
  created bigint,
  PRIMARY KEY (user_id)
);

create index uidx on mag_otp_records(otp);

--
-- Adding a table to support MAG device metadata
--
create table mag_msso_device_metadata (
    magidentifier varchar,
    name varchar,
    value varchar,
    PRIMARY KEY (magidentifier, name)
);