#FROM python:3.7-slim-buster

FROM jupyter/tensorflow-notebook

USER root

#RUN mkdir /maas

#WORKDIR /maas

#RUN apt update && \
#    apt install -y --no-install-recommends \
#                   sudo python3-dev python3-pip &&\
#    apt autoremove -y && \
#    rm -rf /var/lib/apt/lists/* 

#RUN pip3 install --upgrade pip && \
#    pip3 install setuptools wheel numpy scipy flask flask-restful \
#                 gunicorn marshmallow webargs requests cloudpickle confluent-kafka kafka-python \
#                 tensorflow==2.2.0 tensorflow_probability==0.10.1 \
#                 mlflow boto3 psycopg2 sklearn jupyter --no-cache-dir --user
#    pip3 install jupyter --no-cache-dir
 # Port
EXPOSE 8080

RUN pip3 install confluent-kafka kafka-python --user

#ENV PATH=/root/.local/bin:${PATH}

RUN chgrp -R 0 /home/jovyan/ && \
    chmod -R g+rwX /home/jovyan/ # && \
#    cd /maas


RUN echo "c.NotebookApp.token = '7f2e30bbad3eda5709ca54f91d6aa653ca2ea065caa9bde1'" > /home/jovyan/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = u'7f2e30bbad3eda5709ca54f91d6aa653ca2ea065caa9bde1'" >> /home/jovyan/jupyter_notebook_config.py


CMD ["jupyter", "notebook", "-p 8080:8080", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token='maasToken'", "--NotebookApp.password='maasToken'"] 
#, "--allow-root"
#RUN jupyter notebook --port=8080 --no-browser --ip=0.0.0.0 --allow-root


######



