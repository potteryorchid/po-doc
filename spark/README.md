### For spark install config ###

1、下载spark安装包；

2、将安装包解压到安装目录，建议目录 /usr/local/apps/ ;

3、在profile文件中配置环境变量；(mac为.bash_profile文件)
export SPARK_HOME=/usr/local/apps/spark-2.3.1-out-hadoop
export PATH=$PATH:$SPARK_HOME/bin

4、Run "source ~/.bash_profile" cmd.
