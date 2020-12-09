# My API  Dockerfie
FROM ubuntu:latest
LABEL maintainer="imjoseangel"

ARG appname=restapi

RUN mkdir -p /opt/${appname}


RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y python3-pip

WORKDIR /opt/${appname}

ADD build_database.py build_database.py
ADD config.py config.py
ADD inventory.py inventory.py
ADD models.py models.py
ADD server.py server.py
ADD ui.py ui.py
ADD swagger.yml swagger.yml
ADD requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

RUN python3 build_database.py

EXPOSE 5000

CMD ["python3", "/opt/restapi/server.py"]
