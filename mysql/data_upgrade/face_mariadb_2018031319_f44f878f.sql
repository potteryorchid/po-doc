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


