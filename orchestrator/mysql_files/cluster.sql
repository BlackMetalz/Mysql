--
-- This is a suggestion for Pseudo-GTID injection and configuration.
-- The Pseudo-GTID injected here is using both DDL & DML. This includes:
-- - Generation of `meta` schema
-- - Generation of `pseudo_gtid_status` table
-- - Generation of `create_pseudo_gtid_event` event (executes every 5 second)
-- - Enabling of event_scheduler (you will need to make sure you have "event_scheduler=1" in my.cnf)
--
-- replace "meta" with any other schema you prefer


--
--  The following to be added to orchestrator.conf.json
--
--  "PseudoGTIDPattern": "drop view if exists .*?`_pseudo_gtid_hint__",
--  "PseudoGTIDMonotonicHint": "asc:",
--  "DetectPseudoGTIDQuery": "select count(*) as pseudo_gtid_exists from meta.pseudo_gtid_status where anchor = 1 and time_generated > now() - interval 2 day",
--


create database if not exists meta;
use meta;

CREATE TABLE IF NOT EXISTS cluster (
  anchor TINYINT NOT NULL,
  cluster_name VARCHAR(128) CHARSET ascii NOT NULL DEFAULT '',
  cluster_domain VARCHAR(128) CHARSET ascii NOT NULL DEFAULT '',
  PRIMARY KEY (anchor)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
