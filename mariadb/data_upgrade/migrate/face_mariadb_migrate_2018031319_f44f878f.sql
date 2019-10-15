INSERT INTO facecompare.fc_camera (id, `name`, core_id, core_album_id, core_face_group_id, dept_id , resolution, location, lon, lat, url , STATUS, type, remark, valid, user_id) 
SELECT id, `name`, core_id, photo_album_core_id, photo_album_face_groups_id, area_id , CASE  WHEN resolution = 'HIGH' THEN 2 WHEN resolution = 'LOW' THEN 0 WHEN resolution = 'MEDIUM' THEN 1 ELSE 0 END AS resolution, lication , CASE  WHEN lon <> '' THEN lon ELSE NULL END AS lon , CASE  WHEN lat <> '' THEN lat ELSE NULL END AS lat, video_url , CASE  WHEN STATUS = 'usable' THEN 1 WHEN STATUS = 'disable' THEN 0 WHEN STATUS = 'malfunction' THEN 2 WHEN STATUS = 'alarm' THEN 2 ELSE 1 END AS STATUS , CASE  WHEN video_type = 'camera' THEN 0 ELSE 1 END AS type, remark , CASE  WHEN data_status = 'Valid' THEN 1 ELSE 0 END AS valid, creator_id FROM facecompare.rxkk_terminal;

INSERT INTO facecompare.fc_monitor (id, `name`, `type`, realtime_begin, realtime_end , status, valid, user_id, time, remark) 
SELECT id, `name` , CASE control_category WHEN 'realtime' THEN 0 WHEN 'forever' THEN 1 END, realtime_begin_time, realtime_end_time , CASE realtime_state WHEN 'not' THEN 0 WHEN 'running' THEN 1 WHEN 'end' THEN 2 END , CASE realtime_state WHEN 'running' THEN 1 ELSE 0 END, creator_id, create_time, remark FROM facecompare.rxkk_control_management WHERE data_status = "Valid";
INSERT INTO facecompare.fc_monitor_album (monitor_id, album_id) 
SELECT control_management_id,photo_album_id FROM facecompare.rxkk_control_managemenrt_photo_album;
INSERT INTO facecompare.fc_monitor_camera (monitor_id, camera_id) 
SELECT control_management_id,terminal_id FROM facecompare.rxkk_control_managemenrt_terminal;
UPDATE facecompare.rxkk_photo_album SET voice_id = 1222;