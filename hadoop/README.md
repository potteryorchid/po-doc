## Hadoop ##

# Hadoop env config(如果需要经常命令交互可以配置环境变量，否则不需要配置，环境变量只是方便在任何目录下输入Hadoop命令)
1. Add "export HADOOP_HOME=/usr/local/apps/hadoop-2.7.6
export PATH=$PATH:$HADOOP_HOME/bin" to env config file.
mac : ~/.bash_profile

2. Run "source ~/.bash_profile" or reopen cmd window.

# Standalone config
1. 下载安装包，解压到安装目录。

2. 修改".../apps/hadoop-2.7.6/etc/hadoop"目录下 hadoop-env.sh 文件, 将$JAVA_HOME 替换成java的安装目录全路径.
mac 下查看java安装路径的cmd为：/usr/libexec/java_home -V

# Pseudo-Distributed 伪分布
1. etc/hadoop/core-site.xml 配置client连接信息
<configuration>
   <property>
	  <name>fs.default.name </name>
      <value> hdfs://localhost:9000 </value> 
   </property>		   
</configuration>

2. etc/hadoop/hdfs-site.xml 配置hdfs存储基本信息
<configuration>
   <property>
      <!--节点数量-->
	  <name>dfs.replication</name>
	  <value>1</value>
   </property>	      
   
   <property>
      <!--namenode 存储目录-->
   	  <name>dfs.name.dir</name>
      <value>/Users/zj/Documents/repo/tmp/hdfs/namenode </value>
   </property>
										    
   <property>
      <!--datanode 存储目录-->
	  <name>dfs.data.dir</name> 
      <value>/Users/zj/Documents/repo/tmp/hdfs/datanode </value> 
   </property>
</configuration>

3. YARN on a Single Node
--etc/hadoop/mapred-site.xml
<configuration>
   <property>
	   <name>mapreduce.framework.name</name>
       <value>yarn</value>
   </property>
</configuration>

--etc/hadoop/yarn-site.xml
<configuration>
   <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
   </property>
</configuration>

4. CMD reference
--YARN
- Start ResourceManager daemon and NodeManager daemon: $ sbin/start-yarn.sh
- Browse the web interface for the ResourceManager, by default it is available at: http://localhost:8088/
- Stop the daemons with: $ sbin/stop-yarn.sh

--HDFS
- Format the filesystem: $ bin/hdfs namenode -format
- Start NameNode daemon and DataNode daemon: $ sbin/start-dfs.sh
- Browse the web interface for the NameNode, by default it is available at: NameNode - http://localhost:50070/
- Stop the daemons with: $ sbin/stop-dfs.sh
