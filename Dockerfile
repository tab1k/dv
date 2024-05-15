FROM python:3

# Установка публичных ключей Debian
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg && \
    apt-key adv --fetch-keys https://deb.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2021.1_all.deb

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Установка зависимостей Python
RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Копирование и установка Python зависимостей
WORKDIR /code/dvc
COPY requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip
RUN pip install -r /code/requirements.txt
RUN pip3 install Pillow psycopg2

# Копирование приложения в контейнер
COPY . /code/dvc

# Настройка точки входа и команды для контейнера
COPY ./docker-entrypoint.sh /code/dvc/docker-entrypoint.sh
RUN chmod +x /code/dvc/docker-entrypoint.sh
EXPOSE 8000
CMD ["/code/dvc/docker-entrypoint.sh"]

