create database if not exists meta;
use meta;

CREATE TABLE IF NOT EXISTS cluster (
  anchor TINYINT NOT NULL,
  cluster_name VARCHAR(128) CHARSET ascii NOT NULL DEFAULT '',
  cluster_domain VARCHAR(128) CHARSET ascii NOT NULL DEFAULT '',
  PRIMARY KEY (anchor)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO cluster (anchor, cluster_name, cluster_domain) 
VALUES (1, CONCAT('cls_',@@hostname), @@hostname) 
ON DUPLICATE KEY UPDATE cluster_name=VALUES(cluster_name), cluster_domain=VALUES(cluster_domain);
