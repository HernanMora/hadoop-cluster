FROM ubuntu:16.04

ENV MASTER false

USER root

# Install openssh-server, openjdk and wget
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget vim \
    libsnappy1v5 libsnappy-dev iputils-ping telnetd net-tools whois

ENV HADOOP_VERSION 2.9.2
ENV CLUSTER_NAME local
# Set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV PATH $PATH:$JAVA_HOME/bin

ENV HADOOP_HOME /usr/local/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native

# Install hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz ; \
    tar -xzvf hadoop-$HADOOP_VERSION.tar.gz ; \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME ; \
    rm hadoop-$HADOOP_VERSION.tar.gz

RUN ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -P "" ; \
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

ADD config/ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN groupadd supergroup

RUN mkdir -p /data/namenode; \ 
    mkdir -p /data/datanode; \
    mkdir $HADOOP_HOME/logs

VOLUME [ "/data" ]

ADD etc/* $HADOOP_HOME/etc/hadoop/

ADD config/bootstrap.sh /etc/bootstrap.sh
ADD config/configure.sh /etc/configure.sh

RUN chown root:root /etc/bootstrap.sh /etc/configure.sh ; \
    chmod 700 /etc/bootstrap.sh ; \
    chmod 700 /etc/configure.sh    

RUN ulimit -n 8192

RUN chmod +x $HADOOP_HOME/sbin/start-dfs.sh ; \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

EXPOSE 8088 50070

WORKDIR $HADOOP_HOME

CMD ["/etc/bootstrap.sh"]