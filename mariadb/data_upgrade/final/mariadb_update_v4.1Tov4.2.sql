alter table facecompare.rxkk_warning add column if not exists monitor_message varchar(4000);
alter table facecompare.rxkk_warning add column if not exists nation varchar(100);
alter table facecompare.rxkk_warning add column if not exists sex enum('male','female','unknown') DEFAULT 'unknown';
alter table facecompare.rxkk_warning add column if not exists age int;
ALTER TABLE facecompare.t_employee MODIFY COLUMN IF EXISTS start_date timestamp(0) NULL DEFAULT NULL COMMENT '入职时间' AFTER status;

INSERT IGNORE INTO facecompare.rxkk_system_setting (`id`, `company_id`, `name`, `code`, `value`, `remark`, `data_status`, `creator_id`, `create_time`, `modifier_id`, `modify_time`) VALUES (26, '1', '是否保存基础告警数据', 'saveBaseWarning', 'true', NULL, 'Valid', '1', '2018-2-27 10:10:10', '1', '2018-2-27 10:10:10');

ALTER TABLE facecompare.rxkk_warning  ADD COLUMN IF NOT EXISTS left_locator double DEFAULT NULL COMMENT '抓拍相对left 坐标';
ALTER TABLE facecompare.rxkk_warning  ADD COLUMN IF NOT EXISTS top_locator double DEFAULT NULL COMMENT '抓拍相对top 坐标';
ALTER TABLE facecompare.rxkk_warning  ADD COLUMN IF NOT EXISTS body_width double DEFAULT NULL COMMENT '抓拍body width';
ALTER TABLE facecompare.rxkk_warning  ADD COLUMN IF NOT EXISTS body_height double DEFAULT NULL COMMENT '抓拍body height';

CREATE TABLE IF NOT EXISTS facecompare.fc_camera (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键、相机的ID。',
	`name` varchar(64) NOT NULL COMMENT '相机名称。',
	`core_id` varchar(40) DEFAULT NULL COMMENT '相机对应Core服务产生的ID。',
	`core_album_id` varchar(40) DEFAULT NULL,
	`core_face_group_id` varchar(40) DEFAULT NULL,
	`dept_id` varchar(40) DEFAULT NULL COMMENT '相机所属部门的ID。',
	`resolution` tinyint(1) NOT NULL DEFAULT 0 COMMENT '分辨率，记录相机 高、中、低 三种级别清晰度。0-低；1- 中；2-高',
	`location` varchar(255) DEFAULT NULL COMMENT '相机的位置描述。',
	`lon` varchar(20) DEFAULT NULL COMMENT '相机的地理经度。',
	`lat` varchar(20) DEFAULT NULL COMMENT '相机的地理纬度。',
	`url` text DEFAULT NULL COMMENT '相机网络地址URL。',
	`closed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0开启 1关闭',
	`status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '相机状态。0-未知；1-正常；2-异常',
	`type` tinyint(1) NOT NULL COMMENT '相机类型 0 - 视频流相机；1 - 抓拍机；',
	`remark` varchar(255) DEFAULT NULL COMMENT '相机备注信息。',
	`valid` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否有效 0 - 已删除；1 - 未删除；',
	`time` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '记录相机时间，暂未定是创建时间还是修改时间，需因业务灵活变动。',
	`user_id` varchar(36) DEFAULT NULL,
	`status_periods_sync` int(2) NOT NULL DEFAULT 10,
	`roi` text DEFAULT NULL,
	`face` tinyint(1) DEFAULT 1,
	`face_ttl` int(11) DEFAULT -1 COMMENT 'ttl 存储时长，默认不超时',
	`face_path` varchar(255) DEFAULT 'system' COMMENT '存储路径，默认系统',
	`full` tinyint(1) DEFAULT 1,
	`full_ttl` int(11) DEFAULT NULL,
	`full_path` varchar(255) DEFAULT 'system',
	`video` tinyint(1) DEFAULT 1,
	`video_ttl` int(11) DEFAULT -1,
	`video_before` int(3) DEFAULT 0,
	`video_after` int(3) DEFAULT 0,
	`video_path` varchar(255) DEFAULT 'system',
	`low_quality` tinyint(1) DEFAULT 0,
	`low_quality_use` tinyint(1) DEFAULT 0,
	`low_quality_ttl` int(11) DEFAULT NULL,
	`low_quality_path` varchar(255) DEFAULT 'system',
	`gaid` text DEFAULT NULL,
	`gbid` text DEFAULT NULL,
	PRIMARY KEY (`id`),
	UNIQUE `core_id_UNIQUE` (`core_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT '终端管理';

CREATE TABLE IF NOT EXISTS facecompare.fc_camera_auth (
	`user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
	`camera_id` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS facecompare.fc_monitor (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '布控名称',
  `type` tinyint(1) NOT NULL COMMENT '布控类型。\n0 - 临时布控；\n1 - 长期布控； ',
  `realtime_begin` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `realtime_end` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT '开始时间',
  `status` tinyint(1) DEFAULT 0 COMMENT '布控的状态。\n0 - 未布控（暂停或未开始）；\n1 - 布控中；\n2 - 已结束；',
  `valid` tinyint(1) DEFAULT NULL COMMENT '记录数据删除状态。\n0 - 关闭；\n1 - 开启；',
  `user_id` varchar(40) DEFAULT NULL,
  `time` timestamp NULL DEFAULT current_timestamp() COMMENT '创建日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='布控管理';

CREATE TABLE IF NOT EXISTS facecompare.fc_monitor_album (
  `monitor_id` bigint(20) unsigned NOT NULL,
  `album_id` bigint(20) unsigned NOT NULL COMMENT '底库编号',
  PRIMARY KEY (`monitor_id`,`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='布控与底库关联表';

CREATE TABLE IF NOT EXISTS facecompare.fc_monitor_camera (
  `monitor_id` bigint(20) unsigned NOT NULL,
  `camera_id` bigint(20) unsigned NOT NULL COMMENT '相机ID',
  PRIMARY KEY (`monitor_id`,`camera_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='布控与相机关联表';

ALTER TABLE facecompare.rxkk_warning MODIFY COLUMN IF EXISTS `capture_time`  timestamp NULL DEFAULT NULL COMMENT '抓拍告警时间' AFTER `suspect_card`;
ALTER TABLE facecompare.rxkk_warning MODIFY COLUMN IF EXISTS `create_time`  timestamp NULL DEFAULT CURRENT_TIMESTAMP AFTER `company_id`;
ALTER TABLE facecompare.rxkk_victory MODIFY COLUMN IF EXISTS `id`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '出警ID' FIRST ;

ALTER TABLE facecompare.video_retrieval_job ADD COLUMN IF NOT EXISTS `mime_type` varchar(255) AFTER `db_type`;
ALTER TABLE facecompare.video_retrieval_job ADD COLUMN IF NOT EXISTS `download_url` varchar(255) AFTER `mime_type`;
ALTER TABLE facecompare.video_retrieval_job ADD COLUMN IF NOT EXISTS `size` bigint(150) AFTER `download_url`;

INSERT IGNORE INTO facecompare.rxkk_system_setting (`id`, `company_id`, `name`, `code`, `value`, `remark`, `data_status`, `creator_id`, `create_time`, `modifier_id`, `modify_time`) VALUES (28, '1', '人像检索请求core记录数', 'coreLimit', '1000', '用于单人检索、多人检索，限制请求core的返回结果条数', 'Valid', '1', '2018-2-27 10:10:10', '1', '2018-2-27 10:10:10');
INSERT IGNORE INTO facecompare.rxkk_system_setting (`id`, `company_id`, `name`, `code`, `value`, `remark`, `data_status`, `creator_id`, `create_time`, `modifier_id`, `modify_time`) VALUES (29, '1', '人像检索返回前端记录数', 'viewLimit', '100', '用于单人检索、多人检索，限制返回前端页面展示结果条数', 'Valid', '1', '2018-2-27 10:10:10', '1', '2018-2-27 10:10:10');

ALTER TABLE facecompare.rxkk_photo_album ADD COLUMN IF NOT EXISTS parent_id BIGINT (20) NULL;
ALTER TABLE facecompare.rxkk_photo_album ADD COLUMN IF NOT EXISTS is_dir TINYINT NULL;
ALTER TABLE facecompare.rxkk_photo_album ADD COLUMN IF NOT EXISTS order_num INT NULL;
SET @r:=0;
UPDATE facecompare.rxkk_photo_album SET order_num=(@r:=@r+1) where id<>0;
UPDATE facecompare.rxkk_photo_album SET is_dir=0, parent_id=0 where id<>0;
INSERT IGNORE INTO facecompare.rxkk_photo_album (name,is_dir,company_id,data_status,creator_id,create_time,modifier_id,modify_time,order_num) VALUES ("全部",1,1,'Valid','111111',SYSDATE(),'111111',SYSDATE(),0);
UPDATE facecompare.rxkk_photo_album SET id=0 where is_dir=1;
DELETE FROM facecompare.rxkk_warning_voice;


ALTER TABLE facecompare.rxkk_photo_album  DROP INDEX IF EXISTS name_index;
CREATE UNIQUE INDEX IF NOT EXISTS name_index USING BTREE ON facecompare.rxkk_photo_album (`name`,`is_dir`);
INSERT INTO facecompare.fc_camera (id, `name`, core_id, core_album_id, core_face_group_id, dept_id , resolution, location, lon, lat, url , STATUS, type, remark, valid, user_id) 
SELECT id, `name`, core_id, photo_album_core_id, photo_album_face_groups_id, area_id , CASE  WHEN resolution = 'HIGH' THEN 2 WHEN resolution = 'LOW' THEN 0 WHEN resolution = 'MEDIUM' THEN 1 ELSE 0 END AS resolution, lication , CASE  WHEN lon <> '' THEN lon ELSE NULL END AS lon , CASE  WHEN lat <> '' THEN lat ELSE NULL END AS lat, video_url , CASE  WHEN STATUS = 'usable' THEN 1 WHEN STATUS = 'disable' THEN 0 WHEN STATUS = 'malfunction' THEN 2 WHEN STATUS = 'alarm' THEN 2 ELSE 1 END AS STATUS , CASE  WHEN video_type = 'camera' THEN 0 ELSE 1 END AS type, remark , CASE  WHEN data_status = 'Valid' THEN 1 ELSE 0 END AS valid, creator_id FROM facecompare.rxkk_terminal;

INSERT INTO facecompare.fc_monitor (id, `name`, `type`, realtime_begin, realtime_end , status, valid, user_id, time, remark) 
SELECT id, `name` , CASE control_category WHEN 'realtime' THEN 0 WHEN 'forever' THEN 1 END, realtime_begin_time, realtime_end_time , CASE realtime_state WHEN 'not' THEN 0 WHEN 'running' THEN 1 WHEN 'end' THEN 2 END , CASE realtime_state WHEN 'running' THEN 1 ELSE 0 END, creator_id, create_time, remark FROM facecompare.rxkk_control_management WHERE data_status = "Valid";
INSERT INTO facecompare.fc_monitor_album (monitor_id, album_id) 
SELECT control_management_id,photo_album_id FROM facecompare.rxkk_control_managemenrt_photo_album;
INSERT INTO facecompare.fc_monitor_camera (monitor_id, camera_id) 
SELECT control_management_id,terminal_id FROM facecompare.rxkk_control_managemenrt_terminal;
UPDATE facecompare.rxkk_photo_album SET voice_id = 1222;
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
DELETE FROM facecompare.rxkk_terminal;

DELETE FROM facecompare.rxkk_control_management;
DELETE FROM facecompare.rxkk_control_managemenrt_photo_album;
DELETE FROM facecompare.rxkk_control_managemenrt_terminal;
DELETE FROM facecompare.rxkk_core_setting;
