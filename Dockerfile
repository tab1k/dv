FROM python:3

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update

WORKDIR /code/dvc


COPY requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip
RUN pip install -r /code/requirements.txt
RUN pip3 install Pillow psycopg2


COPY . /code/dvc

EXPOSE 8000

COPY ./docker-entrypoint.sh /code/dvc/docker-entrypoint.sh

RUN chmod +x /code/dvc/docker-entrypoint.sh

CMD ["/code/dvc/docker-entrypoint.sh"]