-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 24 Février 2016 à 21:04
-- Version du serveur: 5.5.35
-- Version de PHP: 5.4.4-14+deb7u7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `c4_kellerit_poker`
--

-- --------------------------------------------------------

--
-- Structure de la table `pp_administration_tools`
--

CREATE TABLE `pp_administration_tools` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `controller` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `action` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_application_logs`
--

CREATE TABLE `pp_application_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `taken_by_id` int(10) unsigned DEFAULT NULL,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rel_object_id` int(10) NOT NULL DEFAULT '0',
  `object_name` text COLLATE utf8_unicode_ci,
  `rel_object_manager` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `action` enum('upload','open','close','delete','edit','add') COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_silent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_attached_files`
--

CREATE TABLE `pp_attached_files` (
  `rel_object_manager` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`rel_object_manager`,`rel_object_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_comments`
--

CREATE TABLE `pp_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rel_object_manager` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `text` text COLLATE utf8_unicode_ci,
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_anonymous` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `author_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `author_homepage` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`rel_object_id`,`rel_object_manager`),
  KEY `created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_companies`
--

CREATE TABLE `pp_companies` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `client_of_id` smallint(5) unsigned DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homepage` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax_number` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_file` varchar(44) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` float(3,1) NOT NULL DEFAULT '0.0',
  `hide_welcome_info` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_on` (`created_on`),
  KEY `client_of_id` (`client_of_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_config_categories`
--

CREATE TABLE `pp_config_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `category_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`category_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_config_options`
--

CREATE TABLE `pp_config_options` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_unicode_ci,
  `config_handler_class` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `option_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `dev_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `order` (`option_order`),
  KEY `category_id` (`category_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_file_repo`
--

CREATE TABLE `pp_file_repo` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` longblob NOT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order` (`order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_file_repo_attributes`
--

CREATE TABLE `pp_file_repo_attributes` (
  `id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `attribute` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`,`attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_file_types`
--

CREATE TABLE `pp_file_types` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `extension` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_searchable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_image` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `extension` (`extension`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_im_types`
--

CREATE TABLE `pp_im_types` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `icon` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_message_subscriptions`
--

CREATE TABLE `pp_message_subscriptions` (
  `message_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_projects`
--

CREATE TABLE `pp_projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `show_description_in_overview` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(11) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `completed_on` (`completed_on`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_companies`
--

CREATE TABLE `pp_project_companies` (
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `company_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`,`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_files`
--

CREATE TABLE `pp_project_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `filename` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_important` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `expiration_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `anonymous_comments_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT '0',
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_file_revisions`
--

CREATE TABLE `pp_project_file_revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_type_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `repository_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `thumb_filename` varchar(44) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revision_number` int(10) unsigned NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8_unicode_ci,
  `type_string` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`),
  KEY `updated_on` (`updated_on`),
  KEY `revision_number` (`revision_number`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_folders`
--

CREATE TABLE `pp_project_folders` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_forms`
--

CREATE TABLE `pp_project_forms` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `success_message` text COLLATE utf8_unicode_ci NOT NULL,
  `action` enum('add_comment','add_task') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'add_comment',
  `in_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `created_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_messages`
--

CREATE TABLE `pp_project_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `milestone_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `additional_text` text COLLATE utf8_unicode_ci,
  `is_important` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `comments_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `anonymous_comments_enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `milestone_id` (`milestone_id`),
  KEY `project_id` (`project_id`),
  KEY `created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_milestones`
--

CREATE TABLE `pp_project_milestones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `due_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `assigned_to_company_id` smallint(10) NOT NULL DEFAULT '0',
  `assigned_to_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `due_date` (`due_date`),
  KEY `completed_on` (`completed_on`),
  KEY `created_on` (`created_on`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_tasks`
--

CREATE TABLE `pp_project_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_list_id` int(10) unsigned DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `assigned_to_company_id` smallint(5) unsigned DEFAULT NULL,
  `assigned_to_user_id` int(10) unsigned DEFAULT NULL,
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `task_list_id` (`task_list_id`),
  KEY `completed_on` (`completed_on`),
  KEY `created_on` (`created_on`),
  KEY `order` (`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_task_lists`
--

CREATE TABLE `pp_project_task_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `milestone_id` int(10) unsigned NOT NULL DEFAULT '0',
  `project_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `completed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed_by_id` int(10) unsigned DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `created_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `updated_on` datetime DEFAULT NULL,
  `updated_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `milestone_id` (`milestone_id`),
  KEY `project_id` (`project_id`),
  KEY `completed_on` (`completed_on`),
  KEY `created_on` (`created_on`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_project_users`
--

CREATE TABLE `pp_project_users` (
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `created_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `can_manage_messages` tinyint(1) unsigned DEFAULT '0',
  `can_manage_tasks` tinyint(1) unsigned DEFAULT '0',
  `can_manage_milestones` tinyint(1) unsigned DEFAULT '0',
  `can_upload_files` tinyint(1) unsigned DEFAULT '0',
  `can_manage_files` tinyint(1) unsigned DEFAULT '0',
  `can_assign_to_owners` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `can_assign_to_other` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_searchable_objects`
--

CREATE TABLE `pp_searchable_objects` (
  `rel_object_manager` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `column_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_private` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`rel_object_manager`,`rel_object_id`,`column_name`),
  KEY `project_id` (`project_id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_tags`
--

CREATE TABLE `pp_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tag` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rel_object_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rel_object_manager` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_on` datetime DEFAULT NULL,
  `created_by_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `tag` (`tag`),
  KEY `object_id` (`rel_object_id`,`rel_object_manager`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_users`
--

CREATE TABLE `pp_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(13) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twister` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `display_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file` varchar(44) COLLATE utf8_unicode_ci DEFAULT NULL,
  `office_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `home_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` float(3,1) NOT NULL DEFAULT '0.0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_visit` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_admin` tinyint(1) unsigned DEFAULT NULL,
  `auto_assign` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `last_visit` (`last_visit`),
  KEY `company_id` (`company_id`),
  KEY `last_login` (`last_login`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pp_user_im_values`
--

CREATE TABLE `pp_user_im_values` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `im_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`im_type_id`),
  KEY `is_default` (`is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
