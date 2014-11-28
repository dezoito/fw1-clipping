-- phpMyAdmin SQL Dump
-- version 3.5.8.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 28, 2014 at 11:43 AM
-- Server version: 5.5.34-0ubuntu0.13.04.1
-- PHP Version: 5.4.9-4ubuntu2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dtb_clipping`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_clipping`
--

CREATE TABLE IF NOT EXISTS `tbl_clipping` (
  `clipping_id` int(11) NOT NULL AUTO_INCREMENT,
  `clipping_titulo` varchar(100) NOT NULL,
  `clipping_texto` text,
  `clipping_link` varchar(200) DEFAULT NULL,
  `clipping_fonte` varchar(200) DEFAULT NULL,
  `published` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `clipping_incluido_por` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`clipping_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tbl_clipping`
--

INSERT INTO `tbl_clipping` (`clipping_id`, `clipping_titulo`, `clipping_texto`, `clipping_link`, `clipping_fonte`, `published`, `created`, `clipping_incluido_por`) VALUES
(1, 'titulo 1', 'texto 1', NULL, NULL, '2014-11-27 00:00:00', '2014-11-27 00:00:00', NULL),
(2, 'arguments.rc.clipping_titulo', 'arguments.rc.clipping_texto', 'arguments.rc.clipping_link', 'arguments.rc.clipping_fonte', '2014-11-27 16:46:56', '2014-11-27 16:46:56', 'arguments.rc.clipping_incluido_por'),
(3, 'arguments.rc.clipping_titulo', 'arguments.rc.clipping_texto', 'arguments.rc.clipping_link', 'arguments.rc.clipping_fonte', '2014-11-27 16:47:33', '2014-11-27 16:47:33', NULL),
(4, 'ewrwerwee', '<p>werewrw</p>\r\n', '', '', '2014-11-26 23:00:00', '2014-11-27 16:49:05', NULL),
(5, 'ewrwerwee', '<p>werewrw</p>\r\n', '', '', '2014-11-26 23:00:00', '2014-11-27 19:06:54', NULL),
(6, 'fabiano', '<p>In a Coldfusion component / CFC, I want to properly scope some variables to be available for all contained functions, but to be hidden or blocked from outside scripts. What is the name of the cfc&#39;s memory scope? Is it &#39;variables&#39;? Is that available inside a contained function? Is it blocked from outside the cfc?</p>\r\n\r\n<p>(Examples in CF 8)</p>\r\n\r\n<p>Calling page:</p>\r\n\r\n<pre>\r\n<code>&lt;cfset settings = structNew()&gt;\r\n&lt;cfset util = createObject(&quot;component&quot;, &quot;myUtils&quot;).init(settings)&gt;\r\n&lt;cfoutput&gt;\r\n    #util.myFunction()#\r\n&lt;/cfoutput&gt;</code></pre>\r\n\r\n<p>myUtils.cfc:</p>\r\n\r\n<pre>\r\n<code>&lt;cfcomponent&gt;\r\n&lt;!--- Need to set some cfc global vars here ---&gt;\r\n\r\n    &lt;cffunction name=&quot;init&quot; access=&quot;public&quot;&gt;\r\n        &lt;cfargument name=&quot;settings&quot; type=&quot;struct&quot; required=&quot;no&quot;&gt;\r\n        &lt;!--- I need to merge arguments.settings to the cfc global vars here ---&gt;\r\n        &lt;cfreturn this&gt;\r\n    &lt;/cffunction&gt;\r\n\r\n    &lt;cffunction name=&quot;myFunction&quot; access=&quot;public&quot;&gt;\r\n        &lt;cfset var result = &quot;&quot;&gt;\r\n        &lt;!--- I need to access the cfc global vars here for init settings ---&gt;\r\n        &lt;cfreturn result&gt;\r\n    &lt;/cffunction&gt;\r\n&lt;/cfcomponent&gt;</code></pre>\r\n\r\n<p>Additional best practice suggestions are welcomed. It&#39;s been quite a while since I&#39;ve done this. Thanks in advance.</p>\r\n', '', '', '2014-11-26 23:00:00', '2014-11-27 19:09:39', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
