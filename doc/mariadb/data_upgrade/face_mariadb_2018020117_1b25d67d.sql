alter table facecompare.rxkk_warning add column if not exists monitor_message varchar(4000);
alter table facecompare.rxkk_warning add column if not exists nation varchar(100);
alter table facecompare.rxkk_warning add column if not exists sex enum('male','female','unknown') DEFAULT 'unknown';
alter table facecompare.rxkk_warning add column if not exists age int;