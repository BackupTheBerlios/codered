# EMS MySQL Manager Pro 3.4.0.4
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : codered_db


SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `codered_db`;

CREATE DATABASE `codered_db`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `codered_db`;

#
# Structure for the `clients` table : 
#

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `client_name` varchar(16) NOT NULL,
  `client_vorname` varchar(16) NOT NULL,
  `client_strasse` varchar(25) NOT NULL,
  `client_plz` int(11) NOT NULL,
  `client_ort` varchar(25) NOT NULL,
  `client_pic` varchar(255) default NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `knows` table : 
#

DROP TABLE IF EXISTS `knows`;

CREATE TABLE `knows` (
  `id` int(11) NOT NULL auto_increment,
  `know_titel` varchar(25) NOT NULL,
  `know_text` text NOT NULL,
  `icon_ena` varchar(255) default NULL,
  `icon_disa` varchar(255) default NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `knows_to_users` table : 
#

DROP TABLE IF EXISTS `knows_to_users`;

CREATE TABLE `knows_to_users` (
  `id` int(11) NOT NULL auto_increment,
  `user_know_id` tinyint(4) NOT NULL,
  `know_id` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tickets` table : 
#

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL auto_increment,
  `ticket_bezeichnung` varchar(150) NOT NULL,
  `ticket_beschreibung` text NOT NULL,
  `ticket_wichtigkeit_id` int(1) NOT NULL,
  `ticket_betreuer_id` int(11) NOT NULL,
  `ticket_status` tinyint(1) NOT NULL,
  `ticket_client_id` int(11) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tickets_to_workflows` table : 
#

DROP TABLE IF EXISTS `tickets_to_workflows`;

CREATE TABLE `tickets_to_workflows` (
  `id` int(11) NOT NULL auto_increment,
  `ticket_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `users` table : 
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(16) NOT NULL,
  `user_vorname` varchar(16) NOT NULL,
  `user_strasse` varchar(25) NOT NULL,
  `user_plz` int(11) NOT NULL,
  `user_ort` varchar(25) NOT NULL,
  `user_klasse` varchar(7) NOT NULL,
  `user_rule` tinyint(4) NOT NULL,
  `user_passphrase` varchar(16) NOT NULL,
  `user_pic` varchar(255) default NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `workflows` table : 
#

DROP TABLE IF EXISTS `workflows`;

CREATE TABLE `workflows` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `workflow_text` text NOT NULL,
  `updated_on` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

