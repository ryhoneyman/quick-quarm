-- Login server defaults
ALTER TABLE tblLoginServerAccounts ALTER column creationIP SET DEFAULT '127.0.0.1';
ALTER TABLE tblLoginServerAccounts ALTER column ForumName SET DEFAULT 'none';

-- Launcher zones for boats
UPDATE `launcher_zones`
SET `port` = CASE
  WHEN `zone` = 'erudnext' THEN 7375
  WHEN `zone` = 'erudsxing' THEN 7376
  WHEN `zone` = 'qeynos' THEN 7377
  WHEN `zone` = 'freporte' THEN 7378
  WHEN `zone` = 'oot' THEN 7379
  WHEN `zone` = 'butcher' THEN 7380
  WHEN `zone` = 'oasis' THEN 7381
  WHEN `zone` = 'nro' THEN 7382
  WHEN `zone` = 'firiona' THEN 7383
  WHEN `zone` = 'overthere' THEN 7384
  WHEN `zone` = 'timorous' THEN 7385
  WHEN `zone` = 'iceclad' THEN 7386
END
WHERE `launcher` = 'boats';

-- Rules
UPDATE `rule_values` SET `rule_value` = 100 WHERE `rule_name` = "World:AddMaxClientsPerIP";
UPDATE `rule_values` SET `rule_value` = 100 WHERE `rule_name` = "World:MaxClientsPerIP";
UPDATE `rule_values` SET `rule_value` = 1 WHERE `rule_name` = "Chat:GlobalChatLevelLimit";
UPDATE `rule_values` SET `rule_value` = 50 WHERE `rule_name` = "Character:MaxBetaBuffLevel";
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