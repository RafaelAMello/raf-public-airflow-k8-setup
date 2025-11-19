# Guide when Developing on this image: https://airflow.apache.org/docs/docker-stack/build.html.
# Make sure to use the same airflow version in the Dockerfile and values.yaml.
# Search for the above test
FROM apache/airflow:slim-3.1.0

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Requirements.txt
COPY requirements.txt ${AIRFLOW_HOME}/requirements.txt
RUN uv pip install -r ${AIRFLOW_HOME}/requirements.txt

COPY ./dags/ ${AIRFLOW_HOME}/dags/

RUN mkdir -p ${AIRFLOW_HOME}/config