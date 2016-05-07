FROM ubuntu:14.04

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
      apt-get -y upgrade && \
        apt-get install -y build-essential && \
          apt-get install -y software-properties-common && \
            apt-get install -y python-dev && \
              apt-get install -y byobu curl git htop man unzip vim wget && \
                rm -rf /var/lib/apt/lists/*

ADD install.sh /usr/src/
RUN chmod 755 /usr/src/install.sh
RUN apt-get update
RUN /usr/src/install.sh
RUN apt-get -y install python-pip
RUN pip install ipython pyzmq tornado
RUN cd /src/tools/cling/tools/Jupyter/kernel && pip install -e .
RUN pip install --upgrade notebook
CMD jupyter-notebook
