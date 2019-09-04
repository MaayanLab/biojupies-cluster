-- BioJupies Schema

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS `core_scripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_string` varchar(255) NOT NULL DEFAULT '',
  `option_name` varchar(255) NOT NULL DEFAULT '',
  `introduction` text NOT NULL,
  `methods` text NOT NULL,
  `reference` text NOT NULL,
  `reference_link` text NOT NULL,
  `option_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dataset_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dataset_v6` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_accession` varchar(35) NOT NULL DEFAULT '',
  `dataset_title` text NOT NULL,
  `summary` text NOT NULL,
  `date` date NOT NULL,
  `dataset_type_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accession` (`dataset_accession`),
  KEY `dataset_type_fk` (`dataset_type_fk`),
  CONSTRAINT `dataset_ibfk_1_v6` FOREIGN KEY (`dataset_type_fk`) REFERENCES `dataset_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9146 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gse` varchar(20) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `notebook_configuration` text,
  `error_type` varchar(200) DEFAULT NULL,
  `error` longtext,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2763 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `fastq_alignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alignment_uid` varchar(30) DEFAULT NULL,
  `fastq_upload_fk` int(11) DEFAULT NULL,
  `species` varchar(3) DEFAULT NULL,
  `paired` tinyint(1) DEFAULT '0',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) DEFAULT '0',
  `alignment_title` varchar(250) DEFAULT 'FASTQ Alignment',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alignment_uid` (`alignment_uid`),
  KEY `fastq_upload_fk` (`fastq_upload_fk`),
  CONSTRAINT `fastq_alignment_ibfk_1` FOREIGN KEY (`fastq_upload_fk`) REFERENCES `fastq_upload` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1635 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `fastq_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fastq_upload_fk` int(11) DEFAULT NULL,
  `filename` text,
  PRIMARY KEY (`id`),
  KEY `fastq_upload_fk` (`fastq_upload_fk`),
  CONSTRAINT `fastq_file_ibfk_1` FOREIGN KEY (`fastq_upload_fk`) REFERENCES `fastq_upload` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19324 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `fastq_upload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upload_uid` varchar(30) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_fk` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `upload_uid` (`upload_uid`),
  UNIQUE KEY `upload_uid_2` (`upload_uid`),
  KEY `user_fk` (`user_fk`),
  CONSTRAINT `fastq_upload_ibfk_1` FOREIGN KEY (`user_fk`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2151 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `flask_dance_oauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `token` text,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `flask_dance_oauth_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3370 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `gtex_metadata` (
  `AGE` text,
  `SAMPID` text,
  `SEX` text,
  `SMTS` text,
  `SMTSD` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `help_request` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `help_type` varchar(50) DEFAULT NULL,
  `error_fk` int(11) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `error_fk` (`error_fk`),
  CONSTRAINT `help_request_ibfk_1` FOREIGN KEY (`error_fk`) REFERENCES `error_log` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notebook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notebook_uid` varchar(20) NOT NULL,
  `dataset` varchar(20) NOT NULL DEFAULT '',
  `notebook_title` text NOT NULL,
  `version` varchar(7) NOT NULL DEFAULT '',
  `notebook_configuration` text NOT NULL,
  `time` int(11) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_fk` int(11) DEFAULT NULL,
  `private` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15372 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notebook_ontology_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notebook_fk` int(11) DEFAULT NULL,
  `ontology_term_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notebook_fk` (`notebook_fk`),
  KEY `ontology_term_fk` (`ontology_term_fk`),
  CONSTRAINT `notebook_ontology_term_ibfk_1` FOREIGN KEY (`notebook_fk`) REFERENCES `notebook` (`id`),
  CONSTRAINT `notebook_ontology_term_ibfk_2` FOREIGN KEY (`ontology_term_fk`) REFERENCES `ontology_term` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3972 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notebook_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notebook_fk` int(11) DEFAULT NULL,
  `tool_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tool_fk` (`tool_fk`),
  KEY `notebook_fk` (`notebook_fk`),
  CONSTRAINT `notebook_tool_ibfk_3` FOREIGN KEY (`notebook_fk`) REFERENCES `notebook` (`id`),
  CONSTRAINT `notebook_tool_ibfk_4` FOREIGN KEY (`tool_fk`) REFERENCES `tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113338 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `notebooks` (
  `gse` text,
  `notebook_configuration` text,
  `notebook_uid` text,
  `notebook_url` text,
  `version` text,
  `user_fk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `old_notebooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notebook_uid` varchar(30) DEFAULT NULL,
  `notebook_url` text,
  `gse` varchar(20) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `notebook_configuration` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1796 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ontology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ontology_name` varchar(50) DEFAULT NULL,
  `ontology_string` varchar(50) DEFAULT NULL,
  `homepage_url` varchar(100) DEFAULT NULL,
  `search_base_url` varchar(100) DEFAULT NULL,
  `ontology_description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ontology_string` (`ontology_string`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ontology_term` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term_id` varchar(30) DEFAULT NULL,
  `term_name` varchar(250) DEFAULT NULL,
  `term_description` text,
  `ontology_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `term_id` (`term_id`,`ontology_fk`),
  KEY `ontology_fk` (`ontology_fk`),
  CONSTRAINT `ontology_term_ibfk_1` FOREIGN KEY (`ontology_fk`) REFERENCES `ontology` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194357 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(255) DEFAULT NULL,
  `parameter_description` text,
  `parameter_string` varchar(255) DEFAULT NULL,
  `tool_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parameter_string` (`parameter_string`,`tool_fk`),
  KEY `tool_fk` (`tool_fk`),
  CONSTRAINT `parameter_ibfk_1` FOREIGN KEY (`tool_fk`) REFERENCES `tool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `parameter_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_fk` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `type` enum('str','int','float') DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parameter_fk` (`parameter_fk`),
  CONSTRAINT `parameter_value_ibfk_1` FOREIGN KEY (`parameter_fk`) REFERENCES `parameter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `platform_v6` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform_accession` varchar(15) NOT NULL,
  `organism` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `platform_accession` (`platform_accession`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sample_metadata_v6` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable` text,
  `value` text,
  `sample_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sample_fk` (`sample_fk`),
  CONSTRAINT `sample_metadata_v6_ibfk_1` FOREIGN KEY (`sample_fk`) REFERENCES `sample_v6` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1652085 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sample_v6` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_accession` varchar(15) NOT NULL,
  `sample_title` varchar(255) NOT NULL,
  `dataset_fk` int(11) NOT NULL,
  `platform_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accession` (`sample_accession`,`platform_fk`,`dataset_fk`),
  KEY `dataset_fk` (`dataset_fk`),
  KEY `platform_fk` (`platform_fk`),
  CONSTRAINT `sample_v6_ibfk_1` FOREIGN KEY (`dataset_fk`) REFERENCES `dataset_v6` (`id`),
  CONSTRAINT `sample_v6_ibfk_2` FOREIGN KEY (`platform_fk`) REFERENCES `platform_v6` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=336426 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `search` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `query` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37689 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section_name` varchar(255) DEFAULT NULL,
  `section_description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `series` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gse` varchar(35) DEFAULT NULL,
  `title` text,
  `summary` text,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gse` (`gse`)
) ENGINE=InnoDB AUTO_INCREMENT=4236 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_string` varchar(255) DEFAULT NULL,
  `tool_name` varchar(255) DEFAULT NULL,
  `tool_description` text,
  `introduction` text,
  `methods` text,
  `reference` text,
  `reference_link` text,
  `default_selected` tinyint(1) DEFAULT NULL,
  `section_fk` int(11) DEFAULT NULL,
  `input` varchar(20) DEFAULT NULL,
  `display` tinyint(1) DEFAULT '1',
  `result_description` text NOT NULL,
  `video_tutorial` text,
  `requires_signature` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `section_fk` (`section_fk`),
  CONSTRAINT `tool_ibfk_1` FOREIGN KEY (`section_fk`) REFERENCES `section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tool_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_string` varchar(255) DEFAULT NULL,
  `tool_name` varchar(255) DEFAULT NULL,
  `tool_description` text,
  `introduction` text,
  `methods` text,
  `reference` text,
  `reference_link` text,
  `default_selected` tinyint(1) DEFAULT NULL,
  `section_fk` int(11) DEFAULT NULL,
  `input` varchar(20) DEFAULT NULL,
  `display` tinyint(1) DEFAULT '1',
  `result_description` text NOT NULL,
  `video_tutorial` text,
  `requires_signature` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `section_fk` (`section_fk`),
  CONSTRAINT `tool_copy_ibfk_1` FOREIGN KEY (`section_fk`) REFERENCES `section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `given_name` varchar(255) DEFAULT NULL,
  `family_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=806 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_uid` varchar(30) DEFAULT NULL,
  `dataset_type` varchar(30) DEFAULT 'expression_table',
  `status` varchar(30) DEFAULT 'complete',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_fk` int(11) DEFAULT NULL,
  `dataset_title` varchar(250) DEFAULT 'Untitled Dataset',
  `private` tinyint(1) DEFAULT '0',
  `fastq_alignment_fk` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `fastq_alignment_fk` (`fastq_alignment_fk`),
  KEY `user_fk` (`user_fk`),
  CONSTRAINT `user_dataset_ibfk_1` FOREIGN KEY (`fastq_alignment_fk`) REFERENCES `fastq_alignment` (`id`),
  CONSTRAINT `user_dataset_ibfk_2` FOREIGN KEY (`user_fk`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5627 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_name` varchar(255) DEFAULT NULL,
  `user_dataset_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_dataset_fk` (`user_dataset_fk`),
  CONSTRAINT `user_sample_ibfk_1` FOREIGN KEY (`user_dataset_fk`) REFERENCES `user_dataset` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90898 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_sample_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable` text,
  `value` text,
  `user_sample_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_sample_fk` (`user_sample_fk`),
  CONSTRAINT `user_sample_metadata_ibfk_1` FOREIGN KEY (`user_sample_fk`) REFERENCES `user_sample` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159723 DEFAULT CHARSET=utf8;

CREATE OR REPLACE VIEW daily_datasets AS
select
  cast(`user_dataset`.`date` as date) AS `day`,
  count(0) AS `datasets`
from `user_dataset`
group by `day`
order by `day` desc;

CREATE OR REPLACE VIEW daily_fastq AS
select
  cast(`fu`.`date` as date) AS `day`,
  count(0) AS `fastq_files`
from (
  `fastq_upload` `fu` left join `fastq_file` `ff` on `fu`.`id` = `ff`.`fastq_upload_fk`
)
group by `day`
order by `day` desc;

CREATE OR REPLACE VIEW daily_notebooks AS
select
  cast(`notebook`.`date` as date) AS `day`,
  count(0) AS `notebooks`
from `notebook`
group by `day`
order by `day` desc;

SET FOREIGN_KEY_CHECKS=1;
