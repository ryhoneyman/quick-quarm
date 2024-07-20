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
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=30;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=31;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=32;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=33;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=34;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=35;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=36;
UPDATE `logsys_categories` SET `log_to_console`=3 WHERE  `log_category_id`=37;

-- Fix dynamic launcher count
UPDATE launcher SET dynamics = 10 WHERE name = 'dynzone1';