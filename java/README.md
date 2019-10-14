## Java info ##

1. Show java install path, run cmd on the below:
/usr/libexec/java_home -V

Output is: /Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home

2. 
export JAVA_HOME=/home/zj/apps/jdk1.8.0_221
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

resource /etc/bash.bashrc