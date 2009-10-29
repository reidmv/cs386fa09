
CREATE SEQUENCE host_id_seq;
CREATE TABLE hosts (
  id       integer DEFAULT nextval('host_id_seq'::regclass) PRIMARY KEY,
  hostname varchar UNIQUE NOT NULL,
  building varchar,
  room     varchar,
  detail   varchar,
  owner    varchar,
  model    varchar,
  os       varchar);
ALTER TABLE host_id_seq OWNER TO netdb;
ALTER TABLE hosts OWNER TO netdb;

COMMENT ON TABLE  hosts IS 'Hosts, or network-addressable entities.';
COMMENT ON COLUMN hosts.hostname IS 'e.g. "asterisk".';
COMMENT ON COLUMN hosts.domain IS 'e.g. "kittenz.pdx.edu".';

CREATE SEQUENCE switch_id_seq;
CREATE TABLE switches (
  id      integer DEFAULT nextval('switch_id_seq'::regclass) PRIMARY KEY,
  host_id integer NOT NULL REFERENCES hosts);
ALTER TABLE switch_id_seq OWNER TO netdb;
ALTER TABLE switches OWNER TO netdb;

CREATE SEQUENCE port_id_seq;
CREATE TABLE ports (
  id      integer DEFAULT nextval('port_id_seq'::regclass) PRIMARY KEY,
  host_id integer REFERENCES hosts,
  label   varchar);
ALTER TABLE port_id_seq OWNER TO netdb;
ALTER TABLE ports OWNER TO netdb;

CREATE SEQUENCE vlan_id_seq;
CREATE TABLE vlans (
  id          integer DEFAULT nextval('vlan_id_seq'::regclass) PRIMARY KEY,
  description varchar,
  vlan_number integer NOT NULL);
ALTER TABLE vlan_id_seq OWNER TO netdb;
ALTER TABLE vlans OWNER TO netdb;

CREATE SEQUENCE wiring_id_seq;
CREATE TABLE wirings (
  id       integer DEFAULT nextval('wiring_id_seq'::regclass) PRIMARY KEY,
  port_id1 integer NOT NULL REFERENCES ports,
  port_id2 integer NOT NULL REFERENCES ports);
ALTER TABLE wiring_id_seq OWNER TO netdb;
ALTER TABLE wirings OWNER TO netdb;

CREATE SEQUENCE virtual_port_id_seq;
CREATE TABLE virtual_ports (
  id           integer DEFAULT nextval('virtual_port_id_seq'::regclass) PRIMARY KEY,
  virt_port_id integer NOT NULL REFERENCES ports,
  host_port_id integer NOT NULL REFERENCES ports);
ALTER TABLE virtual_port_id_seq OWNER TO netdb;
ALTER TABLE virtual_ports OWNER TO netdb;

CREATE SEQUENCE mac_addr_id_seq;
CREATE TABLE mac_addrs (
  id          integer DEFAULT nextval('mac_addr_id_seq'::regclass) PRIMARY KEY,
  port_id     integer NOT NULL REFERENCES ports,
  mac_address macaddr UNIQUE NOT NULL);
ALTER TABLE mac_addr_id_seq OWNER TO netdb;
ALTER TABLE mac_addrs OWNER TO netdb;

CREATE SEQUENCE ip_addr_id_seq;
CREATE TABLE ip_addrs (
  id          integer DEFAULT nextval('ip_addr_id_seq'::regclass) PRIMARY KEY,
  vlan_id     integer REFERENCES vlans,
  mac_addr_id integer REFERENCES mac_addrs,
  ip_address  inet UNIQUE NOT NULL); 
ALTER TABLE ip_addr_id_seq OWNER TO netdb;
ALTER TABLE ip_addrs OWNER TO netdb;

/*
GRANT ALL PRIVILEGES ON SEQUENCE 
  host_id_seq,
  ip_addr_id_seq,
  mac_addr_id_seq,
  port_id_seq,
  switch_id_seq,
  virtual_port_id_seq,
  vlan_id_seq,
  wiring_id_seq 
  TO netdb;

GRANT ALL PRIVILEGES ON TABLE 
  hosts,
  ip_addrs,
  mac_addrs,
  ports,
  switches,
  virtual_ports,
  vlans,
  wirings
  TO netdb;
*/
