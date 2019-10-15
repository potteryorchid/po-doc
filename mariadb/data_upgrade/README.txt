初始化依赖基础镜像

mariadb_baseimg:
ampregistry:5000/sng-biz-facecompare-mariadb:1.0.17121515-f6a4303d-beta
mongo_baseimg:
ampregistry:5000/sng-biz-facecompare-mongodb:1.0.17121515-f6a4303d-beta

v4.1
mariadb:  1.0.18011220-6ee5e90b-180112203046-beta
mongo:  1.0.18010919-0bc9c005-180109192257-beta


数据表结构升级步骤：
1、连接到数据库。
2、按时间顺序依次执行face_mariadb_*.sql 和 face_mongodb_*.sh文件内数据库脚本。


数据迁移脚本使用说明
1、./migrate 文件夹下脚本文件分两类，一类文件名称带有“delete”，一类没有。
2、各类文件按文件名中时间部分先后顺序执行。
3、先执行不带“delete”的脚本，完成数据迁移升级。
4、测试系统，各功能都可以正常运行后，执行带“delete”的脚本，删除过期数据。


final
该目录下存放最终生成的升级镜像脚本。
