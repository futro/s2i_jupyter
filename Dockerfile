FROM jupyter/minimal-notebook:latest

# Switch to the root user so we can install additional packages.

USER root

# Install additional libraries required by Python packages which are in
# the minimal base image. Also install 'rsync' so the 'oc rsync' command
# can be used to copy files into the running container.

RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip && \
    pip3 install setuptools wheel numpy scipy flask flask-restful \
                 gunicorn marshmallow webargs requests cloudpickle confluent-kafka kafka-python \
                 tensorflow==2.2.0 tensorflow_probability==0.10.1 \
                 mlflow boto3 psycopg2 sklearn


# Add labels so OpenShift recognises this as an S2I builder image.
