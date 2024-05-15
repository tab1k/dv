FROM python:3

# Установка переменных окружения для Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Установка ключей и обновление системы
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F8D2585B8783D481 && \
    apt-get update && \
    apt-get install -y --no-install-recommends libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Установка рабочей директории
WORKDIR /code/dvc

# Копирование и установка зависимостей
COPY requirements.txt /code/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /code/requirements.txt && \
    pip install Pillow psycopg2

# Копирование исходного кода проекта
COPY . /code/dvc

# Открытие порта
EXPOSE 8000

# Копирование и настройка скрипта entrypoint
COPY ./docker-entrypoint.sh /code/dvc/docker-entrypoint.sh
RUN chmod +x /code/dvc/docker-entrypoint.sh

# Запуск приложения
CMD ["/code/dvc/docker-entrypoint.sh"]
