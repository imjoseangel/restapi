# My API  Dockerfie
FROM centos:7
LABEL maintainer="imjoseangel"

ARG appname=restapi

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN mkdir -p /opt/${appname}

RUN yum -y install epel-release && yum clean all
RUN yum -y install python-pip && yum clean all

WORKDIR /opt/${appname}

ADD build_database.py build_database.py
ADD config.py config.py
ADD inventory.py inventory.py
ADD models.py models.py
ADD server.py server.py
ADD ui.py ui.py
ADD swagger.yml swagger.yml

RUN pip install --upgrade pip
RUN pip install connexion
RUN pip install flask_sqlalchemy
RUN pip install flask_marshmallow
RUN pip install marshmallow-sqlalchemy

RUN python build_database.py

EXPOSE 5000

CMD ["python", "/opt/restapi/server.py"]
