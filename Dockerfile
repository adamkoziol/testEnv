FROM test/spades_pipeline:v8

MAINTAINER Dr. Adam G. Koziol <adam.koziol@inspection.gc.ca>

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt/sources.list

#RUN apt-get update -y
#RUN apt-get upgrade -y

# Install BLAST toolkit
#RUN apt-get install -y python
#RUN apt-get install -y ncbi-blast+
#RUN apt-get install -y samtools

#RUN apt-get install -y apache2 openssh-server

#RUN mkdir /var/run/sshd
#RUN echo 'root:screencast' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

## Install an SSH of your choice.
#ADD devEnv.key /tmp/devEnv.key
#RUN cat /tmp/devEnv.key >> /root/.ssh/authorized_keys && rm -f /tmp/devEnv.key


RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:biohazard' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile




RUN a2enmod cgid


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


#COPY default /etc/apache2/sites-available/000-default.conf
#COPY referenceGenomes/ /spades_pipeline/SPAdesPipelineFiles/referenceGenomes/
#COPY rMLST/ /spades_pipeline/SPAdesPipelineFiles/rMLST/
#COPY Pipeline/ /spades_pipeline/Pipeline/
#COPY 2014-07-30/ /spades_pipeline/2014-07-30
#COPY 2014-09-30/ /spades_pipeline/2014-09-30
#VOLUME ["/home/blais/SPAdesDocker/2014-09-30", "/spades_pipeline/2014-09-30"]
#VOLUME ["/home/blais/SPAdesDocker/Pipeline/", "/spades_pipeline/Pipeline/"]
#VOLUME ["/home/blais/SPAdesDocker/referenceGenomes/", "/spades_pipeline/SPAdesPipelineFiles/referenceGenomes/"]
#VOLUME ["/home/blais/SPAdesDocker/rMLST/", "/spades_pipeline/SPAdesPipelineFiles/rMLST/"]
#COPY start.sh /spades_pipeline/start.sh

EXPOSE 80
EXPOSE 22
#CMD ["/spades_pipeline/start.sh"]
CMD ["/usr/sbin/sshd", "-D"]
