## scala install ##
1. Run cmd: java -version, check to see if java has been installed. If the output is not show as below, please install Java first.
java version "1.8.0_141"
Java(TM) SE Runtime Environment (build 1.8.0_141-b15)
Java HotSpot(TM) 64-Bit Server VM (build 25.141-b15, mixed mode)

2. Move scala-version.tgz to the install path.

3. Swith into scala install path and decompress .tgz file.

4. Add "export SCALA_HOME=/usr/local/apps/scala-2.12.6
export PATH=$PATH:$SCALA_HOME/bin" to env config file.
mac : ~/.bash_profile

5. Run "source ~/.bash_profile" or reopen cmd window enter cmd: scala, output as below.
Welcome to Scala 2.12.6 (Java HotSpot(TM) 64-Bit Server VM, Java 1.8.0_141).
