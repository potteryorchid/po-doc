alter table facecompare.fc_camera drop column if exists url_picture;
alter table facecompare.fc_camera modify IF EXISTS url text default null COMMENT '图片流地址（抓拍机）';
alter table facecompare.fc_camera modify IF EXISTS roi text default null;
alter table facecompare.fc_camera modify IF EXISTS low_quality tinyint(1) default 0;
alter table facecompare.fc_camera modify IF EXISTS low_quality_use tinyint(1) default 0;