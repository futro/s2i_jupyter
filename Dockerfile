FROM python:3.7-slim-buster


USER root

RUN apt update && \
    apt install -y --no-install-recommends \
                   sudo python3-dev python3-pip && apt-get install libpq-dev -y --no-install-recommends &&\
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* 

RUN pip3 install --upgrade pip && \
    pip3 install setuptools wheel numpy scipy flask flask-restful \
                 gunicorn marshmallow webargs requests cloudpickle confluent-kafka kafka-python \
                 tensorflow==2.2.0 tensorflow_probability==0.10.1 \
                 mlflow boto3 psycopg2 sklearn jupyter --no-cache-dir --user
 
 # Port
EXPOSE 8080

CMD ["jupyter", "notebook", "--port=8080", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
