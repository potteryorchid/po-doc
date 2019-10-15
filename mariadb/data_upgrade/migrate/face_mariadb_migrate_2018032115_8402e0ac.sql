ALTER TABLE `facecompare`.`rxkk_warning` CHANGE COLUMN `warning_result` `warning_result` enum('Deassert','Police','Report','Not','Revoke','Warn','Other','Confirm','Arrested','unProcess','lifted','unPolice','Warned','Revoked') DEFAULT 'Not' COMMENT '处理结果（解除报警、已报告、以出警、无、已撤销、已警告、其他、已确认、已抓捕）';
update `facecompare`.`rxkk_warning` set warning_result='lifted' where warning_result='Deassert';
update `facecompare`.`rxkk_warning` set warning_result='Other' where warning_result='Report';
update `facecompare`.`rxkk_warning` set warning_result='unProcess' where warning_result='Not';
update `facecompare`.`rxkk_warning` set warning_result='Revoked' where warning_result='Revoke';
update `facecompare`.`rxkk_warning` set warning_result='Warned' where warning_result='Warn';
update `facecompare`.`rxkk_warning` set warning_result='unPolice' where warning_result='Confirm';
ALTER TABLE `facecompare`.`rxkk_warning` CHANGE COLUMN `warning_result` `warning_result` enum('unProcess','lifted','unPolice','Police','Arrested','Warned','Revoked','Other') DEFAULT 'unProcess' COMMENT '处理结果unProcess(\"未处理\"), lifted(\"已解除\"), unPolice(\"未出警\"), Police(\"已出警\"), Arrested(\"已抓捕\"), Warned(\"已警告\"), Revoked(\"已撤销\"), Other(\"其他\")';


ALTER TABLE `facecompare`.`rxkk_warning` CHANGE COLUMN if EXISTS `warning_result` `warning_result` enum('unProcess','lifted','confirmed','Police','Arrested','Warned','Revoked','Other','unPolice') DEFAULT 'unProcess' COMMENT '处理结果unProcess(\"未处理\"), lifted(\"已解除\"), unPolice(\"未出警\"), Police(\"已出警\"), Arrested(\"已抓捕\"), Warned(\"已警告\"), Revoked(\"已撤销\"), Other(\"其他\")';
update `facecompare`.`rxkk_warning` set warning_result='confirmed' where warning_result='unPolice';
ALTER TABLE `facecompare`.`rxkk_warning` CHANGE COLUMN if EXISTS `warning_result` `warning_result` enum('unProcess','lifted','confirmed','Police','Arrested','Warned','Revoked','Other') DEFAULT 'unProcess' COMMENT '处理结果unProcess(\"未处理\"), lifted(\"已解除\"), unPolice(\"未出警\"), Police(\"已出警\"), Arrested(\"已抓捕\"), Warned(\"已警告\"), Revoked(\"已撤销\"), Other(\"其他\")';


ALTER TABLE `facecompare`.`rxkk_victory` CHANGE COLUMN if EXISTS `police_result` `police_result` enum('UnArrested','Arrested','Revoke','Warn','Other','Revoked','Warned') DEFAULT 'Other' COMMENT '出警结果（未抓捕、已抓捕、已撤销、已警告、其他）';

UPDATE `facecompare`.`rxkk_victory` set police_result='Arrested' where police_result='Revoke';
UPDATE `facecompare`.`rxkk_victory` set police_result='Warned' where police_result='Warn';
UPDATE `facecompare`.`rxkk_victory` set police_result='Other' where police_result='UnArrested';

ALTER TABLE `facecompare`.`rxkk_victory` CHANGE COLUMN if EXISTS `police_result` `police_result` enum('Arrested','Revoked','Warned','Other') DEFAULT 'Other' COMMENT '出警结果（已抓捕、已撤销、已警告、其他）';
