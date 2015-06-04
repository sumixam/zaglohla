-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: zaglohla_development
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.12.04.1

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
-- Table structure for table `administrators`
--

DROP TABLE IF EXISTS `administrators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `acl` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_administrators_on_email` (`email`),
  UNIQUE KEY `index_administrators_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `body` text,
  `question_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email_notification` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `car_brand_category_autos`
--

DROP TABLE IF EXISTS `car_brand_category_autos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_brand_category_autos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_brand_id` int(11) DEFAULT NULL,
  `category_auto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_car_brand_category_autos_on_car_brand_id` (`car_brand_id`),
  KEY `index_car_brand_category_autos_on_category_auto_id` (`category_auto_id`),
  KEY `car_brand_category_autos_full_index_fields` (`category_auto_id`,`car_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `car_brands`
--

DROP TABLE IF EXISTS `car_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `foreigh_type` tinyint(1) DEFAULT NULL,
  `local_brand` tinyint(1) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `fav` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `car_engines`
--

DROP TABLE IF EXISTS `car_engines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_engines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_car_engines_on_car_generation_id` (`car_generation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `car_generations`
--

DROP TABLE IF EXISTS `car_generations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_generations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `start` int(11) DEFAULT NULL,
  `ends` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_car_generations_on_car_model_id` (`car_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `car_models`
--

DROP TABLE IF EXISTS `car_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_car_models_on_car_brand_id` (`car_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cars`
--

DROP TABLE IF EXISTS `cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `category_type` varchar(255) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `vin` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `nick` varchar(255) DEFAULT NULL,
  `year_start` int(11) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `runner_km` varchar(255) DEFAULT NULL,
  `alternative_name` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `year_build` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_autos`
--

DROP TABLE IF EXISTS `category_autos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_autos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ckeditor_assets`
--

DROP TABLE IF EXISTS `ckeditor_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckeditor_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_file_name` varchar(255) NOT NULL,
  `data_content_type` varchar(255) DEFAULT NULL,
  `data_file_size` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `assetable_type` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ckeditor_assetable_type` (`assetable_type`,`type`,`assetable_id`),
  KEY `idx_ckeditor_assetable` (`assetable_type`,`assetable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `control_programms`
--

DROP TABLE IF EXISTS `control_programms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `control_programms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_car_brands`
--

DROP TABLE IF EXISTS `cto_car_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_car_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_category_autos`
--

DROP TABLE IF EXISTS `cto_category_autos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_category_autos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `category_auto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_control_programms`
--

DROP TABLE IF EXISTS `cto_control_programms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_control_programms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `control_programm_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_districts`
--

DROP TABLE IF EXISTS `cto_districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_job_types`
--

DROP TABLE IF EXISTS `cto_job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `job_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_metro_stations`
--

DROP TABLE IF EXISTS `cto_metro_stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_metro_stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `metro_station_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_responses`
--

DROP TABLE IF EXISTS `cto_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `text` text,
  `car_generation_id` int(11) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `wat_at` date DEFAULT NULL,
  `custom_car` varchar(255) DEFAULT NULL,
  `rate_cto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_sales`
--

DROP TABLE IF EXISTS `cto_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `salable_type` varchar(255) DEFAULT NULL,
  `salable_id` int(11) DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_services`
--

DROP TABLE IF EXISTS `cto_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cto_shares`
--

DROP TABLE IF EXISTS `cto_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cto_shares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `anytime` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctos`
--

DROP TABLE IF EXISTS `ctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `adress_street` varchar(255) DEFAULT NULL,
  `adress_buildng` varchar(255) DEFAULT NULL,
  `adress_additional` varchar(255) DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `icq` varchar(255) DEFAULT NULL,
  `skype` varchar(255) DEFAULT NULL,
  `vk_link` varchar(255) DEFAULT NULL,
  `work_time` varchar(255) DEFAULT NULL,
  `description` text,
  `gov_certificate` tinyint(1) DEFAULT NULL,
  `manufacture_certificate` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `logo_file_name` varchar(255) DEFAULT NULL,
  `logo_content_type` varchar(255) DEFAULT NULL,
  `logo_file_size` int(11) DEFAULT NULL,
  `logo_updated_at` datetime DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `additional_phone_1` varchar(255) DEFAULT NULL,
  `additional_phone_2` varchar(255) DEFAULT NULL,
  `additional_phone_3` varchar(255) DEFAULT NULL,
  `other_job_types` varchar(255) DEFAULT NULL,
  `manufacture_certificate_list` varchar(255) DEFAULT NULL,
  `guarantee` varchar(255) DEFAULT NULL,
  `sign_on_time` tinyint(1) DEFAULT NULL,
  `boxsize` varchar(255) DEFAULT NULL,
  `sale_percent` varchar(255) DEFAULT NULL,
  `sale_comment` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `intresting_to_work` int(11) DEFAULT NULL,
  `other_control_programm` varchar(255) DEFAULT NULL,
  `payment_cash` tinyint(1) DEFAULT NULL,
  `payment_card` tinyint(1) DEFAULT NULL,
  `payment_bill` tinyint(1) DEFAULT NULL,
  `show_on_site` tinyint(1) DEFAULT NULL,
  `start_from_year` int(11) DEFAULT NULL,
  `administrator_id` int(11) DEFAULT NULL,
  `vk_page` varchar(255) DEFAULT NULL,
  `adress_comment` varchar(255) DEFAULT NULL,
  `official_diler` tinyint(1) DEFAULT NULL,
  `lat` varchar(255) DEFAULT NULL,
  `lon` varchar(255) DEFAULT NULL,
  `work_with_other_brands` tinyint(1) DEFAULT NULL,
  `brand_list` text,
  `cto_pricelist` text,
  `rating` int(11) DEFAULT '100',
  `expert_rating` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `districts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `is_city` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment_ctos`
--

DROP TABLE IF EXISTS `equipment_ctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment_ctos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `mark` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guarantee_ctos`
--

DROP TABLE IF EXISTS `guarantee_ctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guarantee_ctos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `length` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `string` varchar(255) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `run_km` varchar(255) DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `text` text,
  `view_date` varchar(255) DEFAULT NULL,
  `view_time` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `custom_car` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_types`
--

DROP TABLE IF EXISTS `job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manufacture_certs`
--

DROP TABLE IF EXISTS `manufacture_certs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manufacture_certs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mechanic_user_car_brands`
--

DROP TABLE IF EXISTS `mechanic_user_car_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mechanic_user_car_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mechanic_user_job_types`
--

DROP TABLE IF EXISTS `mechanic_user_job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mechanic_user_job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `job_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mechanic_user_sub_job_types`
--

DROP TABLE IF EXISTS `mechanic_user_sub_job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mechanic_user_sub_job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `sub_job_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metro_stations`
--

DROP TABLE IF EXISTS `metro_stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metro_stations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_per_hours`
--

DROP TABLE IF EXISTS `pay_per_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_per_hours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_type` varchar(255) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `work_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `imageable_id` int(11) DEFAULT NULL,
  `imageable_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pic_file_name` varchar(255) DEFAULT NULL,
  `pic_content_type` varchar(255) DEFAULT NULL,
  `pic_file_size` int(11) DEFAULT NULL,
  `pic_updated_at` datetime DEFAULT NULL,
  `main` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pricelists`
--

DROP TABLE IF EXISTS `pricelists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricelists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_id` int(11) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `description` text,
  `checked_at` date DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` varchar(255) DEFAULT NULL,
  `body` text,
  `email_notification` tinyint(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `job_type_id` int(11) DEFAULT NULL,
  `alternative_name` varchar(255) DEFAULT NULL,
  `user_hash` varchar(255) DEFAULT NULL,
  `year_of_production` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) DEFAULT NULL,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) DEFAULT NULL,
  `stars` float NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rates_on_rater_id` (`rater_id`),
  KEY `index_rates_on_rateable_id_and_rateable_type` (`rateable_id`,`rateable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_caches`
--

DROP TABLE IF EXISTS `rating_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_caches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheable_id` int(11) DEFAULT NULL,
  `cacheable_type` varchar(255) DEFAULT NULL,
  `avg` float NOT NULL,
  `qty` int(11) NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rating_caches_on_cacheable_id_and_cacheable_type` (`cacheable_id`,`cacheable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repair_costs`
--

DROP TABLE IF EXISTS `repair_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repair_costs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repair_work_type_id` int(11) DEFAULT NULL,
  `repair_work_sector_id` int(11) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `hours` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `repair_work_job_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_repair_costs_on_repair_work_job_id` (`repair_work_job_id`),
  KEY `index_repair_costs_on_car_engine_id` (`car_engine_id`),
  KEY `index_repair_costs_on_car_engine_id_and_repair_work_job_id` (`car_engine_id`,`repair_work_job_id`),
  KEY `full_index_fields` (`car_engine_id`,`repair_work_job_id`,`repair_work_type_id`,`repair_work_sector_id`,`car_generation_id`,`car_model_id`,`car_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repair_requests`
--

DROP TABLE IF EXISTS `repair_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repair_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` text,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `car_engine_id` int(11) DEFAULT NULL,
  `car_generation_id` int(11) DEFAULT NULL,
  `car_model_id` int(11) DEFAULT NULL,
  `car_brand_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `proccessed` tinyint(1) DEFAULT NULL,
  `custom_car` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repair_work_jobs`
--

DROP TABLE IF EXISTS `repair_work_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repair_work_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `repair_work_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_repair_work_jobs_on_repair_work_type_id` (`repair_work_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repair_work_sectors`
--

DROP TABLE IF EXISTS `repair_work_sectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repair_work_sectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repair_work_types`
--

DROP TABLE IF EXISTS `repair_work_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repair_work_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `repair_work_sector_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_repair_work_types_on_repair_work_sector_id` (`repair_work_sector_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `responce_fix_proces`
--

DROP TABLE IF EXISTS `responce_fix_proces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responce_fix_proces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cto_response_id` int(11) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spare_queries`
--

DROP TABLE IF EXISTS `spare_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spare_queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term` varchar(255) DEFAULT NULL,
  `attempts` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spares`
--

DROP TABLE IF EXISTS `spares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacture` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `seller` varchar(255) DEFAULT NULL,
  `avalaible` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_job_type_ctos`
--

DROP TABLE IF EXISTS `sub_job_type_ctos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_job_type_ctos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_job_type_id` int(11) DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sub_job_types`
--

DROP TABLE IF EXISTS `sub_job_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_job_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `job_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggings`
--

DROP TABLE IF EXISTS `taggings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `tagger_id` int(11) DEFAULT NULL,
  `tagger_type` varchar(255) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggings_idx` (`tag_id`,`taggable_id`,`taggable_type`,`context`,`tagger_id`,`tagger_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `taggings_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tags_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_cto_favs`
--

DROP TABLE IF EXISTS `user_cto_favs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_cto_favs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `cto_fav_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_levels`
--

DROP TABLE IF EXISTS `user_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_thanks`
--

DROP TABLE IF EXISTS `user_thanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_thanks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `thank_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `level_state_id` int(11) DEFAULT NULL,
  `avatar_file_name` varchar(255) DEFAULT NULL,
  `avatar_content_type` varchar(255) DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT 'CarOwner',
  `rating` float DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `start_career_year` int(11) DEFAULT NULL,
  `facebook_id` varchar(255) DEFAULT NULL,
  `vk_id` varchar(255) DEFAULT NULL,
  `user_level_id` int(11) DEFAULT NULL,
  `description` text,
  `notify_news` tinyint(1) DEFAULT '1',
  `notify_answers` tinyint(1) DEFAULT '1',
  `notify_questions` tinyint(1) DEFAULT '1',
  `notify_responses` tinyint(1) DEFAULT '1',
  `mechanic_cto_id` int(11) DEFAULT NULL,
  `mechanic_cto_confirmed` tinyint(1) DEFAULT NULL,
  `owner_cto_id` int(11) DEFAULT NULL,
  `owner_cto_confirmed` tinyint(1) DEFAULT NULL,
  `about_me` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `work_hours`
--

DROP TABLE IF EXISTS `work_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_hours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weekday_start` varchar(255) DEFAULT NULL,
  `time_start` varchar(255) DEFAULT NULL,
  `weekday_finish` varchar(255) DEFAULT NULL,
  `time_finish` varchar(255) DEFAULT NULL,
  `cto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `work_types`
--

DROP TABLE IF EXISTS `work_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-28 21:35:06
INSERT INTO schema_migrations (version) VALUES ('20131116193653');

INSERT INTO schema_migrations (version) VALUES ('20131116193708');

INSERT INTO schema_migrations (version) VALUES ('20131116194835');

INSERT INTO schema_migrations (version) VALUES ('20131116203814');

INSERT INTO schema_migrations (version) VALUES ('20131116205215');

INSERT INTO schema_migrations (version) VALUES ('20131117051514');

INSERT INTO schema_migrations (version) VALUES ('20131117051600');

INSERT INTO schema_migrations (version) VALUES ('20131118074830');

INSERT INTO schema_migrations (version) VALUES ('20131118074840');

INSERT INTO schema_migrations (version) VALUES ('20131119200644');

INSERT INTO schema_migrations (version) VALUES ('20131119201205');

INSERT INTO schema_migrations (version) VALUES ('20131120221502');

INSERT INTO schema_migrations (version) VALUES ('20131120221730');

INSERT INTO schema_migrations (version) VALUES ('20131123190437');

INSERT INTO schema_migrations (version) VALUES ('20131123190508');

INSERT INTO schema_migrations (version) VALUES ('20131123190539');

INSERT INTO schema_migrations (version) VALUES ('20131123190607');

INSERT INTO schema_migrations (version) VALUES ('20131123191750');

INSERT INTO schema_migrations (version) VALUES ('20131124053236');

INSERT INTO schema_migrations (version) VALUES ('20131124053347');

INSERT INTO schema_migrations (version) VALUES ('20131124054103');

INSERT INTO schema_migrations (version) VALUES ('20131124061124');

INSERT INTO schema_migrations (version) VALUES ('20131124061523');

INSERT INTO schema_migrations (version) VALUES ('20131124063050');

INSERT INTO schema_migrations (version) VALUES ('20131124063453');

INSERT INTO schema_migrations (version) VALUES ('20131217212231');

INSERT INTO schema_migrations (version) VALUES ('20131221191352');

INSERT INTO schema_migrations (version) VALUES ('20131222090422');

INSERT INTO schema_migrations (version) VALUES ('20131222091628');

INSERT INTO schema_migrations (version) VALUES ('20131222092829');

INSERT INTO schema_migrations (version) VALUES ('20131222093726');

INSERT INTO schema_migrations (version) VALUES ('20131222214123');

INSERT INTO schema_migrations (version) VALUES ('20131222221200');

INSERT INTO schema_migrations (version) VALUES ('20131222223409');

INSERT INTO schema_migrations (version) VALUES ('20131224223941');

INSERT INTO schema_migrations (version) VALUES ('20131224225118');

INSERT INTO schema_migrations (version) VALUES ('20131225081356');

INSERT INTO schema_migrations (version) VALUES ('20131225082629');

INSERT INTO schema_migrations (version) VALUES ('20131225082708');

INSERT INTO schema_migrations (version) VALUES ('20131225093724');

INSERT INTO schema_migrations (version) VALUES ('20131225094228');

INSERT INTO schema_migrations (version) VALUES ('20131225095203');

INSERT INTO schema_migrations (version) VALUES ('20131225101626');

INSERT INTO schema_migrations (version) VALUES ('20131225101705');

INSERT INTO schema_migrations (version) VALUES ('20131225110815');

INSERT INTO schema_migrations (version) VALUES ('20131225110952');

INSERT INTO schema_migrations (version) VALUES ('20131225111133');

INSERT INTO schema_migrations (version) VALUES ('20131225111452');

INSERT INTO schema_migrations (version) VALUES ('20131225120353');

INSERT INTO schema_migrations (version) VALUES ('20131225120424');

INSERT INTO schema_migrations (version) VALUES ('20131225121201');

INSERT INTO schema_migrations (version) VALUES ('20131225135454');

INSERT INTO schema_migrations (version) VALUES ('20131229072015');

INSERT INTO schema_migrations (version) VALUES ('20131229072049');

INSERT INTO schema_migrations (version) VALUES ('20131229095153');

INSERT INTO schema_migrations (version) VALUES ('20131230135838');

INSERT INTO schema_migrations (version) VALUES ('20131230141246');

INSERT INTO schema_migrations (version) VALUES ('20131230141510');

INSERT INTO schema_migrations (version) VALUES ('20131230144432');

INSERT INTO schema_migrations (version) VALUES ('20140105005140');

INSERT INTO schema_migrations (version) VALUES ('20140105114609');

INSERT INTO schema_migrations (version) VALUES ('20140105143018');

INSERT INTO schema_migrations (version) VALUES ('20140105144547');

INSERT INTO schema_migrations (version) VALUES ('20140113135512');

INSERT INTO schema_migrations (version) VALUES ('20140113135513');

INSERT INTO schema_migrations (version) VALUES ('20140128034418');

INSERT INTO schema_migrations (version) VALUES ('20140128035615');

INSERT INTO schema_migrations (version) VALUES ('20140201215613');

INSERT INTO schema_migrations (version) VALUES ('20140205094808');

INSERT INTO schema_migrations (version) VALUES ('20140205125142');

INSERT INTO schema_migrations (version) VALUES ('20140212131205');

INSERT INTO schema_migrations (version) VALUES ('20140212131242');

INSERT INTO schema_migrations (version) VALUES ('20140318022156');

INSERT INTO schema_migrations (version) VALUES ('20140319185333');

INSERT INTO schema_migrations (version) VALUES ('20140320100430');

INSERT INTO schema_migrations (version) VALUES ('20140320103551');

INSERT INTO schema_migrations (version) VALUES ('20140325092445');

INSERT INTO schema_migrations (version) VALUES ('20140325125218');

INSERT INTO schema_migrations (version) VALUES ('20140325165655');

INSERT INTO schema_migrations (version) VALUES ('20140325185806');

INSERT INTO schema_migrations (version) VALUES ('20140326195946');

INSERT INTO schema_migrations (version) VALUES ('20140328143648');

INSERT INTO schema_migrations (version) VALUES ('20140328153042');

INSERT INTO schema_migrations (version) VALUES ('20140328191030');

INSERT INTO schema_migrations (version) VALUES ('20140329210220');

INSERT INTO schema_migrations (version) VALUES ('20140330101851');

INSERT INTO schema_migrations (version) VALUES ('20140330110534');

INSERT INTO schema_migrations (version) VALUES ('20140330123506');

INSERT INTO schema_migrations (version) VALUES ('20140330123529');

INSERT INTO schema_migrations (version) VALUES ('20140330123611');

INSERT INTO schema_migrations (version) VALUES ('20140330123836');

INSERT INTO schema_migrations (version) VALUES ('20140330123845');

INSERT INTO schema_migrations (version) VALUES ('20140330123859');

INSERT INTO schema_migrations (version) VALUES ('20140401131516');

INSERT INTO schema_migrations (version) VALUES ('20140401131517');

INSERT INTO schema_migrations (version) VALUES ('20140401131518');

INSERT INTO schema_migrations (version) VALUES ('20140406163502');

INSERT INTO schema_migrations (version) VALUES ('20140406163520');

INSERT INTO schema_migrations (version) VALUES ('20140410133827');

INSERT INTO schema_migrations (version) VALUES ('20140410134811');

INSERT INTO schema_migrations (version) VALUES ('20140424125911');

INSERT INTO schema_migrations (version) VALUES ('20140424130350');

INSERT INTO schema_migrations (version) VALUES ('20140424130647');

INSERT INTO schema_migrations (version) VALUES ('20140424163342');

INSERT INTO schema_migrations (version) VALUES ('20140424163423');

INSERT INTO schema_migrations (version) VALUES ('20140424163444');

INSERT INTO schema_migrations (version) VALUES ('20140424163637');

INSERT INTO schema_migrations (version) VALUES ('20140424164308');

INSERT INTO schema_migrations (version) VALUES ('20140424164457');

INSERT INTO schema_migrations (version) VALUES ('20140424180618');

INSERT INTO schema_migrations (version) VALUES ('20140525190931');

INSERT INTO schema_migrations (version) VALUES ('20140606110901');

INSERT INTO schema_migrations (version) VALUES ('20140606111144');

INSERT INTO schema_migrations (version) VALUES ('20140606111707');

INSERT INTO schema_migrations (version) VALUES ('20140606122345');

INSERT INTO schema_migrations (version) VALUES ('20140613112713');

INSERT INTO schema_migrations (version) VALUES ('20140613115915');

INSERT INTO schema_migrations (version) VALUES ('20140729210229');

INSERT INTO schema_migrations (version) VALUES ('20140803074951');

INSERT INTO schema_migrations (version) VALUES ('20140803075234');

INSERT INTO schema_migrations (version) VALUES ('20140803115411');

INSERT INTO schema_migrations (version) VALUES ('20140811202918');

INSERT INTO schema_migrations (version) VALUES ('20140826032039');

INSERT INTO schema_migrations (version) VALUES ('20140826032644');

INSERT INTO schema_migrations (version) VALUES ('20140902204044');

INSERT INTO schema_migrations (version) VALUES ('20140902204149');

INSERT INTO schema_migrations (version) VALUES ('20140903075451');

INSERT INTO schema_migrations (version) VALUES ('20140929175759');

INSERT INTO schema_migrations (version) VALUES ('20141207141129');

INSERT INTO schema_migrations (version) VALUES ('20141208180625');

INSERT INTO schema_migrations (version) VALUES ('20141214165207');

INSERT INTO schema_migrations (version) VALUES ('20141230163819');

INSERT INTO schema_migrations (version) VALUES ('20150114132803');

INSERT INTO schema_migrations (version) VALUES ('20150215203945');

INSERT INTO schema_migrations (version) VALUES ('20150315135204');

INSERT INTO schema_migrations (version) VALUES ('20150315200026');

INSERT INTO schema_migrations (version) VALUES ('20150322153256');

INSERT INTO schema_migrations (version) VALUES ('20150405215051');

INSERT INTO schema_migrations (version) VALUES ('20150504212111');

