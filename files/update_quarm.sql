-- Login server defaults
ALTER TABLE tblLoginServerAccounts ALTER column creationIP SET DEFAULT '127.0.0.1';
ALTER TABLE tblLoginServerAccounts ALTER column ForumName SET DEFAULT 'none';

-- Launcher zones for boats
DELETE FROM `launcher_zones` WHERE `zone` IN ('butcher','erudnext','erudsxing','firiona','freporte','iceclad','nro','oasis','oot','overthere','qeynos','timorous');
INSERT INTO `launcher_zones` VALUES 
('boats','butcher',7300,1,'classic'),
('boats','erudnext',7301,1,'classic'),
('boats','erudsxing',7302,1,'classic'),
('boats','firiona',7303,1,'classic'),
('boats','freporte',7304,1,'classic'),
('boats','iceclad',7305,1,'classic'),
('boats','nro',7306,1,'classic'),
('boats','oasis',7307,1,'classic'),
('boats','oot',7308,1,'classic'),
('boats','overthere',7309,1,'classic'),
('boats','qeynos',7310,1,'classic'),
('boats','timorous',7311,1,'classic');


-- Rules
UPDATE `rule_values` SET `rule_value` = 100 WHERE `rule_name` = "World:AddMaxClientsPerIP";
UPDATE `rule_values` SET `rule_value` = 100 WHERE `rule_name` = "World:MaxClientsPerIP";
UPDATE `rule_values` SET `rule_value` = 1 WHERE `rule_name` = "Chat:GlobalChatLevelLimit";
UPDATE `rule_values` SET `rule_value` = 65 WHERE `rule_name` = "Character:MaxBetaBuffLevel";
UPDATE `rule_values` SET `rule_value` = 1 WHERE `rule_name` = "Chat:KarmaGlobalChatLevelLimit";
UPDATE `rule_values` SET `rule_value` = false WHERE `rule_name` = "World:DontBootDynamics";

-- Logging
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 30; -- Login Server
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 31; -- UCS Server 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 32; -- Webinterface Server 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 33; -- World Server 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 34; -- Zone Server 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 35; -- MySQL Error 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 36; -- MySQL Query 
UPDATE `logsys_categories` SET `log_to_console` = 3, `log_to_file` = 3 WHERE  `log_category_id` = 37; -- EQMac 


UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 58; -- Info
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 63; -- Notice
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 59; -- Warning
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 11; -- Error
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 62; -- Alert
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 60; -- Critical
UPDATE `logsys_categories` SET `log_to_file` = 3 WHERE `log_category_id` = 61; -- Emergency


-- Fix dynamic launcher count
UPDATE launcher SET dynamics = 10 WHERE name = 'dynzone1';

-- Add banned_ips table if it doesn't exist
CREATE TABLE IF NOT EXISTS `banned_ips` (
    `ip_address` varchar(20) NOT NULL DEFAULT '0',
    `notes` text DEFAULT NULL,
    PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB;