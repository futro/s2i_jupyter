#FROM python:3.7-slim-buster


#USER root

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
#    pip3 install jupyter --no-cache-dir --user
 # Port
#EXPOSE 8080

#ENV PATH=/root/.local/bin:${PATH}

#CMD ["jupyter", "notebook", "--port=8080", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
#RUN jupyter notebook --port=8080 --no-browser --ip=0.0.0.0 --allow-root


######

FROM jupyter/scipy-notebook


EXPOSE 8080

RUN set -ex \
   && conda install --quiet --yes \
   # choose the Python packages you need
   'plotly==4.9.0' \
   'folium==0.11.0' \
   && conda clean --all -f -y \
   # install Jupyter Lab extensions you need
   && jupyter labextension install jupyterlab-plotly@4.9.0 --no-build \
   && jupyter lab build -y \
   && jupyter lab clean -y \
   && rm -rf "/home/${NB_USER}/.cache/yarn" \
   && rm -rf "/home/${NB_USER}/.node-gyp" \
   && fix-permissions "${CONDA_DIR}" \
   && fix-permissions "/home/${NB_USER}"

