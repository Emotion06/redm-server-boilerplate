CREATE DATABASE `vorp`;

USE `vorp`;

CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` INT DEFAULT 5, /*by default is 5 change this to the numbers of chaacters allowed*/
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE `bank_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL COLLATE 'utf8mb4_bin',
  `charidentifier` int(11) NOT NULL,
  `money` double(22, 2) DEFAULT 0.00,
  `gold` double(22, 2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  INDEX `bankusers` (`identifier`) USING BTREE,
  CONSTRAINT `bankusers` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `banneds` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_steam` varchar(100) NOT NULL,
  `b_license` varchar(255) DEFAULT NULL,
  `b_discord` varchar(100) DEFAULT NULL,
  `b_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `b_banned` varchar(100) NOT NULL,
  `b_unban` varchar(100) NOT NULL,
  `b_permanent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longtext DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `issuer` longtext DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `steamname` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(10) COLLATE utf8mb4_bin DEFAULT 'user',
  `money` double(11, 2) DEFAULT 0.00,
  `gold` double(11, 2) DEFAULT 0.00,
  `rol` double(11, 2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `healthouter` int(4) DEFAULT 500,
  `healthinner` int(4) DEFAULT 100,
  `staminaouter` int(4) DEFAULT 100,
  `staminainner` int(4) DEFAULT 100,
  `hours` float NOT NULL DEFAULT 0,
  `LastLogin` date DEFAULT NULL,
  `inventory` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `joblabel` varchar(255) COLLATE utf8mb4_bin DEFAULT 'Unemployed',
  `status` varchar(140) COLLATE utf8mb4_bin DEFAULT '{}',
  `meta` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `character_desc` MEDIUMTEXT NOT NULL DEFAULT ' ' COLLATE 'utf8mb4_bin',
	`gender` VARCHAR(50) NOT NULL DEFAULT ' ' COLLATE 'utf8mb4_bin',
	`age` INT(11) NOT NULL DEFAULT '0',
	`nickname` VARCHAR(50) NULL DEFAULT ' ' COLLATE 'utf8mb4_bin',
  `skinPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `compPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `compTints` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
  `jobgrade` int(11) DEFAULT 0,
  `coords` LONGTEXT COLLATE utf8mb4_bin DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `walk` varchar(50) COLLATE utf8mb4_bin DEFAULT 'noanim',
  `crafting` longtext COLLATE utf8mb4_bin DEFAULT '{"medical":0,"blacksmith":0,"basic":0,"survival":0,"brewing":0,"food":0}',
  `info` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `gunsmith` double(11, 2) DEFAULT 0.00,
  `ammo` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `discordid` varchar(255) COLLATE utf8mb4_bin DEFAULT '0',
  `lastjoined` longtext COLLATE utf8mb4_bin DEFAULT '[]',
  UNIQUE KEY `identifier_charidentifier` (`identifier`, `charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  KEY `crafting` (`crafting`(768)),
  KEY `compPlayer` (`compPlayer`(768)),
  KEY `info` (`info`(768)),
  KEY `inventory` (`inventory`(768)),
  KEY `coords` (`coords`),
  KEY `money` (`money`),
  KEY `meta` (`meta`),
  KEY `steamname` (`steamname`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

CREATE TABLE `housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `furniture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `open` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interiorId` int(11) NOT NULL,
  `inventory` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `identifier` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `charidentifier` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `character_inventories` (
  `character_id` int(11) DEFAULT NULL,
  `inventory_type` varchar(100) NOT NULL DEFAULT 'default',
  `item_crafted_id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  KEY `character_inventory_idx` (`character_id`, `inventory_type`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `break` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier_charidentifier` (`identifier`, `charidentifier`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC;

SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `modelname` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `xp` int(11) NULL DEFAULT 0,
  `injured` int(11) NULL DEFAULT 0,
  `gear` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

CREATE TABLE `horse_complements`  (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE INDEX `identifier`(`identifier`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `open` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC;

CREATE TABLE `item_group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL COMMENT 'Description of Item Group',
  PRIMARY KEY (`id`)
);

INSERT INTO
  `item_group` (`id`, `description`)
VALUES
  (1, "default");

CREATE TABLE `items` (
  `item` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
  `label` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
  `limit` INT(11) NOT NULL DEFAULT '1',
  `can_remove` TINYINT(1) NOT NULL DEFAULT '1',
  `type` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
  `usable` TINYINT(1) NULL DEFAULT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `groupId` INT(10) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Item Group ID for Filtering',
  `metadata` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_bin',
  `desc` VARCHAR(5550) NOT NULL DEFAULT 'nice item' COLLATE 'utf8mb4_general_ci',
  PRIMARY KEY (`item`) USING BTREE,
  UNIQUE INDEX `id` (`id`) USING BTREE,
  INDEX `FK_items_item_group` (`groupId`) USING BTREE,
  CONSTRAINT `FK_items_item_group` FOREIGN KEY (`groupId`) REFERENCES `vorpv2`.`item_group` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT `metadata` CHECK (json_valid(`metadata`))
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `items_crafted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`),
  KEY `crafted_item_idx` (`character_id`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_bin',
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `used2` tinyint(4) DEFAULT 0,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext NOT NULL DEFAULT '{}',
  `label` varchar(50) DEFAULT NULL,
  `curr_inv` varchar(100) NOT NULL DEFAULT 'default',
  `serial_number` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
  `custom_label` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
  `custom_desc` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `mailbox_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(50) DEFAULT NULL,
  `sender_firstname` varchar(50) DEFAULT NULL,
  `sender_lastname` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `receiver_firstname` varchar(50) DEFAULT NULL,
  `receiver_lastname` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  `received_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interiorId` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

CREATE TABLE `whitelist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_bin',
  `status` TINYINT(1) NULL DEFAULT NULL,
  `firstconnection` TINYINT(1) NULL DEFAULT '1',
  `discordid` VARCHAR(50) NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `identifier` (`identifier`) USING BTREE
) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB ROW_FORMAT = DYNAMIC;

INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `metadata`, `desc`) VALUES
('ammoarrownormal', 'Arrow Normal', 10, 1, 'item_standard', 1, 1238, '{}', 'A standard arrow used with bows for hunting and combat.'),
('ammoarrowdynamite', 'Arrow Dynamite', 10, 1, 'item_standard', 1, 10, '{}', 'An explosive arrow designed to cause significant damage upon impact.'),
('ammoarrowfire', 'Arrow Fire', 10, 1, 'item_standard', 1, 11, '{}', 'An arrow equipped with a flaming tip, capable of setting targets on fire.'),
('ammoarrowimproved', 'Arrow Improved', 10, 1, 'item_standard', 1, 12, '{}', 'An upgraded arrow with improved accuracy and damage.'),
('ammoarrowpoison', 'Arrow Poison', 10, 1, 'item_standard', 1, 13, '{}', 'An arrow coated with a poisonous substance, capable of inflicting additional damage over time.'),
('ammoarrowsmallgame', 'Arrow Small Game', 10, 1, 'item_standard', 1, 14, '{}', 'A specialized arrow designed for hunting small game without damaging their pelts.'),
('ammobolahawk', 'Bola Ammo Hawk', 10, 1, 'item_standard', 1, 15, '{}', 'A projectile consisting of weights attached to ropes, used to immobilize targets.'),
('ammobolainterwired', 'Bola Ammo Interwired', 10, 1, 'item_standard', 1, 16, '{}', 'A reinforced bola ammunition with interwoven materials, providing enhanced durability.'),
('ammobolaironspiked', 'Bola Ammo Ironspiked', 10, 1, 'item_standard', 1, 17, '{}', 'A bola ammunition featuring iron spikes, inflicting additional damage to immobilized targets.'),
('ammobolla', 'Bolla Ammo', 10, 1, 'item_standard', 1, 18, '{}', 'A weighted throwing weapon used to ensnare and immobilize targets.'),
('ammodynamite', 'Dynamite Ammo', 10, 1, 'item_standard', 1, 19, '{}', 'An explosive device with a short fuse, capable of causing significant damage.'),
('ammoelephant', 'Elephant Rifle Ammo', 10, 1, 'item_standard', 1, 20, '{}', 'Ammunition specifically designed for powerful elephant rifles, providing superior stopping power.'),
('ammoknives', 'Knives Ammo', 10, 1, 'item_standard', 1, 21, '{}', 'Ammunition for a throwing knife, used as a versatile and silent weapon.'),
('ammomolotov', 'Molotov Ammo', 10, 1, 'item_standard', 1, 22, '{}', 'A glass bottle filled with flammable liquid, designed to burst into flames upon impact.'),
('ammopistolexplosive', 'Pistol Ammo Explosive', 10, 1, 'item_standard', 1, 23, '{}', 'Ammunition for a pistol with explosive properties, causing significant damage upon impact.'),
('ammopistolexpress', 'Pistol Ammo Express', 10, 1, 'item_standard', 1, 24, '{}', 'High-velocity ammunition specifically designed for pistols, providing increased range and damage.'),
('ammopistolnormal', 'Pistol Ammo Normal', 10, 1, 'item_standard', 1, 25, '{}', 'Standard ammunition used with pistols for self-defense and combat.'),
('ammopistolsplitpoint', 'Pistol Ammo Splitpoint', 10, 1, 'item_standard', 1, 26, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy.'),
('ammopistolvelocity', 'Pistol Ammo Velocity', 10, 1, 'item_standard', 1, 27, '{}', 'Ammunition designed to enhance the velocity and accuracy of pistol shots.'),
('ammopoisonbottle', 'Poison Bottle Ammo', 10, 1, 'item_standard', 1, 28, '{}', 'A glass bottle filled with a poisonous substance, used to coat weapons and inflict additional damage.'),
('ammorepeaterexplosive', 'Repeater Ammo Explosive', 10, 1, 'item_standard', 1, 29, '{}', 'Ammunition for a repeater rifle with explosive properties, causing significant damage upon impact.'),
('ammorepeaterexpress', 'Repeater Ammo Express', 10, 1, 'item_standard', 1, 30, '{}', 'High-velocity ammunition specifically designed for repeater rifles, providing increased range and damage.'),
('ammorepeaternormal', 'Repeater Ammo Normal', 10, 1, 'item_standard', 1, 31, '{}', 'Standard ammunition used with repeater rifles for self-defense and combat.'),
('ammorepeatersplitpoint', 'Repeater Ammo Splitpoint', 10, 1, 'item_standard', 1, 32, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with repeater rifles.'),
('ammorepeatervelocity', 'Repeater Ammo Velocity', 10, 1, 'item_standard', 1, 33, '{}', 'Ammunition designed to enhance the velocity and accuracy of repeater rifle shots.'),
('ammorevolverexplosive', 'Revolver Ammo Explosive', 10, 1, 'item_standard', 1, 34, '{}', 'Ammunition for a revolver with explosive properties, causing significant damage upon impact.'),
('ammorevolverexpress', 'Revolver Ammo Express', 10, 1, 'item_standard', 1, 35, '{}', 'High-velocity ammunition specifically designed for revolvers, providing increased range and damage.'),
('ammorevolvernormal', 'Revolver Ammo Normal', 10, 1, 'item_standard', 1, 36, '{}', 'Standard ammunition used with revolvers for self-defense and combat.'),
('ammorevolversplitpoint', 'Revolver Ammo Splitpoint', 10, 1, 'item_standard', 1, 37, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with revolvers.'),
('ammorevolvervelocity', 'Revolver Ammo Velocity', 10, 1, 'item_standard', 1, 38, '{}', 'Ammunition designed to enhance the velocity and accuracy of revolver shots.'),
('ammorifleexplosive', 'Rifle Ammo Explosive', 10, 1, 'item_standard', 1, 39, '{}', 'Ammunition for a rifle with explosive properties, causing significant damage upon impact.'),
('ammorifleexpress', 'Rifle Ammo Express', 10, 1, 'item_standard', 1, 40, '{}', 'High-velocity ammunition specifically designed for rifles, providing increased range and damage.'),
('ammoriflenormal', 'Rifle Ammo Normal', 10, 1, 'item_standard', 1, 41, '{}', 'Standard ammunition used with rifles for self-defense and combat.'),
('ammoriflesplitpoint', 'Rifle Ammo Splitpoint', 10, 1, 'item_standard', 1, 42, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with rifles.'),
('ammoriflevelocity', 'Rifle Ammo Velocity', 10, 1, 'item_standard', 1, 43, '{}', 'Ammunition designed to enhance the velocity and accuracy of rifle shots.'),
('ammoshotgunexplosive', 'Shotgun Ammo Explosive', 10, 1, 'item_standard', 1, 44, '{}', 'Ammunition for a shotgun with explosive properties, causing significant damage upon impact.'),
('ammoshotgunincendiary', 'Shotgun Ammo Incendiary', 10, 1, 'item_standard', 1, 45, '{}', 'Ammunition designed to ignite targets, causing them to burst into flames.'),
('ammoshotgunnormal', 'Shotgun Ammo Normal', 10, 1, 'item_standard', 1, 46, '{}', 'Standard ammunition used with shotguns for self-defense and combat.'),
('ammoshotgunslug', 'Shotgun Ammo Slug', 10, 1, 'item_standard', 1, 47, '{}', 'Ammunition with a single solid projectile, offering increased accuracy and range for shotguns.'),
('ammotomahawk', 'Tomahawk Ammo', 10, 1, 'item_standard', 1, 48, '{}', 'Ammo used for Tomahawk throwing weapons'),
('ammovarmint', 'Varmint Ammo', 10, 1, 'item_standard', 1, 49, '{}', 'Ammo used for Varmint rifles'),
('ammovarminttranq', 'Varmint Tranquilizer Ammo', 10, 1, 'item_standard', 1, 50, '{}', 'Ammo used for tranquilizing animals with Varmint rifles'),
('ammovoldynamite', 'Volatile Dynamite Ammo', 10, 1, 'item_standard', 1, 51, '{}', 'Ammo used for crafting Volatile Dynamite'),
('ammovolmolotov', 'Volatile Molotov Ammo', 10, 1, 'item_standard', 1, 52, '{}', 'Ammo used for crafting Volatile Molotovs'),
('a_c_fishbluegil_01_ms', 'Medium Bluegil', 10, 1, 'item_standard', 0, 57, '{}', 'A medium-sized Bluegil fish.'),
('a_c_fishbluegil_01_sm', 'Small Bluegil', 5, 1, 'item_standard', 0, 58, '{}', 'A small Bluegil fish.'),
('a_c_fishbullheadcat_01_ms', 'Medium Bullhead', 10, 1, 'item_standard', 0, 59, '{}', 'A medium-sized Bullhead fish.'),
('a_c_fishbullheadcat_01_sm', 'Small Bullhead', 5, 1, 'item_standard', 0, 60, '{}', 'A small Bullhead fish.'),
('a_c_fishchainpickerel_01_ms', 'Medium Pickerel', 10, 1, 'item_standard', 0, 61, '{}', 'A medium-sized Pickerel fish.'),
('a_c_fishchainpickerel_01_sm', 'Small Pickerel', 5, 1, 'item_standard', 0, 62, '{}', 'A small Pickerel fish.'),
('a_c_fishlargemouthbass_01_ms', 'Largemouth Bass', 10, 1, 'item_standard', 0, 63, '{}', 'A large Largemouth Bass fish.'),
('a_c_fishperch_01_ms', 'Medium Perch', 10, 1, 'item_standard', 0, 64, '{}', 'A medium-sized Perch fish.'),
('a_c_fishperch_01_sm', 'Small Perch', 5, 1, 'item_standard', 0, 65, '{}', 'A small Perch fish.'),
('a_c_fishrainbowtrout_01_ms', 'Rainbow Trout', 10, 1, 'item_standard', 0, 66, '{}', 'A Rainbow Trout fish.'),
('a_c_fishredfinpickerel_01_ms', 'Medium Redfin Pickerel', 10, 1, 'item_standard', 0, 67, '{}', 'A medium-sized Redfin Pickerel fish.'),
('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 5, 1, 'item_standard', 0, 68, '{}', 'A small Redfin Pickerel fish.'),
('a_c_fishrockbass_01_ms', 'Medium Rockbass', 10, 1, 'item_standard', 0, 69, '{}', 'A medium-sized Rockbass fish.'),
('a_c_fishrockbass_01_sm', 'Small Rockbass', 5, 1, 'item_standard', 0, 70, '{}', 'A small Rockbass fish.'),
('a_c_fishsalmonsockeye_01_ms', 'Sockeye Salmon', 10, 1, 'item_standard', 0, 71, '{}', 'A Sockeye Salmon fish.'),
('a_c_fishsmallmouthbass_01_ms', 'Smallmouth Bass', 10, 1, 'item_standard', 0, 72, '{}', 'A small and tasty bass fish.'),