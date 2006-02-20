-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	4.1.12-Debian_1ubuntu3.1-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema codered_db
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ codered_db;
USE codered_db;

--
-- Table structure for table `codered_db`.`clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `client_name` varchar(50) NOT NULL default '',
  `client_strasse` varchar(25) NOT NULL default '',
  `client_plz` int(11) NOT NULL default '0',
  `client_ort` varchar(25) NOT NULL default '',
  `client_email` varchar(25) NOT NULL default '',
  `client_telefon` varchar(25) NOT NULL default '',
  `client_fax` varchar(25) NOT NULL default '',
  `client_pic` varchar(255) default NULL,
  `beschreibung` text NOT NULL,
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `codered_db`.`reports`
--

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

--
-- Table structure for table `codered_db`.`tickets`
--

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

--
-- Table structure for table `codered_db`.`users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(16) NOT NULL default '',
  `user_vorname` varchar(16) NOT NULL default '',
  `user_strasse` varchar(25) NOT NULL default '',
  `user_plz` int(11) NOT NULL default '0',
  `user_ort` varchar(25) NOT NULL default '',
  `user_email` varchar(25) NOT NULL default '',
  `user_telefon` varchar(25) NOT NULL default '',
  `user_klasse` varchar(7) NOT NULL default '',
  `user_pic` varchar(255) default NULL,
  `user_rule` tinyint(4) NOT NULL default '5',
  `password` varchar(40) NOT NULL default '',
  `created_on` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `updated_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `login` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `codered_db`.`workflows`
--

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
