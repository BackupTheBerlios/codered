# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : codered_db
# ---------------------------------------

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
  `user_id` int(11) NOT NULL default '0',
  `client_name` varchar(50) NOT NULL default '',
  `client_strasse` varchar(50) NOT NULL default '',
  `client_plz` int(11) NOT NULL default '0',
  `client_ort` varchar(50) NOT NULL default '',
  `client_email` varchar(255) default NULL,
  `client_telefon` varchar(25) NOT NULL default '',
  `client_fax` varchar(25) NOT NULL default '',
  `client_pic` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Table structure for table `reports`
#

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `client_id` varchar(16) NOT NULL default '',
  `user_id` int(11) NOT NULL default '0',
  `datei` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
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
  `know_title` varchar(25) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `knows_users` table : 
#

DROP TABLE IF EXISTS `knows_users`;

CREATE TABLE `knows_users` (
  `know_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `tickets` table : 
#

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL auto_increment,
  `ticket_bezeichnung` varchar(150) NOT NULL default '',
  `ticket_beschreibung` text NOT NULL,
  `ticket_wichtigkeit` int(1) NOT NULL default '0',
  `betreuer_id` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `client_id` int(11) NOT NULL default '0',
  `ticket_status` tinyint(2) NOT NULL default '0',
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `users` table : 
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(50) NOT NULL default '',
  `user_vorname` varchar(25) NOT NULL default '',
  `user_strasse` varchar(50) NOT NULL default '',
  `user_plz` int(11) NOT NULL default '0',
  `user_ort` varchar(50) NOT NULL default '',
  `user_email` varchar(255) default NULL,
  `user_telefon` varchar(25) NOT NULL default '',
  `user_klasse` varchar(25) NOT NULL default '',
  `user_pic` varchar(255) default NULL,
  `user_rule` tinyint(4) NOT NULL default '5',
  `password` varchar(40) NOT NULL default '',
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `login` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `workflows` table : 
#

DROP TABLE IF EXISTS `workflows`;

CREATE TABLE `workflows` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `ticket_id` int(11) NOT NULL default '0',
  `workflow_text` longtext NOT NULL,
  `updated_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `grund` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `costs` table :
#
# Vorlaeufig. Pruefen, ob das so funktioniert.
#

DROP TABLE IF EXISTS `costs`;

CREATE TABLE `costs` (
  `id` int(11) NOT NULL auto_increment,
  `euro_per_km` decimal(6,2) NOT NULL default '0.00',
  `euro_per_hour` decimal(6,2) NOT NULL default '0.00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `missions` table : 
#
# Ebenfalls Vorlaeufig...
#

DROP TABLE IF EXISTS `missions`;

CREATE TABLE `missions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time_leavetotarget` time NOT NULL,
  `time_reachtarget` time NOT NULL,
  `time_leavetohome` time NOT NULL,
  `time_reachhome` time NOT NULL,
  `km_totarget` int(11) NOT NULL,
  `km_tohome` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

