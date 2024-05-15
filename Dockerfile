# Используем базовый образ Python 3
FROM python:3

# Определяем переменные среды для настройки Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Обновляем пакеты внутри контейнера
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Создаем и переходим в рабочую директорию
WORKDIR /code/dvc

# Копируем файл requirements.txt и устанавливаем зависимости
COPY requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip && pip install -r /code/requirements.txt && pip3 install Pillow psycopg2

# Копируем остальные файлы проекта в контейнер
COPY . /code/dvc

# Открываем порт 8000
EXPOSE 8000

# Копируем файл docker-entrypoint.sh и задаем права на выполнение
COPY ./docker-entrypoint.sh /code/dvc/docker-entrypoint.sh
RUN chmod +x /code/dvc/docker-entrypoint.sh

# Запускаем команду по умолчанию
CMD ["/code/dvc/docker-entrypoint.sh"]
