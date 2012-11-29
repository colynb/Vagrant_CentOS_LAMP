-- phpMyAdmin SQL Dump
-- version 3.5.2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 24, 2012 at 12:25 AM
-- Server version: 5.5.27
-- PHP Version: 5.3.18

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


--
-- GRANT EXTERNAL PRIVILEGES TO ROOT
--
USE `mysql`;
GRANT ALL ON *.* to root@'33.33.33.1' IDENTIFIED BY '';
FLUSH PRIVILEGES;

--
-- Database: `myapp_test`
--

DROP SCHEMA IF EXISTS `myapp_test`;
CREATE SCHEMA `myapp_test`;
USE `myapp_test`;

-- --------------------------------------------------------

--
-- Table structure for table `myapp_table1`
--

DROP TABLE IF EXISTS `myapp_table1`;
CREATE TABLE IF NOT EXISTS `myapp_table1` (
  `id` int(12) NOT NULL,
  `col1` varchar(32) NOT NULL,
  `col2` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `myapp_table1`
--

INSERT INTO `myapp_table1` (`id`, `col1`, `col2`) VALUES
(1, 'Test Value', 'Test Value'),
(2, 'More Data', 'More Data Still');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
