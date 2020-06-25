ALTER TABLE `_countries`
  CHANGE COLUMN `country_id` `country_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
  CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL COLLATE 'utf8_general_ci' AFTER `country_id`,
  DROP COLUMN `title_ua`,
  DROP COLUMN `title_be`,
  DROP COLUMN `title_en`,
  DROP COLUMN `title_es`,
  DROP COLUMN `title_pt`,
  DROP COLUMN `title_de`,
  DROP COLUMN `title_fr`,
  DROP COLUMN `title_it`,
  DROP COLUMN `title_pl`,
  DROP COLUMN `title_ja`,
  DROP COLUMN `title_lt`,
  DROP COLUMN `title_lv`,
  DROP COLUMN `title_cz`,
  ADD PRIMARY KEY (`country_id`),
  ADD INDEX `title` (`title`);

ALTER TABLE `_regions`
  CHANGE COLUMN `region_id` `region_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
  CHANGE COLUMN `country_id` `country_id` INT(11) UNSIGNED NOT NULL AFTER `region_id`,
  CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL COLLATE 'utf8_general_ci' AFTER `country_id`,
  DROP COLUMN `title_ua`,
  DROP COLUMN `title_be`,
  DROP COLUMN `title_en`,
  DROP COLUMN `title_es`,
  DROP COLUMN `title_pt`,
  DROP COLUMN `title_de`,
  DROP COLUMN `title_fr`,
  DROP COLUMN `title_it`,
  DROP COLUMN `title_pl`,
  DROP COLUMN `title_ja`,
  DROP COLUMN `title_lt`,
  DROP COLUMN `title_lv`,
  DROP COLUMN `title_cz`,
  ADD PRIMARY KEY (`region_id`),
  ADD INDEX `title` (`title`),
  ADD CONSTRAINT `_countries (id)` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`country_id`);


UPDATE _cities SET region_id=NULL WHERE region_id=0;

ALTER TABLE `_cities`
  CHANGE COLUMN `city_id` `city_id` INT(11) UNSIGNED NOT NULL FIRST,
  CHANGE COLUMN `country_id` `country_id` INT(11) UNSIGNED NOT NULL AFTER `city_id`,
  CHANGE COLUMN `region_id` `region_id` INT(11) UNSIGNED NULL AFTER `important`,
  CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL COLLATE 'utf8_general_ci' AFTER `region_id`,
  DROP COLUMN `area_ru`,
  DROP COLUMN `region_ru`,
  DROP COLUMN `title_ua`,
  DROP COLUMN `area_ua`,
  DROP COLUMN `region_ua`,
  DROP COLUMN `title_be`,
  DROP COLUMN `area_be`,
  DROP COLUMN `region_be`,
  DROP COLUMN `title_en`,
  DROP COLUMN `area_en`,
  DROP COLUMN `region_en`,
  DROP COLUMN `title_es`,
  DROP COLUMN `area_es`,
  DROP COLUMN `region_es`,
  DROP COLUMN `title_pt`,
  DROP COLUMN `area_pt`,
  DROP COLUMN `region_pt`,
  DROP COLUMN `title_de`,
  DROP COLUMN `area_de`,
  DROP COLUMN `region_de`,
  DROP COLUMN `title_fr`,
  DROP COLUMN `area_fr`,
  DROP COLUMN `region_fr`,
  DROP COLUMN `title_it`,
  DROP COLUMN `area_it`,
  DROP COLUMN `region_it`,
  DROP COLUMN `title_pl`,
  DROP COLUMN `area_pl`,
  DROP COLUMN `region_pl`,
  DROP COLUMN `title_ja`,
  DROP COLUMN `area_ja`,
  DROP COLUMN `region_ja`,
  DROP COLUMN `title_lt`,
  DROP COLUMN `area_lt`,
  DROP COLUMN `region_lt`,
  DROP COLUMN `title_lv`,
  DROP COLUMN `area_lv`,
  DROP COLUMN `region_lv`,
  DROP COLUMN `title_cz`,
  DROP COLUMN `area_cz`,
  DROP COLUMN `region_cz`,
  ADD PRIMARY KEY (`city_id`),
  ADD INDEX `title` (`title`),
  ADD CONSTRAINT `_countries (id)` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`country_id`),
  ADD CONSTRAINT `_regions (id)` FOREIGN KEY (`region_id`) REFERENCES `_regions` (`region_id`);
