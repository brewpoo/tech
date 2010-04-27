-- MySQL dump 10.10
--
-- Host: localhost    Database: tech_development
-- ------------------------------------------------------
-- Server version	5.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL auto_increment,
  `location_id` int(11) default NULL,
  `street_address` varchar(255) default NULL,
  `description` text,
  `city` varchar(255) default NULL,
  `state_id` int(11) default NULL,
  `zip` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_addresses_on_location_id` (`location_id`),
  KEY `index_addresses_on_state_id` (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_servers`
--

DROP TABLE IF EXISTS `application_servers`;
CREATE TABLE `application_servers` (
  `id` int(11) NOT NULL auto_increment,
  `application_id` int(4) default NULL,
  `server_id` int(4) default NULL,
  `service_status_id` int(4) default NULL,
  `service_id` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_application_servers_on_application_id` (`application_id`),
  KEY `index_application_servers_on_server_id` (`server_id`),
  KEY `index_application_servers_on_service_status_id` (`service_status_id`),
  KEY `index_application_servers_on_service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `application_servers`
--

LOCK TABLES `application_servers` WRITE;
/*!40000 ALTER TABLE `application_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apps`
--

DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `short_name` varchar(255) default NULL,
  `description` text,
  `department_id` int(4) default NULL,
  `manager_id` int(4) default NULL,
  `owner_id` int(4) default NULL,
  `priority_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_apps_on_name` (`name`),
  KEY `index_apps_on_department_id` (`department_id`),
  KEY `index_apps_on_manager_id` (`manager_id`),
  KEY `index_apps_on_owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apps`
--

LOCK TABLES `apps` WRITE;
/*!40000 ALTER TABLE `apps` DISABLE KEYS */;
/*!40000 ALTER TABLE `apps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `architectures`
--

DROP TABLE IF EXISTS `architectures`;
CREATE TABLE `architectures` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_architectures_on_parent_id` (`parent_id`),
  KEY `index_architectures_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `architectures`
--

LOCK TABLES `architectures` WRITE;
/*!40000 ALTER TABLE `architectures` DISABLE KEYS */;
/*!40000 ALTER TABLE `architectures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `filename` varchar(255) default NULL,
  `attachable_id` int(4) default NULL,
  `attachable_type` varchar(255) default NULL,
  `content_type` varchar(255) default NULL,
  `data` longblob,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_attachments_on_attachable_id` (`attachable_id`),
  KEY `index_attachments_on_attachable_type` (`attachable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
CREATE TABLE `audits` (
  `id` int(11) NOT NULL auto_increment,
  `auditable_id` int(4) default NULL,
  `auditable_type` varchar(255) default NULL,
  `user_id` int(4) default NULL,
  `user_type` varchar(255) default NULL,
  `username` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `changes` text,
  `version` int(4) default '0',
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `auditable_index` (`auditable_id`,`auditable_type`),
  KEY `user_index` (`user_id`,`user_type`),
  KEY `index_audits_on_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuit_types`
--

DROP TABLE IF EXISTS `circuit_types`;
CREATE TABLE `circuit_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `flag` varchar(255) default NULL,
  `description` text,
  `old_application_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_circuit_types_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `circuit_types`
--

LOCK TABLES `circuit_types` WRITE;
/*!40000 ALTER TABLE `circuit_types` DISABLE KEYS */;
INSERT INTO `circuit_types` VALUES (4,'Point to point','p2p','Point-to-Point circuits, like DS1s',NULL),(5,'Multi-point','mp','Multi-point circuits, lie Frame Relay and ATM',NULL),(6,'Dial line','dl','Dial lines: POTS, ISDN-BRI',NULL);
/*!40000 ALTER TABLE `circuit_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuits`
--

DROP TABLE IF EXISTS `circuits`;
CREATE TABLE `circuits` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(4) default NULL,
  `next_id` int(4) default NULL,
  `provider_id` int(4) default NULL,
  `line_speed_id` int(4) default NULL,
  `circuit_number` varchar(255) default NULL,
  `description` text,
  `date_installed` date default NULL,
  `is_disconnected` tinyint(1) default NULL,
  `date_disconnected` date default NULL,
  `circuit_type_id` int(11) default NULL,
  `line_type_id` int(11) default NULL,
  `old_circuit_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_circuits_on_parent_id` (`parent_id`),
  KEY `index_circuits_on_next_id` (`next_id`),
  KEY `index_circuits_on_provider_id` (`provider_id`),
  KEY `index_circuits_on_line_speed_id` (`line_speed_id`),
  KEY `index_circuits_on_circuit_number` (`circuit_number`),
  KEY `index_circuits_on_is_disconnected` (`is_disconnected`),
  KEY `index_circuits_on_circuit_type_id` (`circuit_type_id`),
  KEY `index_circuits_on_line_type_id` (`line_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `circuits`
--

LOCK TABLES `circuits` WRITE;
/*!40000 ALTER TABLE `circuits` DISABLE KEYS */;
/*!40000 ALTER TABLE `circuits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `circuits_locations`
--

DROP TABLE IF EXISTS `circuits_locations`;
CREATE TABLE `circuits_locations` (
  `location_id` int(4) default NULL,
  `circuit_id` int(4) default NULL,
  KEY `index_circuits_locations_on_location_id` (`location_id`),
  KEY `index_circuits_locations_on_circuit_id` (`circuit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `circuits_locations`
--

LOCK TABLES `circuits_locations` WRITE;
/*!40000 ALTER TABLE `circuits_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `circuits_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `state_id` int(4) default NULL,
  `po_city` varchar(255) default NULL,
  `po_zip` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_cities_on_name` (`name`),
  KEY `index_cities_on_state_id` (`state_id`),
  KEY `index_cities_on_po_zip` (`po_zip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `is_vendor` tinyint(1) default NULL,
  `contact_id` int(11) default NULL,
  `is_provider` tinyint(1) default NULL,
  `is_manufacturer` tinyint(1) default NULL,
  `url` varchar(255) default NULL,
  `bpo` varchar(255) default NULL,
  `bpo_expiry` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_companies_on_is_vendor` (`is_vendor`),
  KEY `index_companies_on_is_provider` (`is_provider`),
  KEY `index_companies_on_contact_id` (`contact_id`),
  KEY `index_companies_on_is_manufacturer` (`is_manufacturer`),
  KEY `index_companies_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components`
--

DROP TABLE IF EXISTS `components`;
CREATE TABLE `components` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `is_base` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_components_on_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `components`
--

LOCK TABLES `components` WRITE;
/*!40000 ALTER TABLE `components` DISABLE KEYS */;
/*!40000 ALTER TABLE `components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL auto_increment,
  `last_name` varchar(255) default NULL,
  `first_name` varchar(255) default NULL,
  `department_id` int(11) default NULL,
  `location_id` int(11) default NULL,
  `employee_number` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `manager_id` int(11) default NULL,
  `description` text,
  `employer_id` int(11) default NULL,
  `title` varchar(255) default NULL,
  `is_purchase_contact` tinyint(1) default NULL,
  `fund_code` int(11) default NULL,
  `management_center` int(11) default NULL,
  `work_order` varchar(255) default NULL,
  `budget_code` int(11) default NULL,
  `is_manager` tinyint(1) default NULL,
  `is_engineer` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_contacts_on_employee_number` (`employee_number`),
  KEY `full_name_index` (`last_name`,`first_name`),
  KEY `index_contacts_on_department_id` (`department_id`),
  KEY `index_contacts_on_location_id` (`location_id`),
  KEY `index_contacts_on_manager_id` (`manager_id`),
  KEY `index_contacts_on_employer_id` (`employer_id`),
  KEY `index_contacts_on_is_purchase_contact` (`is_purchase_contact`),
  KEY `index_contacts_on_is_manager` (`is_manager`),
  KEY `index_contacts_on_is_engineer` (`is_engineer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `alternate_name` varchar(255) default NULL,
  `parent_id` int(11) default NULL,
  `company_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_departments_on_parent_id` (`parent_id`),
  KEY `index_departments_on_name` (`name`),
  KEY `index_departments_on_company_id` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_classes`
--

DROP TABLE IF EXISTS `device_classes`;
CREATE TABLE `device_classes` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `old_hostclass_id` int(11) default NULL,
  `set_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_device_classes_on_parent_id` (`parent_id`),
  KEY `index_device_classes_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `device_classes`
--

LOCK TABLES `device_classes` WRITE;
/*!40000 ALTER TABLE `device_classes` DISABLE KEYS */;
INSERT INTO `device_classes` VALUES (5,NULL,'Network','All Network devices',NULL,NULL),(6,5,'Router','All Routers',3,NULL),(7,6,'Routing Switch','Layer 3 switch',6,NULL),(8,5,'Switch','Layer 2 switch',4,NULL),(9,7,'Application Switch','Layer 4-7 switch',NULL,NULL),(10,5,'CSU/DSU','Digital modems (DS1, 56k, etc)',7,NULL),(11,NULL,'Workstation','All Workstation devices',1,NULL),(12,11,'Desktop','Desktop PCs',NULL,NULL),(17,11,'Laptop',NULL,NULL,NULL),(19,NULL,'Server','Any file, application or print server',2,NULL),(20,5,'WAP','Wireless Access Point',17,NULL),(21,11,'IP Phone','VoIP Phone',10,NULL),(22,NULL,'Printer','Network printer or external print server',9,NULL),(23,19,'Video Server',NULL,15,NULL),(24,6,'VPN Device',NULL,21,NULL),(25,5,'NMS','Network Management Server',8,NULL),(26,19,'UPS','UPS network management interface',20,NULL),(30,NULL,'Unknown',NULL,14,NULL),(31,11,'Thin Client',NULL,NULL,NULL),(32,5,'Firewall',NULL,19,NULL),(33,19,'Console Access Switch',NULL,NULL,NULL),(34,5,'Media Converter','Traditional Media Converter or LAN Extension device',NULL,NULL),(35,19,'RIB/ILO','Remote Management Server',NULL,NULL),(36,11,'Other',NULL,NULL,NULL),(37,11,'Sign',NULL,NULL,NULL),(38,11,'Serial Device',NULL,NULL,NULL);
/*!40000 ALTER TABLE `device_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
CREATE TABLE `devices` (
  `id` int(11) NOT NULL auto_increment,
  `device_class_id` int(11) default NULL,
  `equipment_id` int(11) default NULL,
  `contact_id` int(11) default NULL,
  `hostname` varchar(255) default NULL,
  `description` text,
  `is_virtual` tinyint(1) default NULL,
  `is_dummy` tinyint(1) default NULL,
  `domain_id` int(11) default NULL,
  `primary_interface_id` int(11) default NULL,
  `device_id` int(11) default NULL,
  `type` varchar(255) default NULL,
  `primary_engineer_id` int(11) default NULL,
  `is_san_connected` tinyint(1) default NULL,
  `is_tivoli_agent` tinyint(1) default NULL,
  `operating_system_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_devices_on_device_class_id` (`device_class_id`),
  KEY `index_devices_on_equipment_id` (`equipment_id`),
  KEY `index_devices_on_contact_id` (`contact_id`),
  KEY `index_devices_on_is_virtual` (`is_virtual`),
  KEY `index_devices_on_is_dummy` (`is_dummy`),
  KEY `index_devices_on_domain_id` (`domain_id`),
  KEY `index_devices_on_primary_interface_id` (`primary_interface_id`),
  KEY `index_devices_on_hostname` (`hostname`),
  KEY `index_devices_on_device_id` (`device_id`),
  KEY `index_devices_on_primary_engineer_id` (`primary_engineer_id`),
  KEY `index_devices_on_operating_system_id` (`operating_system_id`),
  KEY `index_devices_on_is_san_connected` (`is_san_connected`),
  KEY `index_devices_on_is_tivoli_agent` (`is_tivoli_agent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dial_lines`
--

DROP TABLE IF EXISTS `dial_lines`;
CREATE TABLE `dial_lines` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(4) default NULL,
  `circuit_id` int(4) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_dial_lines_on_device_id` (`device_id`),
  KEY `index_dial_lines_on_circuit_id` (`circuit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dial_lines`
--

LOCK TABLES `dial_lines` WRITE;
/*!40000 ALTER TABLE `dial_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `dial_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distributed_items`
--

DROP TABLE IF EXISTS `distributed_items`;
CREATE TABLE `distributed_items` (
  `id` int(11) NOT NULL auto_increment,
  `distributed_on` date default NULL,
  `contact_id` int(4) default NULL,
  `order_item_id` int(4) default NULL,
  `quantity` int(4) default NULL,
  `processor_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_distributed_items_on_contact_id` (`contact_id`),
  KEY `index_distributed_items_on_order_item_id` (`order_item_id`),
  KEY `index_distributed_items_on_distributed_on` (`distributed_on`),
  KEY `index_distributed_items_on_processor_id` (`processor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `distributed_items`
--

LOCK TABLES `distributed_items` WRITE;
/*!40000 ALTER TABLE `distributed_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `distributed_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_names`
--

DROP TABLE IF EXISTS `domain_names`;
CREATE TABLE `domain_names` (
  `id` int(11) NOT NULL auto_increment,
  `nameable_id` int(4) default NULL,
  `nameable_type` varchar(255) default NULL,
  `hostname` varchar(255) default NULL,
  `domain_id` int(4) default NULL,
  `publish_reverse` tinyint(1) default NULL,
  `created_on` date default NULL,
  `updated_on` date default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_domain_names_on_nameable_id` (`nameable_id`),
  KEY `index_domain_names_on_nameable_type` (`nameable_type`),
  KEY `index_domain_names_on_domain_id` (`domain_id`),
  KEY `index_domain_names_on_hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domain_names`
--

LOCK TABLES `domain_names` WRITE;
/*!40000 ALTER TABLE `domain_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains`
--

DROP TABLE IF EXISTS `domains`;
CREATE TABLE `domains` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `autodns` tinyint(1) default NULL,
  `maintainer_id` int(11) default NULL,
  `primary_server_id` int(11) default NULL,
  `generate_soa` tinyint(1) default NULL,
  `soa_timer_section` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_domains_on_parent_id` (`parent_id`),
  KEY `index_domains_on_name` (`name`),
  KEY `index_domains_on_autodns` (`autodns`),
  KEY `index_domains_on_maintainer_id` (`maintainer_id`),
  KEY `index_domains_on_primary_server_id` (`primary_server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domains`
--

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains_servers`
--

DROP TABLE IF EXISTS `domains_servers`;
CREATE TABLE `domains_servers` (
  `domain_id` int(4) default NULL,
  `server_id` int(4) default NULL,
  KEY `index_domains_servers_on_domain_id` (`domain_id`),
  KEY `index_domains_servers_on_server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domains_servers`
--

LOCK TABLES `domains_servers` WRITE;
/*!40000 ALTER TABLE `domains_servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engineers_projects`
--

DROP TABLE IF EXISTS `engineers_projects`;
CREATE TABLE `engineers_projects` (
  `engineer_id` int(4) default NULL,
  `project_id` int(4) default NULL,
  KEY `index_engineers_projects_on_engineer_id` (`engineer_id`),
  KEY `index_engineers_projects_on_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `engineers_projects`
--

LOCK TABLES `engineers_projects` WRITE;
/*!40000 ALTER TABLE `engineers_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `engineers_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL auto_increment,
  `product_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `delivery_date` date default NULL,
  `location_id` int(11) default NULL,
  `tag_number` varchar(255) default NULL,
  `serial_number` varchar(255) default NULL,
  `host_identifier` varchar(255) default NULL,
  `status_id` int(11) default NULL,
  `count` int(11) default NULL,
  `equipment_status_id` int(11) default NULL,
  `warranty_expiry` date default NULL,
  `role_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_equipment_on_product_id` (`product_id`),
  KEY `index_equipment_on_parent_id` (`parent_id`),
  KEY `index_equipment_on_location_id` (`location_id`),
  KEY `index_equipment_on_status_id` (`status_id`),
  KEY `index_equipment_on_count` (`count`),
  KEY `index_equipment_on_serial_number` (`serial_number`),
  KEY `index_equipment_on_equipment_status_id` (`equipment_status_id`),
  KEY `index_equipment_on_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_properties`
--

DROP TABLE IF EXISTS `equipment_properties`;
CREATE TABLE `equipment_properties` (
  `id` int(11) NOT NULL auto_increment,
  `equipment_id` int(11) default NULL,
  `property_id` int(11) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_equipment_properties_on_equipment_id` (`equipment_id`),
  KEY `index_equipment_properties_on_property_id` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipment_properties`
--

LOCK TABLES `equipment_properties` WRITE;
/*!40000 ALTER TABLE `equipment_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_statuses`
--

DROP TABLE IF EXISTS `equipment_statuses`;
CREATE TABLE `equipment_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `flag` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_equipment_statuses_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipment_statuses`
--

LOCK TABLES `equipment_statuses` WRITE;
/*!40000 ALTER TABLE `equipment_statuses` DISABLE KEYS */;
INSERT INTO `equipment_statuses` VALUES (1,'In Stock','Item is in stock and available for use','stock'),(2,'Sparing','Item is in stock but reserved for sparing purposes only','spare'),(3,'Deployed','Item is in use in the field','deploy'),(4,'Destroyed','Item has been decommissioned','destroy'),(5,'Staging','Items is in stock but designated for specific use','stage'),(6,'Returned','Returned to vendor','return');
/*!40000 ALTER TABLE `equipment_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfaces`
--

DROP TABLE IF EXISTS `interfaces`;
CREATE TABLE `interfaces` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(11) default NULL,
  `hardware_address` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `is_dynamic` tinyint(1) default NULL,
  `topology_id` int(11) default NULL,
  `vlanid` int(11) default NULL,
  `is_wireless` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_interfaces_on_device_id` (`device_id`),
  KEY `index_interfaces_on_hardware_address` (`hardware_address`),
  KEY `index_interfaces_on_topology_id` (`topology_id`),
  KEY `index_interfaces_on_is_wireless` (`is_wireless`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interfaces`
--

LOCK TABLES `interfaces` WRITE;
/*!40000 ALTER TABLE `interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_address_holds`
--

DROP TABLE IF EXISTS `ipv4_address_holds`;
CREATE TABLE `ipv4_address_holds` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_subnet_id` int(4) default NULL,
  `ip_address_packed` bigint(21) default NULL,
  `held_on` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_address_holds_on_ipv4_subnet_id` (`ipv4_subnet_id`),
  KEY `index_ipv4_address_holds_on_ip_address_packed` (`ip_address_packed`),
  KEY `index_ipv4_address_holds_on_held_on` (`held_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_address_holds`
--

LOCK TABLES `ipv4_address_holds` WRITE;
/*!40000 ALTER TABLE `ipv4_address_holds` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_address_holds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_address_ranges`
--

DROP TABLE IF EXISTS `ipv4_address_ranges`;
CREATE TABLE `ipv4_address_ranges` (
  `id` int(11) NOT NULL auto_increment,
  `zone_id` int(11) default NULL,
  `ipv4_scope_id` int(11) default NULL,
  `is_dynamic` tinyint(1) default NULL,
  `is_reserved` tinyint(1) default NULL,
  `start_address` varchar(255) default NULL,
  `start_address_packed` bigint(21) default NULL,
  `end_address` varchar(255) default NULL,
  `end_address_packed` bigint(21) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_address_ranges_on_zone_id` (`zone_id`),
  KEY `index_ipv4_address_ranges_on_ipv4_scope_id` (`ipv4_scope_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_address_ranges`
--

LOCK TABLES `ipv4_address_ranges` WRITE;
/*!40000 ALTER TABLE `ipv4_address_ranges` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_address_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_assigned_networks`
--

DROP TABLE IF EXISTS `ipv4_assigned_networks`;
CREATE TABLE `ipv4_assigned_networks` (
  `id` int(11) NOT NULL auto_increment,
  `subnet_address` varchar(255) default NULL,
  `subnet_address_packed` bigint(21) default NULL,
  `prefix` int(4) default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_assigned_networks`
--

LOCK TABLES `ipv4_assigned_networks` WRITE;
/*!40000 ALTER TABLE `ipv4_assigned_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_assigned_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_assignments`
--

DROP TABLE IF EXISTS `ipv4_assignments`;
CREATE TABLE `ipv4_assignments` (
  `id` int(11) NOT NULL auto_increment,
  `zone_id` int(11) default NULL,
  `prefix` int(11) default NULL,
  `network_class_id` int(11) default NULL,
  `topology_id` int(11) default NULL,
  `assign_prefix` int(11) default NULL,
  `description` text,
  `subnet_address` varchar(255) default NULL,
  `subnet_address_packed` bigint(21) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_assignments_on_zone_id` (`zone_id`),
  KEY `index_ipv4_assignments_on_network_class_id` (`network_class_id`),
  KEY `index_ipv4_assignments_on_topology_id` (`topology_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_assignments`
--

LOCK TABLES `ipv4_assignments` WRITE;
/*!40000 ALTER TABLE `ipv4_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_interfaces`
--

DROP TABLE IF EXISTS `ipv4_interfaces`;
CREATE TABLE `ipv4_interfaces` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_subnet_id` int(11) default NULL,
  `interface_id` int(11) default NULL,
  `is_reserved` tinyint(1) default NULL,
  `is_delinquent` tinyint(1) default NULL,
  `is_stealth` tinyint(1) default NULL,
  `is_rogue` tinyint(1) default NULL,
  `is_virtual` tinyint(1) default NULL,
  `ip_address` varchar(255) default NULL,
  `ip_address_packed` bigint(21) default NULL,
  `old_interface_id` int(11) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `ping_count` int(11) default NULL,
  `last_pinged_on` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_interfaces_on_ipv4_subnet_id` (`ipv4_subnet_id`),
  KEY `index_ipv4_interfaces_on_interface_id` (`interface_id`),
  KEY `index_ipv4_interfaces_on_ip_address_packed` (`ip_address_packed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_interfaces`
--

LOCK TABLES `ipv4_interfaces` WRITE;
/*!40000 ALTER TABLE `ipv4_interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_networks`
--

DROP TABLE IF EXISTS `ipv4_networks`;
CREATE TABLE `ipv4_networks` (
  `id` int(11) NOT NULL auto_increment,
  `network_address` int(4) default NULL,
  `network_mask` int(4) default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_networks`
--

LOCK TABLES `ipv4_networks` WRITE;
/*!40000 ALTER TABLE `ipv4_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_schema_rules`
--

DROP TABLE IF EXISTS `ipv4_schema_rules`;
CREATE TABLE `ipv4_schema_rules` (
  `id` int(11) NOT NULL auto_increment,
  `zone_id` int(4) default NULL,
  `network_address_packed` bigint(21) default NULL,
  `network_mask_packed` bigint(21) default NULL,
  `device_class_id` int(4) default NULL,
  `lbound` int(4) default NULL,
  `ubound` int(4) default NULL,
  `description` text,
  `network_address` varchar(255) default NULL,
  `network_mask` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_schema_rules_on_zone_id` (`zone_id`),
  KEY `index_ipv4_schema_rules_on_device_class_id` (`device_class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_schema_rules`
--

LOCK TABLES `ipv4_schema_rules` WRITE;
/*!40000 ALTER TABLE `ipv4_schema_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_schema_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_scope_option_entries`
--

DROP TABLE IF EXISTS `ipv4_scope_option_entries`;
CREATE TABLE `ipv4_scope_option_entries` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_scope_id` int(11) default NULL,
  `ipv4_scope_option_id` int(11) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_scope_option_entries`
--

LOCK TABLES `ipv4_scope_option_entries` WRITE;
/*!40000 ALTER TABLE `ipv4_scope_option_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_scope_option_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_scope_options`
--

DROP TABLE IF EXISTS `ipv4_scope_options`;
CREATE TABLE `ipv4_scope_options` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_scope_options`
--

LOCK TABLES `ipv4_scope_options` WRITE;
/*!40000 ALTER TABLE `ipv4_scope_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_scope_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_scopes`
--

DROP TABLE IF EXISTS `ipv4_scopes`;
CREATE TABLE `ipv4_scopes` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_subnet_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `server_id` int(11) default NULL,
  `gateway_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_scopes_on_ipv4_subnet_id` (`ipv4_subnet_id`),
  KEY `index_ipv4_scopes_on_server_id` (`server_id`),
  KEY `index_ipv4_scopes_on_gateway_id` (`gateway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_scopes`
--

LOCK TABLES `ipv4_scopes` WRITE;
/*!40000 ALTER TABLE `ipv4_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_subnets`
--

DROP TABLE IF EXISTS `ipv4_subnets`;
CREATE TABLE `ipv4_subnets` (
  `id` int(11) NOT NULL auto_increment,
  `subnet_id` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `zone_id` int(11) default NULL,
  `subnet_address` varchar(255) default NULL,
  `subnet_address_packed` bigint(21) default NULL,
  `subnet_mask` varchar(255) default NULL,
  `subnet_mask_packed` bigint(21) default NULL,
  `description` text,
  `old_network_id` int(11) default NULL,
  `gateway_address` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_subnets_on_zone_id` (`zone_id`),
  KEY `index_ipv4_subnets_on_parent_id` (`parent_id`),
  KEY `index_ipv4_subnets_on_subnet_id` (`subnet_id`),
  KEY `index_ipv4_subnets_on_subnet_address_packed` (`subnet_address_packed`),
  KEY `index_ipv4_subnets_on_subnet_mask_packed` (`subnet_mask_packed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_subnets`
--

LOCK TABLES `ipv4_subnets` WRITE;
/*!40000 ALTER TABLE `ipv4_subnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_subnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_virtual_host_interfaces`
--

DROP TABLE IF EXISTS `ipv4_virtual_host_interfaces`;
CREATE TABLE `ipv4_virtual_host_interfaces` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_virtual_host_id` int(4) default NULL,
  `ipv4_interface_id` int(4) default NULL,
  `priority` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_virtual_host_interfaces_on_ipv4_virtual_host_id` (`ipv4_virtual_host_id`),
  KEY `index_ipv4_virtual_host_interfaces_on_ipv4_interface_id` (`ipv4_interface_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_virtual_host_interfaces`
--

LOCK TABLES `ipv4_virtual_host_interfaces` WRITE;
/*!40000 ALTER TABLE `ipv4_virtual_host_interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_virtual_host_interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipv4_virtual_hosts`
--

DROP TABLE IF EXISTS `ipv4_virtual_hosts`;
CREATE TABLE `ipv4_virtual_hosts` (
  `id` int(11) NOT NULL auto_increment,
  `ipv4_subnet_id` int(4) default NULL,
  `vrid` int(4) default NULL,
  `description` text,
  `ipv4_interface_id` int(11) default NULL,
  `is_vrrp` tinyint(1) default NULL,
  `old_virtual_id` int(11) default NULL,
  `virtual_host_type_id` int(11) default NULL,
  `otherid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_ipv4_virtual_hosts_on_ipv4_subnet_id` (`ipv4_subnet_id`),
  KEY `index_ipv4_virtual_hosts_on_ipv4_interface_id` (`ipv4_interface_id`),
  KEY `index_ipv4_virtual_hosts_on_virtual_host_type_id` (`virtual_host_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ipv4_virtual_hosts`
--

LOCK TABLES `ipv4_virtual_hosts` WRITE;
/*!40000 ALTER TABLE `ipv4_virtual_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipv4_virtual_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_speeds`
--

DROP TABLE IF EXISTS `line_speeds`;
CREATE TABLE `line_speeds` (
  `id` int(11) NOT NULL auto_increment,
  `topology_id` int(4) default NULL,
  `parent_id` int(4) default NULL,
  `name` varchar(255) default NULL,
  `speed` varchar(255) default NULL,
  `old_linespeed_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_line_speeds_on_topology_id` (`topology_id`),
  KEY `index_line_speeds_on_parent_id` (`parent_id`),
  KEY `index_line_speeds_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `line_speeds`
--

LOCK TABLES `line_speeds` WRITE;
/*!40000 ALTER TABLE `line_speeds` DISABLE KEYS */;
INSERT INTO `line_speeds` VALUES (5,NULL,6,'DS3','45 Mbps',NULL),(6,NULL,7,'DS1','1.544 Mbps',1),(7,NULL,NULL,'DS0','64 Kbps',5),(8,NULL,NULL,'DDS','56 Kbps',2),(9,NULL,11,'Gigabit Ethernet','1 Gbps',4),(10,NULL,7,'FT1-384','384 Kbps',3),(11,NULL,NULL,'Ethernet','10 Mpbs',NULL),(12,NULL,11,'Fast Ethernet','100 Mbps',NULL);
/*!40000 ALTER TABLE `line_speeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_types`
--

DROP TABLE IF EXISTS `line_types`;
CREATE TABLE `line_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `parent_id` int(11) default NULL,
  `old_channel_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_line_types_on_parent_id` (`parent_id`),
  KEY `index_line_types_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `line_types`
--

LOCK TABLES `line_types` WRITE;
/*!40000 ALTER TABLE `line_types` DISABLE KEYS */;
INSERT INTO `line_types` VALUES (1,'Copper',NULL,NULL,5),(2,'Category 5/5e',NULL,1,1),(3,'T-Carrier','T-carrier service',NULL,NULL),(4,'DS1',NULL,3,3),(5,'DS3',NULL,3,NULL),(6,'DDS','Digital Data Service',NULL,6),(7,'Fiber',NULL,NULL,2),(8,'SONET',NULL,NULL,4),(9,'ATM',NULL,NULL,9),(10,'ISDN',NULL,NULL,NULL),(11,'PRI',NULL,10,8),(12,'BRI',NULL,10,7),(13,'Ethernet Services',NULL,NULL,NULL),(14,'EPL','Ethernet Private Line',13,NULL),(15,'TLS','Transparent LAN Switching',13,NULL),(16,'Ethernet Line Driver',NULL,1,NULL),(17,'EVC','Ethernet Virtual Circuit',9,NULL);
/*!40000 ALTER TABLE `line_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_categories`
--

DROP TABLE IF EXISTS `link_categories`;
CREATE TABLE `link_categories` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(4) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_link_categories_on_parent_id` (`parent_id`),
  KEY `index_link_categories_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `link_categories`
--

LOCK TABLES `link_categories` WRITE;
/*!40000 ALTER TABLE `link_categories` DISABLE KEYS */;
INSERT INTO `link_categories` VALUES (1,NULL,'Application','Links to Web Applications'),(2,8,'RIB','Out of Band console access'),(3,6,'GroupWise',NULL),(4,3,'POA',NULL),(5,3,'MTA',NULL),(6,NULL,'Novell',NULL),(7,6,'Remote Manager',NULL),(8,NULL,'HP',NULL),(9,8,'Blade Enclosure',NULL),(10,NULL,'Misc',NULL),(11,NULL,'Nortel',NULL),(12,11,'Router',NULL),(13,11,'Load Balancer',NULL),(14,NULL,'Documentation',NULL);
/*!40000 ALTER TABLE `link_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
  `id` int(11) NOT NULL auto_increment,
  `linkable_id` int(4) default NULL,
  `linkable_type` varchar(255) default NULL,
  `link_category_id` int(4) default NULL,
  `url` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_links_on_linkable_id` (`linkable_id`),
  KEY `index_links_on_linkable_type` (`linkable_type`),
  KEY `index_links_on_link_category_id` (`link_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `depth` int(11) default NULL,
  `description` text,
  `contact_id` int(11) default NULL,
  `nick_name` varchar(255) default NULL,
  `short_name` varchar(255) default NULL,
  `mailstop` varchar(255) default NULL,
  `latitude` decimal(15,10) default NULL,
  `longitude` decimal(15,10) default NULL,
  `is_delivery_location` tinyint(1) default NULL,
  `old_id` int(11) default NULL,
  `long_name` varchar(255) default NULL,
  `is_storage_location` tinyint(1) default NULL,
  `is_data_center` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_locations_on_parent_id` (`parent_id`),
  KEY `index_locations_on_name` (`name`),
  KEY `index_locations_on_contact_id` (`contact_id`),
  KEY `index_locations_on_long_name` (`long_name`),
  KEY `index_locations_on_depth` (`depth`),
  KEY `index_locations_on_is_delivery_location` (`is_delivery_location`),
  KEY `index_locations_on_is_storage_location` (`is_storage_location`),
  KEY `index_locations_on_is_data_center` (`is_data_center`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_logs`
--

DROP TABLE IF EXISTS `maintenance_logs`;
CREATE TABLE `maintenance_logs` (
  `id` int(11) NOT NULL auto_increment,
  `loggable_id` int(4) default NULL,
  `loggable_type` varchar(255) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `created_by` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `body` text,
  PRIMARY KEY  (`id`),
  KEY `index_maintenance_logs_on_loggable_id` (`loggable_id`),
  KEY `index_maintenance_logs_on_loggable_type` (`loggable_type`),
  KEY `index_maintenance_logs_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maintenance_logs`
--

LOCK TABLES `maintenance_logs` WRITE;
/*!40000 ALTER TABLE `maintenance_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_dlcis`
--

DROP TABLE IF EXISTS `mp_dlcis`;
CREATE TABLE `mp_dlcis` (
  `id` int(11) NOT NULL auto_increment,
  `dlci` int(4) default NULL,
  `mp_line_id` int(4) default NULL,
  `interface_id` int(4) default NULL,
  `old_dlci_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_mp_dlcis_on_mp_line_id` (`mp_line_id`),
  KEY `index_mp_dlcis_on_interface_id` (`interface_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mp_dlcis`
--

LOCK TABLES `mp_dlcis` WRITE;
/*!40000 ALTER TABLE `mp_dlcis` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_dlcis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_lines`
--

DROP TABLE IF EXISTS `mp_lines`;
CREATE TABLE `mp_lines` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(4) default NULL,
  `circuit_id` int(4) default NULL,
  `old_mp_line_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_mp_lines_on_device_id` (`device_id`),
  KEY `index_mp_lines_on_circuit_id` (`circuit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mp_lines`
--

LOCK TABLES `mp_lines` WRITE;
/*!40000 ALTER TABLE `mp_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mp_pvcs`
--

DROP TABLE IF EXISTS `mp_pvcs`;
CREATE TABLE `mp_pvcs` (
  `id` int(11) NOT NULL auto_increment,
  `dlci_a_id` int(4) default NULL,
  `dlci_b_id` int(4) default NULL,
  `old_pvc_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_mp_pvcs_on_dlci_a_id` (`dlci_a_id`),
  KEY `index_mp_pvcs_on_dlci_b_id` (`dlci_b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mp_pvcs`
--

LOCK TABLES `mp_pvcs` WRITE;
/*!40000 ALTER TABLE `mp_pvcs` DISABLE KEYS */;
/*!40000 ALTER TABLE `mp_pvcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_classes`
--

DROP TABLE IF EXISTS `network_classes`;
CREATE TABLE `network_classes` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `old_netclass_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_network_classes_on_parent_id` (`parent_id`),
  KEY `index_network_classes_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `network_classes`
--

LOCK TABLES `network_classes` WRITE;
/*!40000 ALTER TABLE `network_classes` DISABLE KEYS */;
INSERT INTO `network_classes` VALUES (8,12,'Network','Transit network for routing',4),(9,11,'TSM','Ticket office networks for TSM devices',6),(10,11,'TIMACs','TIMACs dedicated',3),(11,NULL,'Critical',NULL,8),(12,NULL,'Generic',NULL,5),(13,12,'VPN',NULL,7),(14,12,'User',NULL,2),(15,12,'Server',NULL,1),(16,NULL,'Management',NULL,9),(17,12,'Internet','Public Internet and DMZ networks',10),(18,11,'Voice','VoIP networks',11),(19,8,'Point-to-Point','Point to Point transit networks',NULL),(20,8,'West End','West End Ethernet Networks',NULL),(21,8,'East End','East End Ethernet Networks',NULL),(22,8,'Central','Core Ethernet Networks',NULL),(23,21,'Transit',NULL,NULL),(24,20,'Transit',NULL,NULL),(25,22,'Transit',NULL,NULL);
/*!40000 ALTER TABLE `network_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL auto_increment,
  `body` text,
  `notable_id` int(11) default NULL,
  `notable_type` varchar(255) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `created_by` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `notable_index` (`notable_id`,`notable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_systems`
--

DROP TABLE IF EXISTS `operating_systems`;
CREATE TABLE `operating_systems` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(4) default NULL,
  `name` varchar(255) default NULL,
  `long_name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_operating_systems_on_parent_id` (`parent_id`),
  KEY `index_operating_systems_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operating_systems`
--

LOCK TABLES `operating_systems` WRITE;
/*!40000 ALTER TABLE `operating_systems` DISABLE KEYS */;
INSERT INTO `operating_systems` VALUES (1,NULL,'SLES','SLES','SUSE Linux Enterprise Server'),(6,1,'10','SLES 10',NULL),(7,6,'SP2','SLES 10 SP2',NULL),(8,7,'i586','SLES 10 SP2 i586',NULL),(9,7,'x86_64','SLES 10 SP2 x86_64',NULL),(10,NULL,'Fedora','Fedora',NULL),(11,10,'7','Fedora 7',NULL),(12,1,'11','SLES 11',NULL),(13,12,'x86_64','SLES 11 x86_64',NULL),(14,NULL,'Red Hat','Red Hat',NULL),(15,14,'Enterprise Linux','Red Hat Enterprise Linux',NULL),(16,15,'AS','Red Hat Enterprise Linux AS',NULL),(17,15,'ES','Red Hat Enterprise Linux ES',NULL),(18,NULL,'Windows','Windows',NULL),(19,18,'Server','Windows Server',NULL),(20,19,'2008','Windows Server 2008',NULL),(21,20,'R2','Windows Server 2008 R2',NULL),(22,21,'Enterprise Edition','Windows Server 2008 R2 Enterprise Edition',NULL),(23,19,'2003','Windows Server 2003',NULL),(24,NULL,'Solaris','Solaris',NULL),(25,24,'8','Solaris 8',NULL),(26,24,'9','Solaris 9',NULL),(27,24,'10','Solaris 10',NULL),(28,21,'Standard Edition','Windows Server 2008 R2 Standard Edition',NULL),(29,NULL,'Netware','Netware',NULL),(30,29,'6.5','Netware 6.5',NULL),(31,6,'SP3','SLES 10 SP3',NULL),(32,31,'i586','SLES 10 SP3 i586',NULL),(33,31,'x86_64','SLES 10 SP3 x86_64',NULL),(34,8,'OES2 SP1','SLES 10 SP2 i586 OES2 SP1',NULL),(35,9,'OES2 SP1','SLES 10 SP2 x86_64 OES2 SP1',NULL),(36,33,'OES2 SP2','SLES 10 SP3 x86_64 OES2 SP2',NULL),(37,32,'OES2 SP2','SLES 10 SP3 i586 OES2 SP2',NULL),(38,19,'2000','Windows Server 2000',NULL),(39,15,'5','Red Hat Enterprise Linux 5',NULL),(40,15,'5.2','Red Hat Enterprise Linux 5.2',NULL),(41,15,'4','Red Hat Enterprise Linux 4',NULL),(42,NULL,'AIX','AIX',NULL),(43,15,'5.1','Red Hat Enterprise Linux 5.1',NULL),(44,42,'4.3.2','AIX 4.3.2',NULL),(45,15,'5.3','Red Hat Enterprise Linux 5.3',NULL),(46,NULL,'HP-UX','HP-UX',NULL);
/*!40000 ALTER TABLE `operating_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL auto_increment,
  `product_id` int(4) default NULL,
  `quantity` int(4) default NULL,
  `unit_price` decimal(10,2) default NULL,
  `can_substitute` tinyint(1) default NULL,
  `order_id` int(11) default NULL,
  `details` text,
  PRIMARY KEY  (`id`),
  KEY `index_order_items_on_product_id` (`product_id`),
  KEY `index_order_items_on_quantity` (`quantity`),
  KEY `index_order_items_on_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
CREATE TABLE `order_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `value` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_order_statuses_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'Draft',0),(2,'Opened',1),(3,'Approved',2),(4,'Processed',3),(5,'Closed',7);
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_types`
--

DROP TABLE IF EXISTS `order_types`;
CREATE TABLE `order_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `processor_id` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_order_types_on_name` (`name`),
  KEY `index_order_types_on_processor_id` (`processor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_types`
--

LOCK TABLES `order_types` WRITE;
/*!40000 ALTER TABLE `order_types` DISABLE KEYS */;
INSERT INTO `order_types` VALUES (1,'Server',NULL),(2,'Network',NULL),(3,'Hardware',NULL),(4,'Software',NULL),(5,'Peripheral',NULL),(6,'Supplies',NULL);
/*!40000 ALTER TABLE `order_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL auto_increment,
  `order_number` int(4) default NULL,
  `ordered_on` date default NULL,
  `description` text,
  `priority` int(4) default NULL,
  `order_status_old` int(11) default NULL,
  `requestor_id` int(4) default NULL,
  `is_approved` tinyint(1) default NULL,
  `approved_by` varchar(255) default NULL,
  `approved_on` date default NULL,
  `order_type_old` int(11) default NULL,
  `other_order_number` varchar(255) default NULL,
  `justification` text,
  `department_id` int(11) default NULL,
  `assignee` text,
  `related_pc01` varchar(255) default NULL,
  `department_control_number` varchar(255) default NULL,
  `old_project` varchar(255) default NULL,
  `hwdl` varchar(255) default NULL,
  `hw` varchar(255) default NULL,
  `order_type_id` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `service_request` varchar(255) default NULL,
  `management_center` varchar(255) default NULL,
  `pc01_id` int(11) default NULL,
  `closed_on` date default NULL,
  `order_status_id` int(11) default NULL,
  `budget_year` int(11) default NULL,
  `fund_code` int(11) default NULL,
  `work_order` varchar(255) default NULL,
  `budget_code` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_orders_on_order_number` (`order_number`),
  KEY `index_orders_on_ordered_on` (`ordered_on`),
  KEY `index_orders_on_requestor_id` (`requestor_id`),
  KEY `index_orders_on_is_approved` (`is_approved`),
  KEY `index_orders_on_department_id` (`department_id`),
  KEY `index_orders_on_order_type_id` (`order_type_id`),
  KEY `index_orders_on_manager_id` (`manager_id`),
  KEY `index_orders_on_project_id` (`project_id`),
  KEY `index_orders_on_pc01_id` (`pc01_id`),
  KEY `index_orders_on_closed_on` (`closed_on`),
  KEY `index_orders_on_order_status_id` (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc01_categories`
--

DROP TABLE IF EXISTS `pc01_categories`;
CREATE TABLE `pc01_categories` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` text,
  `order_type_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pc01_categories_on_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pc01_categories`
--

LOCK TABLES `pc01_categories` WRITE;
/*!40000 ALTER TABLE `pc01_categories` DISABLE KEYS */;
INSERT INTO `pc01_categories` VALUES (1,'Workstation (Standard)',NULL,3),(2,'Laptop (Standard)',NULL,3),(3,'Workstation (High End)',NULL,3),(4,'Cables/Supplies',NULL,6),(5,'Misc. Peripheral',NULL,5),(6,'Software',NULL,4),(7,'Dell Printer (Standard)',NULL,3),(8,'Dell Color Printer (Standard)',NULL,3),(9,'Dell Printer (High End)',NULL,3),(10,'Dell Color Printer (High End)',NULL,3),(11,'Flat Panel (Standard)',NULL,3),(12,'Flat Panel (Large/High End)',NULL,3),(13,'Misc. Hardware',NULL,3),(14,'Software License',NULL,4),(17,'Server Hardware',NULL,1),(18,'Network Hardware',NULL,2),(19,'Fax Machine (Low End)',NULL,5),(20,'Fax Machine (High End)',NULL,5),(21,'Dell MFU ','Multi-function Unit (MFU)',3),(22,'MFU ','Multi-Function Unit (MFU)',5),(23,'Scanner',NULL,5),(24,'Dell Peripherals','Accessories/Peripherals ',3),(25,'Printer (Standard)',NULL,5),(26,'Color Printer (Standard)',NULL,5),(27,'Color Printer (High End) ',NULL,5),(28,'Printer (High End) ',NULL,5),(29,'Software Maintenance',NULL,4);
/*!40000 ALTER TABLE `pc01_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc01_items`
--

DROP TABLE IF EXISTS `pc01_items`;
CREATE TABLE `pc01_items` (
  `id` int(11) NOT NULL auto_increment,
  `pc01_id` int(4) default NULL,
  `pc01_category_id` int(4) default NULL,
  `description` text,
  `is_stock_item` tinyint(1) default NULL,
  `is_fullfilled` tinyint(1) default NULL,
  `is_replenished` tinyint(1) default NULL,
  `quantity` int(11) default NULL,
  `is_charge_back` tinyint(1) default NULL,
  `replenished_on` date default NULL,
  `charge_back_amount` decimal(10,2) default NULL,
  `is_true_up` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pc01_items_on_pc01_id` (`pc01_id`),
  KEY `index_pc01_items_on_pc01_category_id` (`pc01_category_id`),
  KEY `index_pc01_items_on_is_stock_item` (`is_stock_item`),
  KEY `index_pc01_items_on_is_fullfilled` (`is_fullfilled`),
  KEY `index_pc01_items_on_is_replenished` (`is_replenished`),
  KEY `index_pc01_items_on_is_charge_back` (`is_charge_back`),
  KEY `index_pc01_items_on_is_true_up` (`is_true_up`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pc01_items`
--

LOCK TABLES `pc01_items` WRITE;
/*!40000 ALTER TABLE `pc01_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc01_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pc01s`
--

DROP TABLE IF EXISTS `pc01s`;
CREATE TABLE `pc01s` (
  `id` int(11) NOT NULL auto_increment,
  `pc01_number` int(11) default NULL,
  `pc01_dated` date default NULL,
  `received_on` date default NULL,
  `approved_on` date default NULL,
  `approved_by` int(4) default NULL,
  `service_request` varchar(255) default NULL,
  `submitted_by` int(4) default NULL,
  `location_id` int(4) default NULL,
  `description` text,
  `management_center` varchar(255) default NULL,
  `is_completed` tinyint(1) default NULL,
  `created_on` datetime default NULL,
  `department_id` int(11) default NULL,
  `assigned_users` text,
  `budget_year` int(11) default NULL,
  `fund_code` int(11) default NULL,
  `work_order` varchar(255) default NULL,
  `budget_code` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pc01s_on_pc01_number` (`pc01_number`),
  KEY `index_pc01s_on_received_on` (`received_on`),
  KEY `index_pc01s_on_approved_on` (`approved_on`),
  KEY `index_pc01s_on_submitted_by` (`submitted_by`),
  KEY `index_pc01s_on_location_id` (`location_id`),
  KEY `index_pc01s_on_department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pc01s`
--

LOCK TABLES `pc01s` WRITE;
/*!40000 ALTER TABLE `pc01s` DISABLE KEYS */;
/*!40000 ALTER TABLE `pc01s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_types`
--

DROP TABLE IF EXISTS `phone_types`;
CREATE TABLE `phone_types` (
  `id` int(11) NOT NULL auto_increment,
  `phone_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_phone_types_on_phone_type` (`phone_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phone_types`
--

LOCK TABLES `phone_types` WRITE;
/*!40000 ALTER TABLE `phone_types` DISABLE KEYS */;
INSERT INTO `phone_types` VALUES (3,'Fax'),(4,'Home'),(1,'Mobile'),(5,'SPID'),(2,'Work');
/*!40000 ALTER TABLE `phone_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
CREATE TABLE `phones` (
  `id` int(11) NOT NULL auto_increment,
  `number` varchar(255) default NULL,
  `phone_type_id` int(4) default NULL,
  `phonable_id` int(4) default NULL,
  `phonable_type` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_phones_on_phone_type_id` (`phone_type_id`),
  KEY `phonable_index` (`phonable_id`,`phonable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_lines`
--

DROP TABLE IF EXISTS `pp_lines`;
CREATE TABLE `pp_lines` (
  `id` int(11) NOT NULL auto_increment,
  `circuit_id` int(4) default NULL,
  `subnet_id` int(4) default NULL,
  `map_reference` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pp_lines_on_circuit_id` (`circuit_id`),
  KEY `index_pp_lines_on_subnet_id` (`subnet_id`),
  KEY `index_pp_lines_on_map_reference` (`map_reference`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pp_lines`
--

LOCK TABLES `pp_lines` WRITE;
/*!40000 ALTER TABLE `pp_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_daemon_types`
--

DROP TABLE IF EXISTS `print_daemon_types`;
CREATE TABLE `print_daemon_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `print_daemon_types`
--

LOCK TABLES `print_daemon_types` WRITE;
/*!40000 ALTER TABLE `print_daemon_types` DISABLE KEYS */;
INSERT INTO `print_daemon_types` VALUES (1,'LPD','Line Printer Daemon'),(2,'Mainframe','Mainframe U Printer'),(4,'Windows',NULL),(5,'NetWare NDPS',NULL),(6,'NetWare iPrint',NULL),(7,'CUPS',NULL);
/*!40000 ALTER TABLE `print_daemon_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `print_daemons`
--

DROP TABLE IF EXISTS `print_daemons`;
CREATE TABLE `print_daemons` (
  `id` int(11) NOT NULL auto_increment,
  `print_daemon_type_id` int(4) default NULL,
  `server_id` int(4) default NULL,
  `printer_id` int(4) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `print_daemons`
--

LOCK TABLES `print_daemons` WRITE;
/*!40000 ALTER TABLE `print_daemons` DISABLE KEYS */;
/*!40000 ALTER TABLE `print_daemons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `priorities`
--

DROP TABLE IF EXISTS `priorities`;
CREATE TABLE `priorities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `value` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_priorities_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `priorities`
--

LOCK TABLES `priorities` WRITE;
/*!40000 ALTER TABLE `priorities` DISABLE KEYS */;
INSERT INTO `priorities` VALUES (1,'High',1),(2,'Medium',5),(3,'Low',10);
/*!40000 ALTER TABLE `priorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_families`
--

DROP TABLE IF EXISTS `product_families`;
CREATE TABLE `product_families` (
  `id` int(11) NOT NULL auto_increment,
  `manufacturer_id` int(4) default NULL,
  `name` varchar(255) default NULL,
  `alias` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_product_families_on_vendor_id` (`manufacturer_id`),
  KEY `index_product_families_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_families`
--

LOCK TABLES `product_families` WRITE;
/*!40000 ALTER TABLE `product_families` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_properties`
--

DROP TABLE IF EXISTS `product_properties`;
CREATE TABLE `product_properties` (
  `id` int(11) NOT NULL auto_increment,
  `product_id` int(11) default NULL,
  `property_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_product_properties_on_product_id` (`product_id`),
  KEY `index_product_properties_on_property_id` (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_properties`
--

LOCK TABLES `product_properties` WRITE;
/*!40000 ALTER TABLE `product_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL auto_increment,
  `device_class_id` int(11) default NULL,
  `architecture_id` int(11) default NULL,
  `model_number` varchar(255) default NULL,
  `part_number` varchar(255) default NULL,
  `spare_number` varchar(255) default NULL,
  `description` text,
  `detailed` tinyint(1) default NULL,
  `name` varchar(255) default NULL,
  `product_family_id` int(11) default NULL,
  `full_name` text,
  `power_consumption` int(11) default NULL,
  `heat_output` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_products_on_device_class_id` (`device_class_id`),
  KEY `index_products_on_architecture_id` (`architecture_id`),
  KEY `index_products_on_product_family_id` (`product_family_id`),
  KEY `index_products_on_name` (`name`),
  KEY `index_products_on_detailed` (`detailed`),
  KEY `index_products_on_model_number` (`model_number`),
  KEY `index_products_on_part_number` (`part_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_statuses`
--

DROP TABLE IF EXISTS `project_statuses`;
CREATE TABLE `project_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `value` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_project_statuses_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_statuses`
--

LOCK TABLES `project_statuses` WRITE;
/*!40000 ALTER TABLE `project_statuses` DISABLE KEYS */;
INSERT INTO `project_statuses` VALUES (1,'Not Started',0),(2,'Pending',1),(3,'In Progress',2),(4,'Complete',3),(5,'Cancelled',5);
/*!40000 ALTER TABLE `project_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_types`
--

DROP TABLE IF EXISTS `project_types`;
CREATE TABLE `project_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `abbreviation` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_project_types_on_name` (`name`),
  KEY `index_project_types_on_abbreviation` (`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_types`
--

LOCK TABLES `project_types` WRITE;
/*!40000 ALTER TABLE `project_types` DISABLE KEYS */;
INSERT INTO `project_types` VALUES (1,'Major Project',NULL,'PN'),(2,'White Board Project',NULL,'WB'),(3,'Stock Tracking',NULL,'ST');
/*!40000 ALTER TABLE `project_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_updates`
--

DROP TABLE IF EXISTS `project_updates`;
CREATE TABLE `project_updates` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(4) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `created_by` varchar(255) default NULL,
  `body` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_updates`
--

LOCK TABLES `project_updates` WRITE;
/*!40000 ALTER TABLE `project_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` text,
  `comments` text,
  `created_by` varchar(255) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `project_number` int(11) default NULL,
  `project_status` int(11) default NULL,
  `manager_id` int(11) default NULL,
  `department_id` int(11) default NULL,
  `requestor_id` int(11) default NULL,
  `priority` int(11) default NULL,
  `started_on` date default NULL,
  `completed_on` date default NULL,
  `estimated_completion` varchar(255) default NULL,
  `lead_engineer_id` int(11) default NULL,
  `project_type_id` int(11) default NULL,
  `project_status_id` int(11) default NULL,
  `priority_id` int(11) default NULL,
  `requested_on` date default NULL,
  `old_project_number` varchar(255) default NULL,
  `service_request` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_projects_on_title` (`title`),
  KEY `index_projects_on_manager_id` (`manager_id`),
  KEY `index_projects_on_department_id` (`department_id`),
  KEY `index_projects_on_requestor_id` (`requestor_id`),
  KEY `index_projects_on_priority` (`priority`),
  KEY `index_projects_on_engineer_id` (`lead_engineer_id`),
  KEY `index_projects_on_project_type_id` (`project_type_id`),
  KEY `index_projects_on_project_status_id` (`project_status_id`),
  KEY `index_projects_on_priority_id` (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `unit` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_properties_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'Memory','MB'),(2,'Memory','GB');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `received_items`
--

DROP TABLE IF EXISTS `received_items`;
CREATE TABLE `received_items` (
  `id` int(11) NOT NULL auto_increment,
  `received_on` datetime default NULL,
  `receiver_id` int(4) default NULL,
  `requisition_item_id` int(4) default NULL,
  `quantity` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_received_items_on_received_on` (`received_on`),
  KEY `index_received_items_on_receiver_id` (`receiver_id`),
  KEY `index_received_items_on_requisition_item_id` (`requisition_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `received_items`
--

LOCK TABLES `received_items` WRITE;
/*!40000 ALTER TABLE `received_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `received_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_tasks`
--

DROP TABLE IF EXISTS `related_tasks`;
CREATE TABLE `related_tasks` (
  `id` int(11) NOT NULL auto_increment,
  `task_id` int(4) default NULL,
  `related_task_id` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_related_tasks_on_task_id` (`task_id`),
  KEY `index_related_tasks_on_related_task_id` (`related_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `related_tasks`
--

LOCK TABLES `related_tasks` WRITE;
/*!40000 ALTER TABLE `related_tasks` DISABLE KEYS */;
INSERT INTO `related_tasks` VALUES (1,45,22),(2,47,45),(3,45,47),(4,48,47),(5,48,45),(6,47,48),(7,49,48),(8,49,47),(9,49,50),(10,22,26),(11,22,45),(12,46,14),(13,46,37),(14,47,49),(15,50,48),(16,50,45),(17,50,47),(18,51,50),(19,51,47),(20,51,48),(21,53,52),(22,9,15),(23,51,45),(24,47,51),(25,47,50),(26,66,65),(27,68,47),(28,68,45),(29,69,68),(30,68,69),(31,71,37),(32,71,26),(33,NULL,37),(34,NULL,71),(35,26,37),(36,26,71),(37,45,68),(38,47,68),(39,72,68),(40,73,34),(41,78,34),(42,79,52),(43,80,34),(44,81,40),(45,85,84),(46,84,85),(47,87,86),(48,89,88),(49,90,88),(50,90,89),(51,89,90),(52,88,90),(53,88,89),(54,93,45),(55,95,43),(56,43,95),(57,98,85),(58,98,84),(59,100,45),(60,45,100),(61,120,119),(62,126,123),(63,24,126);
/*!40000 ALTER TABLE `related_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` text,
  `model` varchar(255) default NULL,
  `filters` text,
  `action` varchar(255) default NULL,
  `controller` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_reports_on_title` (`title`),
  KEY `index_reports_on_action` (`action`),
  KEY `index_reports_on_controller` (`controller`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,'Closed Orders - Detailed','Orders that have been closed','order','start_date\nend_date\nrequestor\norder_type','closed_detail','ordering'),(2,'Order Aging - Detailed','Orders that are not closed (default 60 days)','order','number_days_old\norder_type\nrequestor','aging','ordering'),(3,'Outstanding Items - Detailed','Items not received yet','order','number_days_old','outstanding_items','ordering'),(4,'Requisition Items - Detailed',NULL,'order','order_type\nstart_date\nend_date\nproduct','req_item_detail','ordering'),(5,'Subnet - Detailed','Detailed subnet report','ipv4_interface','ipv4_subnet[report_label],subnet_address_packed','subnet_detail','network'),(6,'Subnet List - Summary','List of subnets, including network address and description','subnet','network_class\ntopology','subnet_summary','network'),(7,'Orders by Manager - Detailed','Orders by Manager YTD (default)','order','start_date\nend_date\norder_status\norder_type','orders_by_manager','ordering'),(8,'Point-to-Point Circuits - Summary',NULL,'circuit',NULL,'p2p_circuit','circuit'),(9,'Multi-Point Circuits - Summary',NULL,'mp_pvc',NULL,'mp_mapping','circuit'),(10,'Dial Line Circuits - Summary',NULL,'dial_line',NULL,'dial_circuit','circuit'),(11,'IP Aging','List of address by last date pinged','ipv4_interface','number_days_ago','ip_aging','network'),(12,'Project Tracker',NULL,'project','priority\nproject_status\nmanager[last_first_label],last_name\nlead_engineer[last_first_label],last_name','project_tracker','projecting'),(13,'Whiteboard',NULL,'project','project_status\npriority\nmanager[last_first_label],last_name\nlead_engineer[last_first_label],last_name','whiteboard','projecting'),(14,'Project Updates','Brief list of projects with most recent update','project','project_type\npriority\nproject_status\nmanager[last_first_label],last_name\nlead_engineer[last_first_label],last_name','project_updates','projecting'),(15,'Project Details','Detailed project report including all project updates','project_update','project','project_detail','projecting'),(16,'Server List','Server list, selecting operating system will also select all descendant operating systems','server','operating_system','server_list','network');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisition_items`
--

DROP TABLE IF EXISTS `requisition_items`;
CREATE TABLE `requisition_items` (
  `id` int(11) NOT NULL auto_increment,
  `requisition_id` int(4) default NULL,
  `order_item_id` int(4) default NULL,
  `quantity` int(4) default NULL,
  `unit_price` decimal(10,2) default NULL,
  `details` text,
  PRIMARY KEY  (`id`),
  KEY `index_requisition_items_on_requisition_id` (`requisition_id`),
  KEY `index_requisition_items_on_order_item_id` (`order_item_id`),
  KEY `index_requisition_items_on_quantity` (`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requisition_items`
--

LOCK TABLES `requisition_items` WRITE;
/*!40000 ALTER TABLE `requisition_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `requisition_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisition_statuses`
--

DROP TABLE IF EXISTS `requisition_statuses`;
CREATE TABLE `requisition_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `value` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_requisition_statuses_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requisition_statuses`
--

LOCK TABLES `requisition_statuses` WRITE;
/*!40000 ALTER TABLE `requisition_statuses` DISABLE KEYS */;
INSERT INTO `requisition_statuses` VALUES (1,'Initial',0),(2,'Created',1),(3,'Bidding',2),(4,'Awarded',3),(5,'Purchased',4),(6,'Shipping',5),(7,'Closed',6);
/*!40000 ALTER TABLE `requisition_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisitions`
--

DROP TABLE IF EXISTS `requisitions`;
CREATE TABLE `requisitions` (
  `id` int(11) NOT NULL auto_increment,
  `requisitioned_on` date default NULL,
  `requisition_number` varchar(255) default NULL,
  `purchase_order` varchar(255) default NULL,
  `vendor_id` int(4) default NULL,
  `requisition_status_old` int(11) default NULL,
  `processor_id` int(11) default NULL,
  `purchased_on` date default NULL,
  `created_on` date default NULL,
  `sent_emails` tinyint(1) default NULL,
  `awarded_on` date default NULL,
  `management_center` varchar(255) default NULL,
  `budget_account` varchar(255) default NULL,
  `price_quote_number` varchar(255) default NULL,
  `due_by` datetime default NULL,
  `deliver_by` date default NULL,
  `release_number` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  `is_pcard_purchase` tinyint(1) default NULL,
  `requisition_status_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_requisitions_on_requisitioned_on` (`requisitioned_on`),
  KEY `index_requisitions_on_requisition_number` (`requisition_number`),
  KEY `index_requisitions_on_purchase_order` (`purchase_order`),
  KEY `index_requisitions_on_vendor_id` (`vendor_id`),
  KEY `index_requisitions_on_requisition_status_id` (`requisition_status_id`),
  KEY `index_requisitions_on_processor_id` (`processor_id`),
  KEY `index_requisitions_on_release_number` (`release_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requisitions`
--

LOCK TABLES `requisitions` WRITE;
/*!40000 ALTER TABLE `requisitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `requisitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `flag` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_roles_on_name` (`name`),
  KEY `index_roles_on_flag` (`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Network Engineer','Assigns and administers networks ','network_administrator'),(2,'Application Administrator','Configures application backend information like roles, and menus','application_administrator'),(3,'Purchase Requestor','Open and close orders','purchase_requestor'),(4,'Purchase Approver','Approve and edit orders','purchase_approver'),(5,'Purchase Processor','Process orders, created and edit requisitions','purchase_processor'),(6,'Application User','Assigns access to the basic functions','application_user'),(7,'System Engineer','Manage inventory and devices (including IP requests)','system_engineer'),(8,'Manager',NULL,'manager');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_tasks`
--

DROP TABLE IF EXISTS `roles_tasks`;
CREATE TABLE `roles_tasks` (
  `role_id` int(4) default NULL,
  `task_id` int(4) default NULL,
  KEY `index_roles_tasks_on_role_id` (`role_id`),
  KEY `index_roles_tasks_on_task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles_tasks`
--

LOCK TABLES `roles_tasks` WRITE;
/*!40000 ALTER TABLE `roles_tasks` DISABLE KEYS */;
INSERT INTO `roles_tasks` VALUES (2,2),(6,46),(6,23),(6,41),(6,6),(1,38),(2,53),(2,56),(5,57),(5,58),(4,59),(5,60),(6,64),(1,66),(2,67),(5,70),(5,72),(1,76),(1,82),(7,82),(1,87),(1,88),(1,86),(1,91),(2,92),(2,93),(4,93),(5,93),(6,75),(7,76),(5,50),(3,99),(4,99),(5,99),(5,100),(6,109),(6,110),(8,111),(8,112),(8,113),(6,114),(6,115),(8,116),(8,117),(8,118),(1,121),(7,121),(8,121),(1,125),(7,125),(1,126),(7,126),(6,127),(8,128),(8,129),(8,130),(7,131),(1,131),(8,82);
/*!40000 ALTER TABLE `roles_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
CREATE TABLE `roles_users` (
  `user_id` int(4) default NULL,
  `role_id` int(4) default NULL,
  KEY `index_roles_users_on_user_id` (`user_id`),
  KEY `index_roles_users_on_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (127);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('127');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_statuses`
--

DROP TABLE IF EXISTS `service_statuses`;
CREATE TABLE `service_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `value` int(4) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_service_statuses_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_statuses`
--

LOCK TABLES `service_statuses` WRITE;
/*!40000 ALTER TABLE `service_statuses` DISABLE KEYS */;
INSERT INTO `service_statuses` VALUES (1,'Test',NULL,NULL),(2,'QA',NULL,NULL),(3,'Development',NULL,NULL),(4,'Production',NULL,NULL);
/*!40000 ALTER TABLE `service_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_services_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Web Server',NULL),(2,'Database',NULL),(3,'Application Server',NULL),(4,'File Server',NULL),(5,'Print Server',NULL),(6,'File & Print Server',NULL),(7,'Email Server',NULL),(8,'Backup Server',NULL),(9,'File Transfer Server',NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `abbr` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_states_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (3,'Alabama','AL\r\n'),(4,'Alaska','AK\r\n'),(5,'Arizona','AZ\r\n'),(6,'Arkansas','AR\r\n'),(7,'California','CA\r\n'),(8,'Colorado','CO\r\n'),(9,'Connecticut','CT\r\n'),(10,'Delaware','DE\r\n'),(11,'Florida','FL\r\n'),(12,'Georgia','GA\r\n'),(13,'Hawaii','HI\r\n'),(14,'Idaho','ID\r\n'),(15,'Illinois','IL\r\n'),(16,'Indiana','IN\r\n'),(17,'Iowa','IA\r\n'),(18,'Kansas','KS\r\n'),(19,'Kentucky','KY\r\n'),(20,'Louisiana','LA\r\n'),(21,'Maine','ME\r\n'),(22,'Maryland','MD\r\n'),(23,'Massachusetts','MA\r\n'),(24,'Michigan','MI\r\n'),(25,'Minnesota','MN\r\n'),(26,'Mississippi','MS\r\n'),(27,'Missouri','MO\r\n'),(28,'Montana','MT\r\n'),(29,'Nebraska','NE\r\n'),(30,'Nevada','NV\r\n'),(31,'New Hampshire','NH\r\n'),(32,'New Jersey','NJ\r\n'),(33,'New Mexico','NM\r\n'),(34,'New York','NY\r\n'),(35,'North Carolina','NC\r\n'),(36,'North Dakota','ND\r\n'),(37,'Ohio','OH\r\n'),(38,'Oklahoma','OK\r\n'),(39,'Oregon','OR\r\n'),(40,'Pennsylvania','PA\r\n'),(41,'Rhode Island','RI\r\n'),(42,'South Carolina','SC\r\n'),(43,'South Dakota','SD\r\n'),(44,'Tennessee','TN\r\n'),(45,'Texas','TX\r\n'),(46,'Utah','UT\r\n'),(47,'Vermont','VT\r\n'),(48,'Virginia','VA\r\n'),(49,'Washington','WA\r\n'),(50,'West Virginia','WV\r\n'),(51,'Wisconsin','WI\r\n'),(52,'Wyoming','WY\r\n');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnets`
--

DROP TABLE IF EXISTS `subnets`;
CREATE TABLE `subnets` (
  `id` int(11) NOT NULL auto_increment,
  `description` text,
  `date_installed` date default NULL,
  `network_class_id` int(11) default NULL,
  `topology_id` int(11) default NULL,
  `is_delinquent` tinyint(1) default NULL,
  `is_stealth` tinyint(1) default NULL,
  `is_reserved` tinyint(1) default NULL,
  `vlanid` int(11) default NULL,
  `is_private` tinyint(1) default NULL,
  `is_local` tinyint(1) default NULL,
  `virtual_lan_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_subnets_on_network_class_id` (`network_class_id`),
  KEY `index_subnets_on_topology_id` (`topology_id`),
  KEY `index_subnets_on_vlanid` (`vlanid`),
  KEY `index_subnets_on_virtual_lan_id` (`virtual_lan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subnets`
--

LOCK TABLES `subnets` WRITE;
/*!40000 ALTER TABLE `subnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `description` text,
  `url` varchar(255) default NULL,
  `task_group_id` int(4) default NULL,
  `parent_id` int(11) default NULL,
  `action` varchar(255) default NULL,
  `controller` varchar(255) default NULL,
  `hidden` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_tasks_on_title` (`title`),
  KEY `index_tasks_on_parent_id` (`parent_id`),
  KEY `index_tasks_on_task_group_id` (`task_group_id`),
  KEY `index_tasks_on_action` (`action`),
  KEY `index_tasks_on_controller` (`controller`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (2,'Admin','Administrative Tasks',NULL,NULL,NULL,NULL,NULL,NULL),(3,'Lookup tables','Manage the mostly static lookup table data',NULL,NULL,2,NULL,NULL,0),(4,'Device Classes',NULL,NULL,NULL,3,'list','/admin/device_class',NULL),(5,'Tasks','Manage tasks',NULL,NULL,19,'list','/admin/task',NULL),(6,'Wizards',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'Departments',NULL,NULL,NULL,54,'list','/admin/department',0),(10,'Roles',NULL,NULL,NULL,19,'list','/admin/role',NULL),(12,'States',NULL,NULL,NULL,54,'list','/admin/state',0),(13,'Network Classes',NULL,NULL,NULL,3,'list','/admin/network_class',NULL),(14,'Companies','Manage employers, vendors and manufacturers',NULL,NULL,23,'list','/company',NULL),(15,'Contacts',NULL,NULL,NULL,54,'list','/admin/contact',0),(18,'Locations',NULL,NULL,NULL,54,'list','/admin/location',0),(19,'Security',NULL,NULL,NULL,2,NULL,NULL,NULL),(20,'Topologies',NULL,NULL,NULL,3,'list','/admin/topology',NULL),(21,'Users',NULL,NULL,NULL,19,'list','/admin/user',NULL),(22,'Products','Manage products',NULL,NULL,23,'list','/product',NULL),(23,'Manage',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,'All Devices',NULL,NULL,NULL,123,'list','/device',0),(26,'Equipment',NULL,NULL,NULL,97,'list','/equipment',0),(27,'Line Speeds',NULL,NULL,NULL,3,'list','/admin/line_speed',NULL),(28,'Phone Types',NULL,NULL,NULL,3,'list','/admin/phone_type',NULL),(34,'Subnets',NULL,NULL,NULL,76,'list','/subnet',0),(37,'Locations',NULL,NULL,NULL,23,'list','/location',NULL),(38,'Circuits',NULL,NULL,NULL,76,NULL,NULL,0),(39,'Addresses','Street Address',NULL,NULL,54,'list','/admin/address',0),(40,'Circuit Types',NULL,NULL,NULL,3,'list','/admin/circuit_type',NULL),(41,'Reports',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,'Domains','Domain Name System',NULL,NULL,76,'list','/domain',0),(45,'Orders','Manager orders',NULL,NULL,96,'list','/order',0),(46,'Contacts',NULL,NULL,NULL,23,'list','/contact',NULL),(47,'Requisitions','Process and fullfill orders',NULL,NULL,96,'list','/requisition',0),(48,'Receive Items','Receipt for items that have been ordered and delivered',NULL,NULL,45,'receipt','/received_item',1),(49,'Received Items','List of items received',NULL,NULL,96,'list','/received_item',0),(50,'Distribute Items',NULL,NULL,NULL,96,'distribute','/distributed_item',1),(51,'Distributed Items','Items that have been distributed',NULL,NULL,96,'list','/distributed_item',0),(52,'IPv4 Assignments','IP subnet assignements based on network class and topology',NULL,NULL,54,'list','/admin/ipv4_assignment',0),(53,'Ipv4 Assigned Networks','Networks assigned to the organization',NULL,NULL,54,'list','/admin/ipv4_assigned_network',0),(54,'Manage data','Manage special data tables',NULL,NULL,2,NULL,NULL,0),(55,'Zones','Network zone data',NULL,NULL,54,'list','/admin/zone',0),(56,'Audit Log','View Audit Log',NULL,NULL,19,'list','/admin/audit',0),(57,'Edit Requisition',NULL,NULL,NULL,96,'edit','/requisition',1),(58,'Request Bits',NULL,NULL,NULL,47,'request_bid','/requisition',1),(59,'Approve Order',NULL,NULL,NULL,45,'approve','/order',1),(60,'Process Requisition',NULL,NULL,NULL,45,'requisition','/order',1),(61,'Order Types',NULL,NULL,NULL,3,'list','/admin/order_type',0),(62,'Orders','Administrative access to orders',NULL,NULL,54,'list','/admin/order',0),(63,'Requisitions','Administrative access to requisitions',NULL,NULL,54,'list','/admin/requisition',0),(64,'Projects',NULL,NULL,NULL,23,NULL,NULL,0),(65,'Wireless Output Filters',NULL,NULL,NULL,54,'list','/admin/wireless_output_filter',0),(66,'Wireless Interfaces','Provide access to wireless network based on MAC address',NULL,NULL,76,'list','/wireless_interface',0),(67,'Equipment Status',NULL,NULL,NULL,3,'list','/admin/equipment_status',0),(68,'PC01s',NULL,NULL,NULL,96,'list','/pc01',0),(69,'PC01 Categories',NULL,NULL,NULL,68,'list','/pc01_category',0),(70,'Order',NULL,NULL,NULL,68,'order','/pc01',1),(71,'Inventory',NULL,NULL,NULL,97,'list','/inventory',0),(72,'Process Charge Backs',NULL,NULL,NULL,68,'charge_back','/pc01',1),(73,'Virtual LANs','Manage VLANs',NULL,NULL,76,'list','/virtual_lan',0),(74,'Reports',NULL,NULL,NULL,54,'list','/admin/report',NULL),(75,'Orders',NULL,NULL,NULL,41,'ordering','/report',0),(76,'Networks',NULL,NULL,NULL,23,NULL,NULL,0),(77,'DHCP Scope Options',NULL,NULL,NULL,54,'list','/admin/ipv4_scope_option',0),(78,'DHCP Scopes','IPv4  DHCP Scopes',NULL,NULL,76,'list','/ipv4_scope',1),(79,'IPv4 Schema Rules',NULL,NULL,NULL,54,'list','/admin/ipv4_schema_rule',0),(80,'Virtual Hosts','IPv4 Virtual Hosts',NULL,NULL,76,'list','/ipv4_virtual_host',0),(81,'Line Types',NULL,NULL,NULL,3,'list','/admin/line_type',0),(82,'Networks',NULL,NULL,NULL,41,'network','/report',0),(83,'IP Address',NULL,NULL,NULL,6,NULL,NULL,0),(84,'Get new address',NULL,NULL,NULL,83,'get_new_address','/device',0),(85,'Give up address',NULL,NULL,NULL,83,'relinquish_address','/device',0),(86,'Point-to-Point Lines',NULL,NULL,NULL,38,'list','/pp_line',0),(87,'Dial Lines',NULL,NULL,NULL,38,'list','/dial_line',0),(88,'Multi-Point Lines',NULL,NULL,NULL,38,'list','/mp_line',0),(89,'Device Mappings','DLCI Mappings',NULL,NULL,88,'list','/mp_dlci',0),(90,'Line Mappings','PVC Mappings',NULL,NULL,88,'list','/mp_pvc',0),(91,'Delete',NULL,NULL,NULL,34,'delete','/subnet',1),(92,'Virtual Host Types',NULL,NULL,NULL,3,'list','/admin/virtual_host_type',0),(93,'Budget',NULL,NULL,NULL,96,'list','/order_budget',0),(94,'Link Categories',NULL,NULL,NULL,3,'list','/admin/link_category',0),(95,'Domain Name Entries',NULL,NULL,NULL,76,'list','/domain_name',0),(96,'Procurement',NULL,NULL,NULL,23,NULL,NULL,0),(97,'Hardware',NULL,NULL,NULL,23,NULL,NULL,0),(98,'Auto-Assign Multiple Addresses',NULL,NULL,NULL,83,'get_new_addresses','/device',0),(99,'Create Order',NULL,NULL,NULL,45,'new','/order',1),(100,'Closeout','Permanently close an order',NULL,NULL,45,'closeout','/order',1),(101,'Properties',NULL,NULL,NULL,3,'list','/admin/property',0),(102,'Priorities',NULL,NULL,NULL,3,'list','/admin/priority',0),(103,'Project Status',NULL,NULL,NULL,3,'list','/admin/project_status',0),(104,'Project Type',NULL,NULL,NULL,3,'list','/admin/project_type',0),(105,'Projects',NULL,NULL,NULL,54,'list','/admin/project',0),(109,'Project Tracker','Major Projects',NULL,NULL,64,'list','/project_tracker',0),(110,'Whiteboard','Whiteboard projects',NULL,NULL,64,'list','/project_whiteboard',0),(111,'Create',NULL,NULL,NULL,110,'new','/project_whiteboard',1),(112,'Delete',NULL,NULL,NULL,110,'destroy','/project_whiteboard',1),(113,'Edit',NULL,NULL,NULL,110,'edit','/project_whiteboard',1),(114,'Projects',NULL,NULL,NULL,41,'projecting','/report',0),(115,'show',NULL,NULL,NULL,109,'show','/project_tracker',1),(116,'Create',NULL,NULL,NULL,109,'new','/project_tracker',1),(117,'Delete',NULL,NULL,NULL,109,'destroy','/project_tracker',1),(118,'Edit',NULL,NULL,NULL,109,'edit','/project_tracker',1),(119,'Service Status',NULL,NULL,NULL,3,'list','/admin/service_status',0),(120,'Services',NULL,NULL,NULL,54,'list','/admin/service',0),(121,'Applications',NULL,NULL,NULL,23,'list','/app',0),(122,'Servers',NULL,NULL,NULL,123,'list','/server',0),(123,'Devices',NULL,NULL,NULL,23,NULL,NULL,0),(124,'Print Daemon Types',NULL,NULL,NULL,3,'list','/admin/print_daemon_type',0),(125,'Printers',NULL,NULL,NULL,123,'list','/printer',0),(126,'Process IP Aging',NULL,NULL,NULL,123,'aging_cleanup','/device',1),(127,'List',NULL,NULL,NULL,64,'list','/project',1),(128,'Create',NULL,NULL,NULL,64,'new','/project',1),(129,'Delete',NULL,NULL,NULL,64,'destroy','/project',1),(130,'Edit',NULL,NULL,NULL,64,'edit','/project',1),(131,'Operating Systems',NULL,NULL,NULL,123,'list','/operating_system',0);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topologies`
--

DROP TABLE IF EXISTS `topologies`;
CREATE TABLE `topologies` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `old_topology_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_topologies_on_parent_id` (`parent_id`),
  KEY `index_topologies_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topologies`
--

LOCK TABLES `topologies` WRITE;
/*!40000 ALTER TABLE `topologies` DISABLE KEYS */;
INSERT INTO `topologies` VALUES (13,NULL,'Ethernet','10 Mbps Ethernet',1),(14,13,'Fast Ethernet','100 Mbps Ethernet',2),(15,13,'Gigabit Ethernet','1 Gbps Ethernet',3),(16,13,'Wireless',NULL,NULL),(17,16,'802.11b',NULL,NULL),(18,16,'802.11g',NULL,NULL),(19,16,'802.11a',NULL,NULL),(20,NULL,'Point-to-Point',NULL,6),(21,NULL,'Frame Relay',NULL,7),(22,NULL,'ATM',NULL,10),(23,NULL,'Token Ring',NULL,4),(24,NULL,'Fibre Channel',NULL,NULL),(25,13,'Switched Ethernet','10/100/1000 Switched Ethernet',5),(26,NULL,'CDMA','Wireless WAN 1xRTT and 1xEVDO, etc',8);
/*!40000 ALTER TABLE `topologies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `dn` varchar(255) default NULL,
  `contact_id` int(4) default NULL,
  `last_login` datetime default NULL,
  `default_action` varchar(255) default NULL,
  `default_controller` varchar(255) default NULL,
  `logged_in` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_users_on_username` (`username`),
  KEY `index_users_on_contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_host_types`
--

DROP TABLE IF EXISTS `virtual_host_types`;
CREATE TABLE `virtual_host_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_virtual_host_types_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `virtual_host_types`
--

LOCK TABLES `virtual_host_types` WRITE;
/*!40000 ALTER TABLE `virtual_host_types` DISABLE KEYS */;
INSERT INTO `virtual_host_types` VALUES (1,'Virtual Router','VRRP or HSRP Virtual Router'),(2,'Load Balanced VIP',NULL);
/*!40000 ALTER TABLE `virtual_host_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_lans`
--

DROP TABLE IF EXISTS `virtual_lans`;
CREATE TABLE `virtual_lans` (
  `id` int(11) NOT NULL auto_increment,
  `vlanid` int(4) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  `is_private` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_virtual_lans_on_vlanid` (`vlanid`),
  KEY `index_virtual_lans_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `virtual_lans`
--

LOCK TABLES `virtual_lans` WRITE;
/*!40000 ALTER TABLE `virtual_lans` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtual_lans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wireless_interfaces`
--

DROP TABLE IF EXISTS `wireless_interfaces`;
CREATE TABLE `wireless_interfaces` (
  `id` int(11) NOT NULL auto_increment,
  `contact_id` int(4) default NULL,
  `interface_id` int(4) default NULL,
  `is_enabled` tinyint(1) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `description` text,
  `expires_on` date default NULL,
  `hardware_address` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_wireless_interfaces_on_contact_id` (`contact_id`),
  KEY `index_wireless_interfaces_on_interface_id` (`interface_id`),
  KEY `index_wireless_interfaces_on_is_enabled` (`is_enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wireless_interfaces`
--

LOCK TABLES `wireless_interfaces` WRITE;
/*!40000 ALTER TABLE `wireless_interfaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `wireless_interfaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wireless_output_filters`
--

DROP TABLE IF EXISTS `wireless_output_filters`;
CREATE TABLE `wireless_output_filters` (
  `id` int(11) NOT NULL auto_increment,
  `title` text,
  `description` text,
  `is_active` tinyint(1) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `output_filter` text,
  PRIMARY KEY  (`id`),
  KEY `index_wireless_output_filters_on_is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wireless_output_filters`
--

LOCK TABLES `wireless_output_filters` WRITE;
/*!40000 ALTER TABLE `wireless_output_filters` DISABLE KEYS */;
INSERT INTO `wireless_output_filters` VALUES (1,'WG302','Older Netgear WAPs',1,'2007-07-02 11:13:18','2009-06-30 10:15:37','i.hardware_address.downcase + \' Auth-Type := Local, User-Password == \"\' + i.hardware_address.downcase + \'\"\''),(2,'WAG302','Newer Netgear WAPs (2nd Floor Jamaica)',1,'2007-07-02 11:19:38','2009-06-30 10:15:44','addDashes(i.hardware_address.upcase) + \' Auth-Type := Local, User-Password == \"NOPASSWORD\"\'');
/*!40000 ALTER TABLE `wireless_output_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workstations`
--

DROP TABLE IF EXISTS `workstations`;
CREATE TABLE `workstations` (
  `id` int(11) NOT NULL auto_increment,
  `device_id` int(4) default NULL,
  `contact_id` int(4) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_workstations_on_device_id` (`device_id`),
  KEY `index_workstations_on_contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workstations`
--

LOCK TABLES `workstations` WRITE;
/*!40000 ALTER TABLE `workstations` DISABLE KEYS */;
/*!40000 ALTER TABLE `workstations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--

DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`),
  KEY `index_zones_on_parent_id` (`parent_id`),
  KEY `index_zones_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zones`
--

LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones` VALUES (3,NULL,'Default','The default zone for all networks');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-04-17 18:32:23
