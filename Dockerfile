FROM python:3

# Добавление ключей для bookworm
RUN apt-get update && apt-get install -y wget && \
    wget -O /usr/share/keyrings/debian-archive-keyring.gpg https://deb.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2021.1_all.deb

# Установка необходимых пакетов и зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Установка зависимостей Python
COPY requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip && pip install -r /code/requirements.txt

# Копирование приложения в контейнер
COPY . /code/dvc
WORKDIR /code/dvc

# Настройка точки входа и команды для контейнера
COPY ./docker-entrypoint.sh /code/dvc/docker-entrypoint.sh
RUN chmod +x /code/dvc/docker-entrypoint.sh
EXPOSE 8000
CMD ["/code/dvc/docker-entrypoint.sh"]

