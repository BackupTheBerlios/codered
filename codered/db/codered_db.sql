# Marco VIM Tabellen layout  :)
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

CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `client_name` varchar(50) NOT NULL,
  `client_strasse` varchar(25) NOT NULL,
  `client_plz` int(11) NOT NULL,
  `client_ort` varchar(25) NOT NULL,
  `client_email` varchar(25) NOT NULL,
  `client_telefon` varchar(25) NOT NULL,
  `client_fax` varchar(25) NOT NULL,
  `client_pic` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `files` table : 
#

CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `client_id` varchar(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `datei` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tickets` table : 
#

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL auto_increment,
  `ticket_bezeichnung` varchar(150) NOT NULL,
  `ticket_beschreibung` text NOT NULL,
  `ticket_wichtigkeit` int(1) NOT NULL,
  `betreuer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `ticket_status` tinyint(2) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `users` table : 
#

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(16) NOT NULL,
  `user_vorname` varchar(16) NOT NULL,
  `user_strasse` varchar(25) NOT NULL,
  `user_plz` int(11) NOT NULL,
  `user_ort` varchar(25) NOT NULL,
  `user_email` varchar(25) NOT NULL,
  `user_telefon` varchar(25) NOT NULL,
  `user_klasse` varchar(7) NOT NULL,
  `user_pic` varchar(255) default NULL,
  `user_rule` tinyint(4) NOT NULL default '5',
  `password` varchar(40) NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `login` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `workflows` table : 
#

CREATE TABLE `workflows` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `workflow_text` longtext NOT NULL,
  `updated_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `grund` tinyint(2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

