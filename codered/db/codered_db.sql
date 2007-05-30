-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-2ubuntu1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Erstellungszeit: 30. Mai 2007 um 19:17
-- Server Version: 5.0.38
-- PHP-Version: 5.2.1
-- 
-- Datenbank: `codered_db`
-- 

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `clients`
-- 

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `costs`
-- 

CREATE TABLE `costs` (
  `id` int(11) NOT NULL auto_increment,
  `euro_per_km` decimal(6,2) NOT NULL default '0.00',
  `euro_per_hour` decimal(6,2) NOT NULL default '0.00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `jobs`
-- 

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL auto_increment,
  `job_title` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `jobs_users`
-- 

CREATE TABLE `jobs_users` (
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `knows`
-- 

CREATE TABLE `knows` (
  `id` int(11) NOT NULL auto_increment,
  `know_title` varchar(25) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `knows_users`
-- 

CREATE TABLE `knows_users` (
  `know_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `missions`
-- 

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `reports`
-- 

CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `client_id` varchar(16) NOT NULL default '',
  `user_id` int(11) NOT NULL default '0',
  `datei` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `tickets`
-- 

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `users`
-- 

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Tabellenstruktur für Tabelle `workflows`
-- 

CREATE TABLE `workflows` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `ticket_id` int(11) NOT NULL default '0',
  `workflow_text` longtext NOT NULL,
  `updated_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `grund` tinyint(2) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;
