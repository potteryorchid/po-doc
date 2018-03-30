ALTER TABLE facecompare.rxkk_photo_album  DROP INDEX IF EXISTS name_index;
CREATE UNIQUE INDEX IF NOT EXISTS name_index USING BTREE ON facecompare.rxkk_photo_album (`name`,`is_dir`);